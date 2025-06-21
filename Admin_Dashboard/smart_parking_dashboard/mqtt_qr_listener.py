import paho.mqtt.client as mqtt
import mysql.connector
import json
import cv2
import pyzbar.pyzbar as pyzbar
from datetime import datetime
import time

# MySQL Database Configuration
db_config = {
    "host": "18.223.180.12",
    "user": "root",
    "password": "Parking@123",
    "database": "SmartParkingSys"
}

# MQTT Configuration
MQTT_BROKER = "127.0.0.1"
MQTT_PORT = 1883
MQTT_TOPIC = "esp32/parking"
MQTT_CONTROL_TOPIC = "esp32/gate/control"

# Store previous slot states to avoid duplicate updates
previous_state = {}

# Connect to MySQL
def connect_db():
    return mysql.connector.connect(**db_config)

# MQTT: On connect
def on_connect(client, userdata, flags, rc):
    print("✅ Connected to MQTT Broker!")
    client.subscribe(MQTT_TOPIC)

# MQTT: On message
def on_message(client, userdata, msg):
    global previous_state

    try:
        data = json.loads(msg.payload.decode())
        parking_id = data.get("parking_id")
        slot1 = data.get("slot1")
        slot2 = data.get("slot2")
        slot3 = data.get("slot3")
        gate = data.get("gate")

        if parking_id is None:
            print("❌ Missing 'parking_id'.")
            return

        if parking_id not in previous_state or (
            slot1 != previous_state[parking_id].get("slot1") or
            slot2 != previous_state[parking_id].get("slot2") or
            slot3 != previous_state[parking_id].get("slot3") or
            gate != previous_state[parking_id].get("gate")
        ):
            db = connect_db()
            cursor = db.cursor()
            slots = [
                (parking_id, "SLO1", slot1),
                (parking_id, "SLO2", slot2),
                (parking_id, "SLO3", slot3),
                (parking_id, "Gate1", gate)
            ]
            for parking_id, slot_number, status in slots:
                cursor.execute("""
                    INSERT INTO parking_slots (parking_id, slot_number, status, last_updated)
                    VALUES (%s, %s, %s, NOW())
                    ON DUPLICATE KEY UPDATE status = VALUES(status), last_updated = NOW();
                """, (parking_id, slot_number, status))
            db.commit()
            cursor.close()
            db.close()

            previous_state[parking_id] = {
                "slot1": slot1,
                "slot2": slot2,
                "slot3": slot3,
                "gate": gate
            }

            print(f"📥 Updated parking {parking_id} data.")
    except Exception as e:
        print(f"❗ Error in on_message: {e}")

# Send command to ESP32 to open gate
def send_gate_command(command):
    client.publish(MQTT_CONTROL_TOPIC, json.dumps({"command": command}))
    print(f"🚪 Gate command sent: {command}")

# QR code scanner with cooldown logic
def scan_qr_code():
    cap = cv2.VideoCapture(0)
    last_scanned = ""
    last_scanned_time = 0
    cooldown = 20  # seconds

    while True:
        ret, frame = cap.read()
        if not ret:
            continue

        decoded_objects = pyzbar.decode(frame)
        for obj in decoded_objects:
            qr_data = obj.data.decode("utf-8")

            current_time = time.time()
            if qr_data == last_scanned and current_time - last_scanned_time < cooldown:
                continue

            print(f"🔍 QR Code: {qr_data}")
            handle_qr_scan(qr_data)
            last_scanned = qr_data
            last_scanned_time = current_time

        cv2.imshow("QR Code Scanner", frame)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()

# Handle QR scan logic for check-in/check-out
def handle_qr_scan(qr_data):
    try:
        db = connect_db()
        cursor = db.cursor()
        cursor.execute("SELECT status FROM bookings WHERE booking_id = %s", (qr_data,))
        result = cursor.fetchone()

        if result:
            status = result[0]
            now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

            if status == 'valid':
                cursor.execute("""
                     UPDATE bookings SET status = 'checked in', checkin_time = %s
                     WHERE booking_id = %s
                """, (now, qr_data))
                send_gate_command("open")
                print(f"✅ Booking {qr_data} checked in at {now}.")

            elif status == 'checked in':
                cursor.execute("""
                    UPDATE bookings SET status = 'checked out', checkout_time = %s
                    WHERE booking_id = %s
                """, (now, qr_data))
                send_gate_command("open")
                print(f"✅ Booking {qr_data} checked out at {now}.")

            db.commit()
        else:
            print("❌ QR Code not associated with a valid booking.")

        cursor.close()
        db.close()
    except Exception as e:
        print(f"❌ Error processing QR: {e}")

# Run listener (import and call this from Streamlit app)
def run_listener():
    global client
    client = mqtt.Client()
    client.on_connect = on_connect
    client.on_message = on_message
    client.connect(MQTT_BROKER, MQTT_PORT, 60)
    client.loop_start()

    try:
        scan_qr_code()
    except KeyboardInterrupt:
        print("🛑 QR scanner stopped.")
    finally:
        client.loop_stop()
        client.disconnect()

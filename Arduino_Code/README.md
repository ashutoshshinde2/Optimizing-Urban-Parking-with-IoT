# 🚗 Smart Parking System using ESP32 NodeMCU

This project demonstrates a smart parking system using an ESP32 NodeMCU. The system uses IR sensors to detect the availability of parking slots and a servo-controlled gate that responds to MQTT-based commands. An OLED display shows the real-time status of the parking lot.

---

## 🔧 Hardware Components Used

- ESP32 NodeMCU
- 3x IR Sensors (for slot occupancy detection)
- 1x IR Sensor (for gate trigger)
- Servo Motor (e.g., SG90)
- OLED Display (SSD1306, 128x64)
- Jumper wires
- Breadboard
- Power Supply

---

## 📡 Features

- Real-time detection of parking slot availability
- Publishes parking status to an MQTT broker
- Listens for gate control commands via MQTT
- Displays data on OLED screen
- Servo motor control for automated gate
- Unique `parking_id` identification for each node

---

## 🧠 Technologies & Libraries Used

- ESP32 NodeMCU
- Arduino C++
- MQTT Protocol via `PubSubClient`
- WiFi via ESP32 WiFi library
- OLED display using `Adafruit_SSD1306` and `Adafruit_GFX`
- Servo motor control via `ESP32Servo`

---

## 🛠️ Setup Instructions

### 1️⃣ Configure WiFi

Edit the following lines in the code:

```cpp
#define WIFI_SSID "YourSSID"
#define WIFI_PASSWORD "YourPassword"
```
### 📡 MQTT Broker Setup

To enable communication between the ESP32 and other services (like a web server), you need to configure an MQTT broker.

### 🛠 MQTT Configuration in Code

Edit these lines in your Arduino code to match your MQTT broker details:

```cpp
const char* mqtt_server = "192.168.x.x"; // Replace with your broker IP
const int mqtt_port = 1883;
const char* mqtt_topic_publish = "esp32/parking";
const char* mqtt_topic_subscribe = "esp32/gate/control";

```

### 🔌 ESP32 Pin Configuration

The following table shows how each component is connected to the ESP32 NodeMCU:

| Component        | ESP32 GPIO Pin |
|------------------|----------------|
| IR Sensor 1      | GPIO 32        |
| IR Sensor 2      | GPIO 33        |
| IR Sensor 3      | GPIO 25        |
| Gate Trigger IR  | GPIO 26        |
| Servo Motor      | GPIO 27        |
| OLED SDA         | GPIO 21        |
| OLED SCL         | GPIO 22        |

### 📦 Required Arduino Libraries

Make sure to install the following libraries using the **Arduino Library Manager** before uploading the code to your ESP32:

- [WiFi](https://www.arduino.cc/en/Reference/WiFi) — for connecting the ESP32 to WiFi
- [Wire](https://www.arduino.cc/en/Reference/Wire) — I2C communication used by the OLED display
- [PubSubClient](https://github.com/knolleary/pubsubclient) — for MQTT communication
- [Adafruit GFX Library](https://github.com/adafruit/Adafruit-GFX-Library) — graphics library for the OLED
- [Adafruit SSD1306](https://github.com/adafruit/Adafruit_SSD1306) — OLED display driver
- [ESP32Servo](https://github.com/madhephaestus/ESP32Servo) — to control the servo motor

> 💡 Tip: You can install these libraries from **Arduino IDE** via:  
> `Sketch` → `Include Library` → `Manage Libraries…`


### ⬆️ Uploading Code to ESP32

Follow these steps to upload the Arduino sketch to your ESP32:

1. **Connect** your ESP32 NodeMCU to your computer via USB.
2. **Open** the project in the Arduino IDE.
3. **Select the board**:
   - Go to `Tools` → `Board` → `ESP32 Dev Module`
4. **Select the port**:
   - Go to `Tools` → `Port` → Select the appropriate COM port for your ESP32.
5. **Install all required libraries** (see [📦 Required Arduino Libraries](#-required-arduino-libraries)).
6. Click the **✔️ Verify** button to compile the code.
7. Click the **➡️ Upload** button to flash the code to the ESP32.
8. Open the **Serial Monitor** (baud rate: `115200`) to debug and monitor system output.

> ⚠️ If you encounter upload issues, try holding the **BOOT** button on the ESP32 while clicking **Upload**, and release it once you see "Connecting..."

### 📤 MQTT Payload Format

The ESP32 publishes parking data to the MQTT topic `esp32/parking` in the following JSON format:

```json
{
  "parking_id": "1",
  "slot1": 0,
  "slot2": 1,
  "slot3": 0,
  "gate": 1
}
```
### 📺 OLED Display Output Example

The OLED display connected to the ESP32 shows real-time status of the parking slots and gate. Below is a sample output displayed on the screen:


#### 🧾 Notes:

- **"Occupied"** means a vehicle is detected in the corresponding slot.
- **"Free"** means the slot is available.
- **Gate Status** changes based on the IR gate sensor and MQTT control:
  - `Scan the QR code`: Awaiting user action
  - `Open`: Gate is opening (servo rotates)
  - `Close`: Gate is closed after vehicle passes

  ## 📩 Gate Control via MQTT

The ESP32 listens for MQTT messages on the topic `esp32/gate/control` to control the gate via a servo motor.

### ✅ To Open the Gate:

- **MQTT Topic**:  

- **MQTT Message**:  


When this message is received:
- The servo rotates to 90° (gate open)
- A variable (`x = 1`) is triggered internally
- After a car passes (detected by IR sensor), the servo rotates back to 0° (gate closed)

### 🧪 Example Using MQTT CLI

```bash
mosquitto_pub -h <broker_ip> -t esp32/gate/control -m "open"

### 🧭 System Architecture

[ IR Sensors ] → [ ESP32 NodeMCU ] → [ MQTT Broker ] ← [ Web Server / App ]
                        ↓
          [ OLED Display, Servo Motor ]


### 📘 Explanation:

- **IR Sensors**: Detect the presence of vehicles in each parking slot and at the gate. The sensor data is read by the ESP32.

- **ESP32 NodeMCU**:
  - Acts as the brain of the system.
  - Reads data from IR sensors.
  - Publishes slot status and gate status to the MQTT broker on the topic `esp32/parking`.
  - Subscribes to control commands on the topic `esp32/gate/control` (e.g., `"open"`).

- **MQTT Broker**:
  - Acts as a middleman to facilitate communication between ESP32 and external applications.
  - Can be hosted locally (e.g., Mosquitto) or on the cloud (e.g., AWS IoT).

- **Web Server / App**:
  - Subscribes to the MQTT topic to display real-time parking data to users.
  - Sends commands like `"open"` to the `esp32/gate/control` topic to remotely control the gate.

- **OLED Display**:
  - Displays real-time parking status (Free/Occupied) for each slot.
  - Also shows gate instructions like "Scan QR code", "Open", or "Close".

- **Servo Motor**:
  - Connected to the ESP32.
  - Physically opens or closes the gate based on MQTT messages and IR trigger logic.

> ✅ This modular architecture makes it easy to scale across multiple parking nodes or integrate with cloud-based dashboards and databases.


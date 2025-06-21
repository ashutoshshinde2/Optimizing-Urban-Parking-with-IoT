#include <WiFi.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <ESP32Servo.h>
#include <WiFiClient.h>
#include <PubSubClient.h>

// WiFi Credentials
#define WIFI_SSID "OnePlus"
#define WIFI_PASSWORD "12345679"

// MQTT Configuration
const char* mqtt_server = "192.168.147.252";
const int mqtt_port = 1883;
const char* mqtt_topic_publish = "esp32/parking";
const char* mqtt_topic_subscribe = "esp32/gate/control";

// Unique Parking ID
const char* PARKING_ID = "1";
int x = 0;
WiFiClient espClient;
PubSubClient client(espClient);

// OLED Display Configuration
#define OLED_ADDR 0x3C
Adafruit_SSD1306 display(128, 64, &Wire, -1);

// IR Sensor Pins
#define SLO1 32
#define SLO2 33
#define SLO3 25
#define GATE_TRIGGER 26

// Servo Motor
#define SERVO_PIN 27  // Try changing to 14 or 12
Servo gateServo;

// Connect to WiFi
void connectWiFi() {
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("Connected to WiFi!");
}

// Connect to MQTT Broker
void connectMQTT() {
  client.setServer(mqtt_server, mqtt_port);
  client.setCallback(callback);
  while (!client.connected()) {
    Serial.println("Connecting to MQTT...");
    if (client.connect("ESP32_Device")) {
      Serial.println("Connected to MQTT Broker!");
      client.subscribe(mqtt_topic_subscribe);
    } else {
      Serial.print("Failed, rc=");
      Serial.print(client.state());
      Serial.println(" retrying in 2 seconds...");
      delay(2000);
    }
  }
}

// Handle incoming MQTT messages
void callback(char* topic, byte* payload, unsigned int length) {
  String message = "";
  for (int i = 0; i < length; i++) {
    message += (char)payload[i];
  }

  Serial.print("Received MQTT message: ");
  Serial.println(message);

  if (message.indexOf("open") >= 0) {
    Serial.println("Opening Gate...");
    x = 1;
     // Open gate
  }
}

// Publish slot and gate data along with Parking ID
void publishData() {
  int slo1 = digitalRead(SLO1);
  int slo2 = digitalRead(SLO2);
  int slo3 = digitalRead(SLO3);
  int gateTrigger = digitalRead(GATE_TRIGGER);

  // JSON Payload with Parking ID
  String payload = "{\"parking_id\":\"" + String(PARKING_ID) + "\","
                                                               "\"slot1\":"
                   + String(slo1) + ","
                                    "\"slot2\":"
                   + String(slo2) + ","
                                    "\"slot3\":"
                   + String(slo3) + ","
                                    "\"gate\":"
                   + String(gateTrigger) + "}";

  client.publish(mqtt_topic_publish, payload.c_str());
  Serial.println("Published: " + payload);

  // Display status on OLED
  display.clearDisplay();
  display.setCursor(0, 0);
  display.println("Parking: " + String(PARKING_ID));
  display.println("Slot Status:");
  display.print("SLOT1: ");
  display.println(slo1 ? "Free" : "Occupied");
  display.print("SLOT2: ");
  display.println(slo2 ? "Free" : "Occupied");
  display.print("SLOT3: ");
  display.println(slo3 ? "Free" : "Occupied");
  if (gateTrigger == LOW && x == 0) {
    display.print("Gate: ");
    display.println("Scan the QR code");
  } 
  else if(x==0)
  {
    display.print("Gate: ");
    display.println("Close");
  }
  else if (gateTrigger == HIGH) {
    // Delay before showing 'Close' to give time for car to pass
    delay(500);
    display.print("Gate: ");
    display.println("Close");
    // Close gate if it's still open
    gateServo.write(0);
    x = 0;
  }
  else if (x == 1) {
    display.print("Gate: ");
    display.println("Open");
    gateServo.write(90); 
  } 
  display.display();
}

void setup() {
  Serial.begin(115200);

  // OLED Initialization
  Wire.begin(21, 22);  // SDA = 21, SCL = 22
  if (!display.begin(SSD1306_SWITCHCAPVCC, OLED_ADDR)) {
    Serial.println("OLED initialization failed");
    while (1)
      ;
  }

  display.clearDisplay();
  display.setTextColor(WHITE);
  display.setTextSize(1);
  display.display();

  // Initialize IR Sensors
  pinMode(SLO1, INPUT);
  pinMode(SLO2, INPUT);
  pinMode(SLO3, INPUT);
  pinMode(GATE_TRIGGER, INPUT);

  // Initialize Servo
  gateServo.attach(SERVO_PIN);  // Define min & max pulse width
  gateServo.write(0);           // Ensure gate starts closed
  Serial.println("Servo initialized at 0° (closed)");

  // Connect to WiFi
  connectWiFi();
  // Connect to MQTT
  connectMQTT();
}

void loop() {
  if (!client.connected()) {
    connectMQTT();
  }
  client.loop();
  publishData();
  delay(2000);  // Publish every 2 seconds
}

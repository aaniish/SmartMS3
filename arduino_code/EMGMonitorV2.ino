

// ArduinoBLE - Version: Latest 
#include <ArduinoBLE.h>

// BLE Service
BLEService emgService("dd55f584-5caa-4726-8be9-6ee6621d52b9");

// BLE Level Characteristic
BLEUnsignedCharCharacteristic emgLevelChar("6fa807df-2cf4-4e1e-915b-ad0623bf573d",  // standard 128-bit characteristic UUID
    BLERead | BLENotify); // remote clients will be able to get notifications if this characteristic changes
int emgValue = 0;
int version = 3;
String str = "Bluetooth device active, waiting for connections... - verison: ";
String finalstr = str+version; 

void setup() {
  Serial.begin(9600);    // initialize serial communication
  pinMode(LED_BUILTIN, OUTPUT);

  if (!BLE.begin()) {
    Serial.println("starting BLE failed!");

    while (1);
  }
  /* Set a local name for the BLE device
     This name will appear in advertising packets
     and can be used by remote devices to identify this BLE device
     The name can be changed but maybe be truncated based on space left in advertisement packet
  */
  BLE.setLocalName("Smart_MS3");
  BLE.setAdvertisedService(emgService); // add the service UUID
  emgService.addCharacteristic(emgLevelChar); // add the battery level characteristic
  BLE.addService(emgService); // Add the battery service
  emgLevelChar.writeValue(emgValue); // set initial value for this characteristic

  /* Start advertising BLE.  It will start continuously transmitting BLE
     advertising packets and will be visible to remote BLE central devices
     until it receives a new connection */

  // start advertising
  BLE.advertise();

  Serial.println(finalstr);
}

void loop() {
  // wait for a BLE central
  BLEDevice central = BLE.central();

  // if a central is connected to the peripheral:
  if (central) {
    Serial.print("Connected to central: ");
    // print the central's BT address:
    Serial.println(central.address());
    // turn on the LED to indicate the connection:
    digitalWrite(LED_BUILTIN, HIGH);

   
    // while the central is connected:
    while (central.connected()) {
        emgValue = analogRead(A0);
        Serial.print("Sensor value is: "); // print it
        Serial.println(emgValue);
        emgValue = emgValue * .255;
        emgLevelChar.writeValue(emgValue);
        delay(1000); 
    }
    // when the central disconnects, turn off the LED:
    digitalWrite(LED_BUILTIN, LOW);
    Serial.print("Disconnected from central: ");
    Serial.println(central.address());
  }
}

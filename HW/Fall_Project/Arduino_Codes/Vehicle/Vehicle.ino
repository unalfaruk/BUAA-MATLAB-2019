/*
   LoRaLib Receive Example

   This example listens for LoRa transmissions and tries to
   receive them. To successfully receive data, the following
   settings have to be the same on both transmitter
   and receiver:
    - carrier frequency
    - bandwidth
    - spreading factor
    - coding rate
    - sync word
    - preamble length

   For more detailed information, see the LoRaLib Wiki
   https://github.com/jgromes/LoRaLib/wiki

   For full API reference, see the GitHub Pages
   https://jgromes.github.io/LoRaLib/
*/

// include the library
#include <LoRaLib.h>

// create instance of LoRa class using SX1278 module
// this pinout corresponds to RadioShield
// https://github.com/jgromes/RadioShield
// NSS pin:   10 (4 on ESP32/ESP8266 boards)
// DIO0 pin:  2
// DIO1 pin:  3
SX1278 lora = new LoRa;

void setup() {
  Serial.begin(9600);
  pinMode(8,OUTPUT);
  pinMode(7,OUTPUT);
  pinMode(6,OUTPUT);
  digitalWrite(7,1);
  // initialize SX1278 with default settings
  Serial.print(F("Initializing ... "));
  // carrier frequency:           434.0 MHz
  // bandwidth:                   125.0 kHz
  // spreading factor:            9
  // coding rate:                 7
  // sync word:                   0x12
  // output power:                17 dBm
  // current limit:               100 mA
  // preamble length:             8 symbols
  // amplifier gain:              0 (automatic gain control)
  int state = lora.begin();
  if (state == ERR_NONE) {
    Serial.println(F("success!"));
  } else {
    Serial.print(F("failed, code "));
    Serial.println(state);
    while (true);
  }
}

void loop() {
  //Serial.print(F("Waiting for incoming transmission ... "));

  // you can receive data as an Arduino String
  // NOTE: receive() is a blocking method!
  //       See example ReceiveInterrupt for details
  //       on non-blocking reception method.
  // NOTE: for spreading factor 6, the packet length
  //       must be known in advance, and provided to
  //       receive() method!
  String str;
  int state = lora.receive(str);

  // you can also receive data as byte array
  /*
    size_t len = 8;
    byte byteArr[len];
    int state = lora.receive(byteArr, len);
  */

  if (state == ERR_NONE) {
    // packet was successfully received
    Serial.println(F("success!"));

    // print data of the packet
    Serial.print(F("Data:\t\t\t"));
    Serial.println(str);

    // print RSSI (Received Signal Strength Indicator)
    // of the last received packet
    Serial.print(F("RSSI:\t\t\t"));
    Serial.print(lora.getRSSI());
    Serial.println(F(" dBm"));

    // print SNR (Signal-to-Noise Ratio)
    // of the last received packet
    Serial.print(F("SNR:\t\t\t"));
    Serial.print(lora.getSNR());
    Serial.println(F(" dB"));

    // print frequency error
    // of the last received packet
    Serial.print(F("Frequency error:\t"));
    Serial.print(lora.getFrequencyError());
    Serial.println(F(" Hz"));
    
    if(str=="1"){
      digitalWrite(8,1);
    }
    if(str=="2"){
      digitalWrite(8,0);
    }
    if(str=="3"){
      digitalWrite(6,1);
    }
    if(str=="4"){
      digitalWrite(6,0);
    }
    if(str=="9"){
      String str_9;
      Serial.print(F("Transmit mode... "));
      delay(200);
      while(true){
        Serial.print(F("Sending packet ... "));
        // you can transmit C-string or Arduino string up to
        // 256 characters long
        // NOTE: transmit() is a blocking method!
        //       See example TransmitInterrupt for details
        //       on non-blocking transmission method.

        int val = analogRead(0);
        float mv = ( val/1024.0)*5000;
        float cel = mv/10;
        Serial.println(cel);
        str_9=String(cel);
        int state_9 = lora.transmit(str_9);
      
        if (state_9 == ERR_NONE) {
          // the packet was successfully transmitted
          Serial.println(F(" success!"));
        }

        // wait a second before transmitting again
        delay(500);
        String str_int;
        int state_int = lora.receive(str_int);
        if (state_int == ERR_NONE) {
          if(str_int=="q")
            break;
        }
      }
    }
    

  } else if (state == ERR_RX_TIMEOUT) {
    // timeout occurred while waiting for a packet
    //Serial.println(F("timeout!"));

  } else if (state == ERR_CRC_MISMATCH) {
    // packet was received, but is malformed
    Serial.println(F("CRC error!"));

  }

}

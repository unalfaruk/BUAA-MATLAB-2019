/*
   LoRaLib Transmit Example

   This example transmits LoRa packets with one second delays
   between them. Each packet contains up to 256 bytes
   of data, in the form of:
    - Arduino String
    - null-terminated char array (C-string)
    - arbitrary binary data (byte array)

   For more detailed information, see the LoRaLib Wiki
   https://github.com/jgromes/LoRaLib/wiki

   For full API reference, see the GitHub Pages
   https://jgromes.github.io/LoRaLib/
*/
#include <SPI.h>
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
char incomingByte; // for incoming serial data
String message;
void loop() {
  while(!Serial.available());
  // read the incoming byte:
  incomingByte = Serial.read();
  Serial.write(incomingByte);
  message=incomingByte;
  Serial.print(F("Sending packet ... "));

  // you can transmit C-string or Arduino string up to
  // 256 characters long
  // NOTE: transmit() is a blocking method!
  //       See example TransmitInterrupt for details
  //       on non-blocking transmission method.
  int state = lora.transmit(message);

  // you can also transmit byte array up to 256 bytes long
  /*
    size_t len = 8;
    byte byteArr[len] = {0x01, 0x23, 0x45, 0x56,
                         0x78, 0xAB, 0xCD, 0xEF};
    int state = lora.transmit(byteArr, len);
  */
  Serial.println(state);
  if (state == ERR_NONE || state==-16) {
    // the packet was successfully transmitted
    Serial.println(F(" success!"));

    // print measured data rate
    Serial.print(F("Datarate:\t"));
    Serial.print(lora.getDataRate());
    Serial.println(F(" bps"));

    if(message=="9"){
      String str_9;
      Serial.println("ok9");
      //Serial.flush();
      Serial.read();
      while(true){
        int state = lora.receive(str_9);
        //Serial.println(state);
        if (state == ERR_NONE) {
          // print data of the packet
          Serial.print(F("D"));
          Serial.println(str_9);
        }

        if(Serial.available()>0 && Serial.read()=='q'){
          lora.transmit("q");
          break;
        }
          

      }
    }

  } else if (state == ERR_PACKET_TOO_LONG) {
    // the supplied packet was longer than 256 bytes
    Serial.println(F(" too long!"));

  } else if (state == ERR_TX_TIMEOUT) {
    // timeout occurred while transmitting packet
    Serial.println(F(" timeout!"));

  }

  // wait a second before transmitting again
  delay(300);
  message="";  
  Serial.read();
  
  
}

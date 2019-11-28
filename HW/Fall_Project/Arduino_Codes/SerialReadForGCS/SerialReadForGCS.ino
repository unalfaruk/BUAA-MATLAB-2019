void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  
}
int incomingByte = 0; // for incoming serial data
void loop() {
  // put your main code here, to run repeatedly:
  if (Serial.available() > 0) {
    // read the incoming byte:
    incomingByte = Serial.read();

    // say what you got:
    //Serial.print("I received: ");
    Serial.write(incomingByte);
    //Serial.println("");
  }
  

}

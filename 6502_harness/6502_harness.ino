//6502 Harness
//
//Test harness for the WDC 65C02S.
//
//For use with Arduino Mega 2560.
//Intended for the 6502 computer kit https://eater.net/6502
//
//Based on an example from Ben Eater

const char ADDR[] = {46,48,50,52,44,42,40,38,36,34,32,30,28,26,24,22};
const char DATA[] = {53,51,49,47,45,43,41,39};
#define CLOCK 2
#define READ_WRITE 3

void setup() {
  for (int i = 0; i < 16; i++) {
    pinMode(ADDR[i], INPUT);
  }
  for (int i = 0; i < 8; i++) {
    pinMode(DATA[i], INPUT);
  }
  pinMode(CLOCK, INPUT);
  pinMode(READ_WRITE, INPUT);

  attachInterrupt(digitalPinToInterrupt(CLOCK), onClock, RISING);
  
  Serial.begin(57600);
}

void onClock() {
  char output[15];
  unsigned int address = 0;
  for (int i = 0; i < 16; i++) {
    int bit = digitalRead(ADDR[i]) ? 1 : 0;
    Serial.print(bit);
    address = (address << 1) + bit;
  }
  Serial.print("    ");
  unsigned int data = 0;
  for (int i = 0; i < 8; i++) {
    int bit = digitalRead(DATA[i]) ? 1 : 0;
    Serial.print(bit);
    data = (data << 1) + bit;
  }
  Serial.print("    ");
  sprintf(output, "%04X %c %02X", address, digitalRead(READ_WRITE) ? 'r' : 'W', data);
  Serial.println(output);

}

void loop() {}

static const uint16_t
Rcmd[] = {0x101,
0x200,
0x111,
0x200,
0x1B1,
0x001,
0x02C,
0x02D,
0x1B2,
0x001,
0x02C,
0x02D,
0x1B3,
0x001,
0x02C,
0x02D,
0x001,
0x02C,
0x02D,
0x1B4,
0x007,
0x1C0,
0x0A2,
0x002,
0x084,
0x1C1,
0x0C5,
0x1C2,
0x00A,
0x000,
0x1C3,
0x08A,
0x02A,
0x1C4,
0x08A,
0x0EE,
0x1C5,
0x00E,
0x120,
0x136,
0x0C8,
0x13A,
0x005,
0x12A,
0x000,
0x000,
0x000,
0x07F,
0x12B,
0x000,
0x000,
0x000,
0x09F,
0x1E0,
0x002,
0x01c,
0x007,
0x012,
0x037,
0x032,
0x029,
0x02d,
0x029,
0x025,
0x02B,
0x039,
0x000,
0x001,
0x003,
0x010,
0x1E1,
0x003,
0x01d,
0x007,
0x006,
0x02E,
0x02C,
0x029,
0x02D,
0x02E,
0x02E,
0x037,
0x03F,
0x000,
0x000,
0x002,
0x010,
0x113,
0x200,
0x129,
0x200,
0x136,
0x0C0,
0x300
},
FullScrn[] = {
0x12A,
0x000,
0x000,
0x000,
0x07F,
0x12B,
0x000,
0x000,
0x000,
0x09F,
0x12C,
0x300
},
Stripes[] = {
0x007,
0x0FF,
0x0F8,
0x01F,
0x300
},
Black[] = {
0x000,
0x000,
0x300
},
White[] = {
0x0FF,
0x0FF,
0x300
};

void setup(void) {
  pinMode(8,OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10,OUTPUT);
  pinMode(11 , OUTPUT);
  pinMode(13, OUTPUT);
  digitalWrite(13,LOW);
  digitalWrite(11,LOW);
  digitalWrite(10,LOW);
  digitalWrite(9, HIGH);
  delay(500);
  digitalWrite(9, LOW);
  delay(500);
  digitalWrite(9, HIGH);
  commandList(Rcmd);
}

uint16_t i;
uint16_t kiwi;
boolean mango;

void loop() {
  int n;
  int m;
  int l;
  int k;
  commandList(FullScrn);
  for(n=0;n<72*160;n++) commandList(Stripes);
  commandList(FullScrn);
  for(n=0;n<5;n++) {
    for(m=0;m<16;m++) {
      for(l=0;l<4;l++) {
        for(k=0;k<16;k++) {
          commandList(Black);
        }
        for(k=0;k<16;k++) {
          commandList(White);
        }
      }
    }
    for(m=0;m<16;m++) {
      for(l=0;l<4;l++) {
        for(k=0;k<16;k++) {
          commandList(White);
        }
        for(k=0;k<16;k++) {
          commandList(Black);
        }
      }
    }
  }
}

void spiwrite(uint8_t c) {
  for(uint8_t bit = 0x80; bit; bit >>= 1) {
    if(c & bit) digitalWrite(11,HIGH);
    else        digitalWrite(11,LOW);
    digitalWrite(13, HIGH);
    digitalWrite(13, LOW);
  }
}

void commandList(const uint16_t *list) {
  i=0;
  mango=1;
  while(mango) {
    kiwi = list[i++];
    Serial.println(kiwi,HEX);
    if(kiwi<0x100) spiwrite(kiwi);
    else if(kiwi<0x200) {digitalWrite(8,LOW);spiwrite(kiwi);digitalWrite(8,HIGH);}
    else if(kiwi<0x300) delay(500);
    else mango=0;
  }
}

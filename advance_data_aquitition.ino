String inputString="";
boolean stringCompelete=false;

void setup() {
  Serial.begin(9600);
  inputString.reserve(100);
  pinMode(13,OUTPUT);
}

void loop() {
  if (stringCompelete){
    if(!inputString.compareTo("ON")){
      digitalWrite(13,HIGH);
    }
    else if(!inputString.compareTo("OFF")){
      digitalWrite(13,LOW);
    }
    else if(!inputString.compareTo("take")){
      int sensor=analogRead(A0);
      Serial.println(sensor);
    }
    inputString="";
    stringCompelete=false;
  }
}

void serialEvent(){
  while (Serial.available()){
    char inChar=(char)Serial.read();
    if (inChar=='\n'){
      stringCompelete=true;
    }
    else{
      inputString+=inChar;
    }
  }
}

import processing.serial.*;
import grafica.*;

PrintWriter output;

String myData="";
Serial myPort;
int dataNumber=0;

GPlot plot;
int nPoints = 100;
GPointsArray points = new GPointsArray(nPoints);


void setup(){
  printArray(Serial.list());
  myPort=new Serial(this,Serial.list()[0],9600);
  myPort.clear();
  delay(2000);
  
  output=createWriter("data/myData.csv");
  
  size(500, 350);
  background(150);
  
  plot = new GPlot(this);
  
  plot.setPos(25, 25);
  
  plot.setTitleText("A very simple Data Aquisition");
  plot.getXAxis().setAxisLabelText("Time (s)");
  plot.getYAxis().setAxisLabelText("ADC");
  plot.setPoints(points);
  
}

void draw(){
  
  myPort.write("take");
  myPort.write('\n');
  delay(1000);
  myData=myPort.readStringUntil('\n');
  float[] data=float(split(myData,'\n'));
  
  print(dataNumber);
  println(data[0]);
  
  output.print(dataNumber);
  output.print(',');
  output.print(float(myData));
  output.print('\n');
  output.flush();
  
  points.add(dataNumber,data[0]);
  
  plot.setPoints(points);
  plot.defaultDraw();
  
  dataNumber+=1;
}
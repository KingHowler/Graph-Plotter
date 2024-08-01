import processing.serial.*;

// Setings
boolean Points = false;       // Mark each Value on the graph with a dot
boolean subGrid = true;      // Draw a smaller grid of 1/10 inside the Grid
boolean serialInput = false;  // Take input from a serial Port
String XTitle = "X-Axis";    // Title for the X-axis
String YTitle = "Y-axis";    // Title for the Y-axis
String PortNo = "COM5";      // Port at which serial input device is connected, Ignore if serialInput is false

// Graph size
int Ymin = -100;
int Ymax = 200;
float Ystep = 30;
int Xmin = -87;
int Xmax = 87;
float Xstep = 10;


// Constant Variables
int TotalPoints = Xmax - Xmin + 1; // Total number of Data Points
float[] Graph1 = new float[TotalPoints];   // Array to store Graph1
float[] Graph2 = new float[TotalPoints];   // Array to store Graph2
float[] Graph3 = new float[TotalPoints];   // Array to store Graph3
float[] Graph4 = new float[TotalPoints];   // Array to store Graph4
Serial myPort;
int index = 0;

void setup() {
  size(1900, 970);    // Window size
  println(TotalPoints);
  if (serialInput) {
    myPort = new Serial(this, PortNo, 9600);  // Initialize the serial port
    myPort.bufferUntil('\n');  // Read until newline
  }
  // fill the arrays with the data
  for (int i = 0; i < TotalPoints; i+=17) {
    for (int i2 = 0; i2 < 18; i2++) {
      i++;
      if (i + 17 < TotalPoints) {
        Graph1[i] = -80;
        Graph1[i + 17] = 80;}
    }
  }
  for (int i = 0; i < TotalPoints; i++) {
    float x = map(i, 0 , TotalPoints - 1, Xmin, Xmax);  // Use this line for writing equations using x eg: y = 4x - 29
    //Graph1[i] = 2*x + 9;
    Graph2[i] = 4*(x) - 29;
    Graph3[i] = -x;
    Graph4[i] = -((x*x) - 60);
  }
}

void draw() {
  background(255);    // White background
  // Comment out whatever you don`t wish to drae
  DrawGraph1(255, 0, 0);
  DrawGraph2(0, 0, 255);
  DrawGraph3(0, 255, 0);
  DrawGraph4(255, 150, 0);
  DrawGrid();
    
  // Label the axes
  fill(0);
  textAlign(CENTER);
  text(XTitle, width / 2, height - 10);
  textAlign(RIGHT);
  text(YTitle, 30, height / 2);
}

void DrawGrid() {
  // Clear Bottom
  strokeWeight(0);
  stroke(255);
  fill(255);
  rect(0, height - 50, width, 50);
  // sub grid
  if (subGrid) {
  // Y sub grid
  for (float i = Xmin; i < Xmax; i+= Xstep/10) {
      int x = int(map(i, Xmin, Xmax, 100, width));
      strokeWeight(0.5);
      stroke(200);  // Light gray color for grid
      line(x, height - 50, x, 0);
  }
  // X sub grid
  for (float i = Ymin; i < Ymax + 1; i+= Ystep/10) {
      int y = int(map(i, Ymin, Ymax, height - 50, 0));
      strokeWeight(0.5);
      stroke(200);  // Light gray color for grid
      line(100, y, width, y);
  }
  }
  // Y grid
  for (float i = Xmin; i < Xmax; i+= Xstep) {
      int x = int(map(i, Xmin, Xmax, 100, width));
      strokeWeight(1.5);
      stroke(160);  // Light gray color for grid
      line(x, height - 50, x, 0);
      textAlign(CENTER);
      fill(0);
      if (i != 0 ) {
      text(String.valueOf(i), x, height - 30);}
  }
  // X Grid
  for (float i = Ymin; i < Ymax + 1; i+= Ystep) {
      int y = int(map(i, Ymin, Ymax, height - 50, 0));
      strokeWeight(1.5);
      stroke(160);  // Light gray color for grid
      line(100, y, width, y);
      textAlign(RIGHT);
      fill(0);
      if (i != 0 ) {
      text(String.valueOf(i), 90, y);}
  }
  // Drawing the axes
  stroke(0); 
  strokeWeight(2); 
  fill(0);
  
  // X axis
  int y = int(map(0, Ymin, Ymax, height - 50, 0));
  textAlign(RIGHT);
  text(String.valueOf(0), 90, y);
  line(100, y, width, y);
  
  // Y axis
  int x = int(map(0, Xmin, Xmax, 100, width));
  textAlign(CENTER);
  text(String.valueOf(0), x, height - 30);
  line(x, height - 50, x, 0);
}
void DrawGraph1(int Red, int Green, int Blue) {
  // Draw Graph4 as a graph
  stroke(Red, Green, Blue);
  for (int i = 0; i < TotalPoints - 1; i++) {
    float x1 = map(i, 0, TotalPoints - 1, 100, width);
    float y1 = map(Graph1[i], Ymin, Ymax, height - 50, 0);
    float x2 = map(i + 1, 0, TotalPoints - 1, 100, width);
    float y2 = map(Graph1[i + 1], Ymin, Ymax, height - 50, 0);
    strokeWeight(2);    // Thickness of 2 pixels
    line(x1, y1, x2, y2);
    if (Points) {
      strokeWeight(10);
      point(x1,y1);
      point(x2,y2);
    }
  }
}
void DrawGraph2(int Red, int Green, int Blue) {
  // Draw Graph4 as a graph
  stroke(Red, Green, Blue);
  for (int i = 0; i < TotalPoints - 1; i++) {
    float x1 = map(i, 0, TotalPoints - 1, 100, width);
    float y1 = map(Graph2[i], Ymin, Ymax, height - 50, 0);
    float x2 = map(i + 1, 0, TotalPoints - 1, 100, width);
    float y2 = map(Graph2[i + 1], Ymin, Ymax, height - 50, 0);
    strokeWeight(2);    // Thickness of 2 pixels
    line(x1, y1, x2, y2);
    if (Points) {
      strokeWeight(10);
      point(x1,y1);
      point(x2,y2);
    }
  }
}
void DrawGraph3(int Red, int Green, int Blue) {
  // Draw Graph4 as a graph
  stroke(Red, Green, Blue);
  for (int i = 0; i < TotalPoints - 1; i++) {
    float x1 = map(i, 0, TotalPoints - 1, 100, width);
    float y1 = map(Graph3[i], Ymin, Ymax, height - 50, 0);
    float x2 = map(i + 1, 0, TotalPoints - 1, 100, width);
    float y2 = map(Graph3[i + 1], Ymin, Ymax, height - 50, 0);
    strokeWeight(2);    // Thickness of 2 pixels
    line(x1, y1, x2, y2);
    if (Points) {
      strokeWeight(10);
      point(x1,y1);
      point(x2,y2);
    }
  }
}
void DrawGraph4(int Red, int Green, int Blue) {
  // Draw Graph4 as a graph
  stroke(Red, Green, Blue);
  for (int i = 0; i < TotalPoints - 1; i++) {
    float x1 = map(i, 0, TotalPoints - 1, 100, width);
    float y1 = map(Graph4[i], Ymin, Ymax, height - 50, 0);
    float x2 = map(i + 1, 0, TotalPoints - 1, 100, width);
    float y2 = map(Graph4[i + 1], Ymin, Ymax, height - 50, 0);
    strokeWeight(2);    // Thickness of 2 pixels
    line(x1, y1, x2, y2);
    if (Points) {
      strokeWeight(10);
      point(x1,y1);
      point(x2,y2);
    }
  }
}
void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n');  // Read the serial data as a string
  if (inString != null) {
    inString = trim(inString);  // Remove whitespace
    if (inString.equals("0") || inString.equals("1")) {
      Graph1[index] = int(inString);  // Convert the string to an integer and store it
      index = (index + 1) % Graph1.length;  // Increment the index and wrap around if necessary
    }
  }
}

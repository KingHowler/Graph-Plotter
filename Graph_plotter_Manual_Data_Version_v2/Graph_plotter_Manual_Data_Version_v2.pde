import processing.serial.*;

// Graph size
int Ymin = -1;
int Ymax = 2;
float Ystep = 1;
int Xmin = -87;
int Xmax = 87;
float Xstep = 40;
String XTitle = "X-Axis";
String YTitle = "Y-axis";
boolean Points = false;
boolean subGrid = true;


// Constant Variables

int TotalPoints = Xmax - Xmin + 1; // Total number of Data Points
float[] Graph1 = new float[TotalPoints];   // Array to store Graph1
float[] Graph2 = new float[TotalPoints];   // Array to store Graph2
float[] Graph3 = new float[TotalPoints];   // Array to store Graph3
float[] Graph4 = new float[TotalPoints];   // Array to store Graph4

void setup() {
  size(1900, 970);    // Window size
  println(TotalPoints);
  for (int i = 0; i < TotalPoints; i+=34) {
    float x = map(i, 0 , TotalPoints - 1, Xmin, Xmax);
    for (int i2 = 0; i2 < 18; i2++) {
      Graph1[i] = 0;
      if (i + 17 < TotalPoints) {
      Graph1[i + 16] = 1;}
    }
    //Graph1[i] = 2*x + 9;
    //Graph2[i] = x;
    //Graph3[i] = -x;
    //Graph4[i] = -((x*x) - 60);
  }
}

void draw() {
  background(255);    // White background
  
  DrawGraph1();
  //DrawGraph2();
  //DrawGraph3();
  //DrawGraph4();
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
  rect(0, height - 40, width, 45);
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
  int x = int(map(0, Xmin, Xmax, 100, width));
  int y = int(map(0, Ymin, Ymax, height - 50, 0));
  stroke(0); 
  strokeWeight(2); 
  textAlign(CENTER);
  fill(0);
  text(String.valueOf(0), x, height - 30);
  textAlign(RIGHT);
  text(String.valueOf(0), 90, y);
  line(x, height - 50, x, 0);
  line(100, y, width, y);
}
void DrawGraph1() {
  // Draw the Graph1 as a graph
  stroke(255, 0, 0);  // Red color
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
void DrawGraph2() {
  // Draw the Graph1 as a graph
  stroke(0, 0, 255);  // Red color
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
void DrawGraph3() {
  // Draw the Graph1 as a graph
  stroke(0, 255, 0);  // Red color
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
void DrawGraph4() {
  // Draw the Graph1 as a graph
  stroke(255, 150, 0);  // Red color
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

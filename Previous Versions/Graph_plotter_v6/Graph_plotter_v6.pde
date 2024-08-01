import processing.serial.*;

Serial myPort;               // The serial port
int[] bits = new int[400];   // Array to store the bits
int index = 0;               // Index to keep track of the current bit
int lastXaxis = 0;
int graph = 0;

void setup() {
  size(1900, 300);    // Window size
  println(Serial.list());  // List all the available serial ports
  myPort = new Serial(this, "COM5", 9600);  // Initialize the serial port
  myPort.bufferUntil('\n');  // Read until newline
  frameRate(10);  // Set frame rate to 10 frames per second (100ms interval)
}

void draw() {
  background(255);    // White background
  stroke(0);          // Black lines
  fill(0);            // Black fill

  // Draw the x-axis
  line(50, height - 50, width - 50, height - 50);
  // Draw the y-axis
  line(50, height - 50, 50, 0);
  
  // Label the axes
  fill(0);
  textAlign(CENTER);
  text("Time (seconds)", width / 2, height - 10);
  textAlign(RIGHT);
  text("Data", 40, height / 2);

  // Draw the Grid
  int PointsPer100ms = 33;
  for (int i = PointsPer100ms; i < bits.length - 1; i+= PointsPer100ms) {
      int x = int(map(i, 0, bits.length - 1, 50, width - 50));
      strokeWeight(1.5);
      stroke(200);  // Light gray color for grid
      line(x, height - 50, x, 0);
      textAlign(CENTER);
      fill(0);
      text(String.valueOf(i/PointsPer100ms * 100) + "ms", x, height - 30);
  }

  // Draw the bits as a graph
  stroke(255, 0, 0);  // Red color
  strokeWeight(1.5);    // Thickness of 2 pixels
  for (int i = 0; i < bits.length - 1; i++) {
    int x1 = int(map(i, 0, bits.length - 1, 50, width - 50));
    int y1 = int(map(bits[i], 0, 1, height - 50, 50));
    int x2 = int(map(i + 1, 0, bits.length - 1, 50, width - 50));
    int y2 = int(map(bits[i + 1], 0, 1, height - 50, 50));
    line(x1, y1, x2, y2);
  }
}
void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n');  // Read the serial data as a string
  if (inString != null) {
    inString = trim(inString);  // Remove whitespace
    if (inString.equals("0") || inString.equals("1")) {
      bits[index] = int(inString);  // Convert the string to an integer and store it
      //times[index] = millis() / 1000.0;  // Record the time in seconds
      index = (index + 1) % bits.length;  // Increment the index and wrap around if necessary
    }
  }
}

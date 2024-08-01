import processing.serial.*;

Serial myPort;      // The serial port
int[] bits = new int[500];  // Array to store the bits
int index = 0;      // Index to keep track of the current bit

void setup() {
  size(1500, 600);  // Window size
  println(Serial.list());  // List all the available serial ports
  myPort = new Serial(this, "COM5", 9600);  // Initialize the serial port
  myPort.bufferUntil('\n');  // Read until newline
}

void draw() {
  background(255);  // White background
  stroke(0);        // Black lines
  fill(0);          // Black fill

  // Draw the bits as a graph
  for (int i = 0; i < bits.length - 1; i++) {
    int x1 = int(map(i, 0, bits.length - 1, 0, width));
    int y1 = int(map(bits[i], 0, 1, height - 50, 50));
    int x2 = int(map(i + 1, 0, bits.length - 1, 0, width));
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
      index = (index + 1) % bits.length;  // Increment the index and wrap around if necessary
    }
  }
}

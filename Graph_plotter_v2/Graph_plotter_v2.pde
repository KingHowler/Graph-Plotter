import processing.serial.*;

Serial myPort;      // The serial port
int[] bits = new int[400];  // Array to store the bits
int index = 0;      // Index to keep track of the current bit
int startTime = -1;  // Variable to store the start time when the first '1' arrives

void setup() {
  size(1500, 600);  // Window size
  println(Serial.list());  // List all the available serial ports
  myPort = new Serial(this, "COM5", 9600);  // Initialize the serial port
  myPort.bufferUntil('\n');  // Read until newline
}

void draw() {
  background(255);  // White background
  
  // Draw grid
  drawGrid();
  
  stroke(255, 0, 0);        // Red lines
  fill(255, 0, 0);          // Red fill

  // Draw the bits as a graph
  for (int i = 0; i < bits.length - 1; i++) {
    int x1 = int(map(i, 0, bits.length - 1, 0, width));
    int y1 = int(map(bits[i], 0, 1, height - 50, 50));
    int x2 = int(map(i + 1, 0, bits.length - 1, 0, width));
    int y2 = int(map(bits[i + 1], 0, 1, height - 50, 50));
    line(x1, y1, x2, y2);
  }

  // Print live time in seconds
  if (startTime != -1) {
    int elapsedTime = millis() - startTime;
    float elapsedTimeInSeconds = elapsedTime / 1000.0;
    textSize(16);
    textAlign(LEFT);
    fill(0);
    text("Live Time: " + nf(elapsedTimeInSeconds, 0, 2) + " seconds", 20, 30);
  }
}

void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n');  // Read the serial data as a string
  if (inString != null) {
    inString = trim(inString);  // Remove whitespace
    if (inString.equals("0") || inString.equals("1")) {
      bits[index] = int(inString);  // Convert the string to an integer and store it
      index = (index + 1) % bits.length;  // Increment the index and wrap around if necessary
      
      if (inString.equals("1")) {
        if (startTime == -1) {
          startTime = millis();  // Record the start time in milliseconds when the first '1' arrives
        }
      }
    }
  }
}

void drawGrid() {
  // Draw vertical lines
  stroke(200);
  for (int i = 0; i <= width; i += 50) {
    line(i, 0, i, height);
  }
  
  // Draw horizontal lines
  for (int j = 0; j <= height; j += 50) {
    line(0, j, width, j);
  }
}

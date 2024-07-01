import processing.serial.*;
int[] bits = new int[400];   // Array to store the bits

void setup() {
  size(1500, 600);    // Window size
}

void draw() {
  background(255);    // White background
  stroke(0);          // Black lines
  fill(0);            // Black fill

  // Draw the x-axis
  line(50, height - 50, width - 50, height - 50);
  // Draw the y-axis
  line(50, height - 50, 50, 50);
  
  // Label the axes
  fill(0);
  textAlign(CENTER);
  text("Time (seconds)", width / 2, height - 10);
  textAlign(RIGHT);
  text("Data", 40, height / 2);

  // Draw the grid according to the x-axis labels
  int PointsPer100ms = 17;
  int WidthBetween2Points = int(map(6, 0, bits.length - 1, 50, width - 50) - map(5, 0, bits.length - 1, 50, width - 50)) - 1;
  int increment = WidthBetween2Points * PointsPer100ms;
  println(WidthBetween2Points);
  println(increment);
  for (int i = increment; i * WidthBetween2Points < width - 50; i += increment) {
    int x = int(map(i, 0, bits.length - 1, 50, width - 50));
    strokeWeight(1.5);
    stroke(200);  // Light gray color for grid
    line(x, height - 50, x, 0);
    textAlign(CENTER);
    fill(0);
    text(String.valueOf(i/increment * 100) + "ms", x, height - 30);
  }

  // Draw the bits as a graph
  stroke(255, 0, 0);  // Red color
  strokeWeight(1);    // Thickness of 2 pixels
  for (int i = 0; i < bits.length - 1; i++) {
    int x1 = int(map(i, 0, bits.length - 1, 50, width - 50));
    int y1 = int(map(bits[i], 0, 1, height - 50, 50));
    int x2 = int(map(i + 1, 0, bits.length - 1, 50, width - 50));
    int y2 = int(map(bits[i + 1], 0, 1, height - 50, 50));
    line(x1, y1, x2, y2);
  }
}

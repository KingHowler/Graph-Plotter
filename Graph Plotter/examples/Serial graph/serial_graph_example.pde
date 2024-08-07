// Create Plotter object
GraphPlotter GP;

// Create data holder
float[] DataArray;

// Setup Serial Libraries and objects
import processing.serial.*;
int index = 0;
Serial myPort;

void setup() {
  // setup size
  size(1900,600);
  
  // Initialize Plotter
  GP = new GraphPlotter();
  GP.GraphSetup(false, true, "Data point No.", "Data");
  GP.GridSetup(0, 3, 1, 0, 200, 100);
  GP.SizeSetup(width, height);
  
  // Initialize Data holder
  DataArray = new float[GP.totalPoints];
  
  // Initialize Port
  myPort = new Serial(this, "COM6", 9600);  // Initialize the serial port
  myPort.bufferUntil('\n');  // Read until newline
}

void draw() {
  // Set Background as White
  background(255);
  
  // Draw the Graphs
  GP.DrawGraph(DataArray, color(255,0,0));
  
  // Draw the Grid
  GP.DrawGrid();
}

// Serial Data handling functions.     Remove/Comment both out if processing.serial libraray is not imported to avoid errrors
void serialEvent(Serial myPort) {
  // Reads Serial Data and stores it in Graph1
  if(index < GP.totalPoints) {
  index = EventListener(myPort, DataArray, index);
  }
  print(index + "\n");
}

// This function can be reused
int EventListener(Serial Device, float[] OutArray, int index) {
  String inString = Device.readStringUntil('\n');  // Read the serial data as a string
  if (inString != null) {
    inString = trim(inString);  // Remove whitespace
    OutArray[index] = int(inString);  // Convert the string to an integer and store it
    return (index + 1) % OutArray.length;  // Increment the index and wrap around if necessary, results in a true oscilloscope like output
    //return (index + 1); // outputs initial readings
  }
  return index;
}

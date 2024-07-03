# Graph Plotter v7
## Example
>![Example Image](https://github.com/KingHowler/Arduino-Simple-Graph-Plotter/assets/68814294/cfa23286-7343-41aa-9643-d053a2acdb63)
> A display of the 1 second output of a 30Hz square wave inputted using an Arduino Nano.

## Explanation
- The Application first takes inputs from an Arduino
- It draws the x-axis and the y-axis, where x-axis is the time and y-axis is the data
- The it draws a grid using the 2 variables ```Ystep``` & ```PointsPer50ms```
- Then it uses the user-defined variables to map each point in the input to a specific coordinate on the application window and connects them by lines.
## User-defined variables
- ```int TotalPoints```
  - The total number of data points the graph will plot
- ```int UpperLimit```
  - The maximum possible value from the data
- ```int LowerLimit```
  - The minimum possible value from the data
- ```int Ystep```
  - The gap between each horizontal line of the grid
- ```int PointsPer50ms```
  - The number of data points to display in an interval of 50 miliseconds
- ```size(width,height)```
  - In void setup()
  - Replace width with an integer value for the width of the graph window
  - Replace height with an integer value for the height of the graph window
 
# Alternate Use (How to use without Arduino)
- Comment out the lines which interact with the arduino (lines shown below)
  - line 18 & line 19 [in void setup()]
    
        myPort = new Serial(this, "COM5", 9600);  // Initialize the serial port`
        myPort.bufferUntil('\n');  // Read until newline```

  - lines 71 - 81 [void serialEvent()]

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
- Edit the user-defined appropiately
- Fill the array ```bits[]``` with the data you want to draw a graph of

### Extra info : How to calculate PointsPer50ms
Use your Arduino IDE's Serial Monitor. Enable the Timestamp feature on the Serial Monitor and connect your arduino to get the data. <br>
Divide the total number of outputs from the Arduino by the difference between the timestamps of the first and last values.<br>
That gives the number of points per second. Multiply it with 0.05 to get PointsPer50ms

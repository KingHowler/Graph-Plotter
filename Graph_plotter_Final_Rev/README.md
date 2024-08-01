# Graph plotter Final Revision
### Example

>![Example image](https://github.com/KingHowler/Arduino-Simple-Graph-Plotter/assets/68814294/96189d42-14ae-4d66-9fb1-9aba01bf15c7)
> A display of 4 different graphs plotted using the code

## Explanation

- The code reads data from Arrays
- Then it maps each value to an x-coordinate and y-coordinate
- It draws straight lines between each 2 consecutive values hence creating a line graph

Since it accepts adding data through code and serial devices, it is more versatile than traditional Graph Plotters which only accept data from a mathematical equation.<br>
Hence making it more preferred for experimentation where the data doesn`t strictly follow the theoretical mathematical equations.<br>
It has multiple options to suit your needs. Though it will require a bit of modification (hence some knowledge about coding) you can actually draw as many number of graphs as you want to at the same time.

## Setup

### Settings Variables
- Points
  - It marks each value in the array using a point and hence making it easier to see the relation in the data.
  - > ![Example image](https://github.com/KingHowler/Arduino-Simple-Graph-Plotter/assets/68814294/b5da67eb-75ea-499a-ba54-09d3710b4701)
    > A display of a graph when Points is true
  - > ![Example image](https://github.com/KingHowler/Arduino-Simple-Graph-Plotter/assets/68814294/a3df754d-95d0-4b60-85b7-a4c3b3a6b7a7)
    > A display of a Graph when Points is false
- subGrid
  - It creates a sub grid of 1/10 size of the main grid.
  - > ![Example image](https://github.com/KingHowler/Arduino-Simple-Graph-Plotter/assets/68814294/a3df754d-95d0-4b60-85b7-a4c3b3a6b7a7)
    > A display of a Graph when subGrid is true
  - > ![Example image](https://github.com/KingHowler/Arduino-Simple-Graph-Plotter/assets/68814294/e4287e89-b6f2-4bce-bc35-d28ea9165e58)
    > A diaplay of a Graph when subGrid is false
- serialInput
  - It enables Serial Data Input. When true, data is taken from a Serial Port
- XTitle
  - String that stores what is displayed as the Title for the X-axis
- YTitle
  - String that stores what is displayed as the Title for the Y-axis
- PortNo
  - String that stores the name of the Port the Serial Device is connected to
  - Ignore if serialInput is false
### Graph Size Variables
- Ymin
  - The minimum Y value the graph should display
- Ymax
  - The maximum Y value the graph should display
- Ystep
  - The gap between each horizontal line in the main grid
- Xmin
  - The minimum X value the graph should display
- Xmax
  - The maximum X value the graph should display
- Xstep
  - The gap between each vertical line in the main grid
### Filling the graph with data
- Be sure to fill the data in ```void setup()```
- You can fill the data however you please
- To fill the data using a Serial Device scroll down to ``` void serialEvent(Serial myPort)```<br> NOTE: The function is pre-configured to store all data in the Graph1 Array, hence modifications should be unnecessary, but you are free to do so in-case it doesn't meet your requirements

## Additional Info
- You can change the size of the window in the ```void setup()```, the function ```size(1900,900)``` controls the window size where 1900 is the width and 900 is the height
- You can comment out the things You don`t want to draw in ```void draw()```
  - > ![Example image](https://github.com/KingHowler/Arduino-Simple-Graph-Plotter/assets/68814294/9d940b81-c258-4054-8542-54570d1f9493)
    > An image ater commenting out the ```DrawGrid()``` function
- You can change the colors of the graphs in ```void draw()```, each graph function has the format ```DrawGraph1(255,0,0)``` where the parameters are the rgb values of the color of the graph
- You can create more graphs by doing the following :
  - Above ```void setup()``` declare a new array using the format of the previous 4
  - In ```void setup()``` fill the array with whatever data you wish to
  - Below ```void DrawGraph4(int Red, int Green, int Blue)``` copy and paste DrawGraph4 function and replace all mentions of ```Graph4```(there should be 3 including the name of the function) with the name of the array you just declared
  - In ```void draw()``` call the function you just made for drawing the graph and then you should be done

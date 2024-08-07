# Graph Plotter

## Graph Plotter class variation

>
> Example
> ![Example Image](/Graph%20Plotter/images/screenshots/Screenshot%20(1).png)

## Why?

Initially I wanted to read an electrical signal, but as I didn't have an oscilloscope, I thought about using my laptop and an arduino device as a replacement. The issue arose that Arduino's builtin Serial Plotter only showed live data, and when some of it has reached outside of its limit (typically around 100 data points) you can never access it again.
So I built a graph plotter of my own using processing and eventually started to expand it into this.

## Working

- This works using a custom class ```GraphPlotter``` contained in the file ```GP_unit.pde```'
- To use it you have to declare an object of type ```GraphPlotter``` and then in ```void setup() {}``` You need to initialize it like the following:

    ``` Processing
    GraphPlotter GP;  // Declare object

    void setup() {
        GP = new GraphPlotter();  // Initialize it
    }
    ```

## Setup Methods

## General Overview

The class has 4 setup methods which describe the behaviour of the plotted data

``` Processing
/* 
Note : You can actually use whatever name you like
I used GP as it is easier to remember
It just needs to be the same as the one declared and initialized 
*/

GP.GraphSetup(boolean points, boolean subGrid, String xTitle, String yTitle);
GP.GridSetup(int yMin, int yMax, float yStep, int xMin, int xMax, float xStep);
GP.SizeSetup(int widthP, int heightP);
GP.Offset(int offX, int offY)

/*
Note : Don't specify the types when calling for the function.
It will cause a syntax error.
I have shown it here to make you understand the type of parameters it expects
*/
```

Of these 4, only the first 3 are compulsory and will return an error if left uninitialized.

### Description

- GraphSetup
  - points
    - It is a boolean variable which determines whether the plotted graph will show each data point marked with a dot or not
        > ```points = true;```
        > ![Graph with points](/Graph%20Plotter/images/screenshots/Screenshot%20(2).png)
        > ```points = false;```
        > ![Graph without points](/Graph%20Plotter/images/screenshots/Screenshot%20(3).png)

  - subGrid
    - It is a boolean variable which determines whether there will be a subgrid shown or not
        > ```subGrid = true```
        > ![Graph with sub grid](/Graph%20Plotter/images/screenshots/Screenshot%20(3).png)
        > ```subGrid = false```
        > ![Graph without sub grid](/Graph%20Plotter/images/screenshots/Screenshot%20(4).png)

  - xTitle & yTitle
    - They are string variables which contain the text that will be show alongside the edges of the graphs as titles of each of their respective axeses
- GridSetup
  - Ymin and Xmin
    - The smallest (x, y) value desired to be seen
  - Ymax and Xmax
    - The largest (x, y) value desired to be seen
  - Ystep and Xstep
    - The height and width of each cell in the main grid
- SizeSetup
  - widthP & heightP
    - the width and height of the graph plotter
- Offset
  - offX & offY
    - the location of the top-left corner of the plotter

## Data Inputs

The best part about this graph plotter is that it has multiple types of data inputs.

1. Serial Data Plotter
   - It can take data from a serial input device, there is an example included in the file directory
2. Maths Functions
   - It can take plot data from mathematical functions, for this specific reason I have included a function which converts the index number into ```x``` allowing easier coding
     - For example if you wanted to write ```y = 4x+5``` you would write it as

        ``` Processing
        Graph1[i] = 4*GP.x(i) + 5;
        ```

3. Raw Data
   - You can plot a graph from raw data. This is useful for when you already have readings taken and would like to plot a graph for them. You will have to manually input the data into an array. Depending on your number of readings it might consume some time so I suggest you use a serial device to take those readings again and input them into your laptop.
4. Programmed Data
   - You can also make data using programming for example:

      ```Processing
      // This code produces a square wave of wavelength 34 units (2*17)
      for (int i = 0; i < GP.totalPoints; i+=17) {
        for (int i2 = 0; i2 < 18; i2++) {
          i++;
          if (i + 17 < GP.totalPoints) {
            Graph1[i] = 0;
            Graph1[i + 17] = 1;}
        }
      }
      ```

## Drawing Methods

The Graph Plotter class contains 2 methods used for drawing

```Processing
GP.fillBackground(color(255, 255, 255));
GP.DrawGrid();
GP.DrawGraph(Graph1, color(255, 0, 0));
GP.DrawSegment(true, window-x1, window-y1, window-x2, window-y2);
GP.xCo(x-value);
GP.yCo(y-value);
```

1. DrawGrid
   - It draws the grid for the GP object based on the parameters set in the ```GridSetup(...);``` fucntion
   - > Note that using this function is perfectly optional and the code will run as expected
     > ![Graph without Grid](/Graph%20Plotter/images/screenshots/Screenshot%20(5).png)
     > ![Graph 2 without Grid](/Graph%20Plotter/images/screenshots/Screenshot%20(7).png)

2. DrawGraph
   - float[] graph
     - It takes the array of which the data needs to be plotted from
   - color graphColor
     - It sets the color to be used for plotting this graph
     - ```color(255,0,0)``` can be used as a parameter directly to give rgb values as parameter
     - > You can use any color you want to
       > ![Graph with different colors](/Graph%20Plotter/images/screenshots/Screenshot%20(9).png)

3. fillBackground
   - It colours the background with the color given to it as a parameter
   - Inherently the background is transparent until changed using this function

4. DrawSegment
   - Draws a straight line from (x1, y1) to (x2, y2)
   - The first parameter is a boolean for whether to draw points on the ends of the segment
   - Input needs to describe the location of each of the x and y in terms of it's location on the window and not on the grid.
  
5. xCo
   - This is not a standalone drawing method and displays nothing on the screen
   - It is a support function for the DrawSegment which converts the window-x into grid-x
   - ex: DrawSegment(false, GP.xCo(4), 70, GP.xCo(6), 70)
     - Draws a straight line from grid-4 to grid-6 at the height of 70
  
6. yCo
   - This is not a standalone drawing method and displays nothing on the screen
   - It is a support function for the DrawSegment which converts the window-y into grid-y
   - ex: DrawSegment(false, 40, GP.yCo(0), 50, GP.yCo(7))
     - Draws a straight line from (window-40, gird-0) to (window-50, grid-7)

### Note : The order in which the drawing methods are used is very important

As processing runs in a way that it overwrites previous values, the order of the drawing methods you use also affect your graphs.

- ```Processing
    GP.DrawGraph(...);
    GP.fillBackground(...);
    GP.DrawGrid(...);
    ```

    This will only output the Grid, as the Graph was covered by the background function

- ```Processing
    GP.DrawGrid(...);
    GP.fillBackground(...);
    GP.DrawGraph(...);
    ```

    This will only output the Graph, as the Grid was covered by the background function

- ```Processing
    GP.DrawGrid(...);
    GP.DrawGraph(...);
    GP.fillBackground(...);
    ```

    This will only output nothing, as both the Grid and the graph were covered by the background function

- ```Processing
    GP.fillBackground(...);
    GP.DrawGrid(...);
    GP.DrawGraph(...);
    ```

    This will only output a grid with the graph on top of it, they both cover the background function, hence they will be on the background defined in the function. This is a correct way to use the plotter

- ```Processing
  GP.fillBackground(...);
  GP.DrawGraph(...);
  GP.DrawGrid(...);
  ```

    This will only output a graph with the grid on top of it, they both cover the background function, hence they will be on the background defined in the function. This is correct and a much better option as it also allows to accurately decide where the point lies and compare graph to the grid.

- Also note that this all of them are completely optional methods. You may use whichever you need and however you need

### Caution: The size of each array should always be equal to the ```totalPoints``` variable of the plotter they will be plotted by

```Processing
// If data1 array is to be plotted using an object gp
// and data2 array is to be plotted using object xz
// then the appropriate data handling should be as follows

// Initializing
void setup() {
  data1 = new float[gp.totalPoints];
  data2 = new float[xz.totalPoints];
}

// filling (always make sure the for loop has i less the respective plotters` totalPoints)
void fill() {// Below this text
  for (i = 0; i < gp.totalPoints; i++) {
    data1[i] = // Your value
  }
   //         Below this text
  for (i = 0; i < xz.totalPoints; i++) {
    data2[i] = // Your value
  }
}
```

### Note : Graph Resolution management

When working with small values of x, you would sometimes desire to store data on decimal values as well. For example
Example Image here
In this Graph of x³, the line is quite straight rather than being curvy. This issue is much more visible when the grid is of a small scale, but fear not as there is a way to solve it using this.

```Processing
GP.GridSetup(-8, 8, 1, -2, 2, 1);

// Add this line between your GridSetup and DataArray initialization
GP.totalPoints *= 10;

DataArray = new float[GP.totalPoints];
```

Doing this effectively increases the number of points plotted in each graph in the by a scale of 10 changing the result to this
> ![Graph Plotter Resolution example](/Graph%20Plotter/images/screenshots/Screenshot%20(11).png)
> The above graph is a plot of ```y = x³``` where the red graph has the default resolution set by the code, and the blue line is the manually overriden resolution made using the code above

It is also important to note that you don't need to use 10 specifically, you can increase by a smaller scale or by a greater scale.
Another thing to remember is that if it can be increased it can also be decreased when working with extremely high values. It is especially recommended to manually decrease graph resolution if the difference between Xmin and Xmax is large enough to be comparable to the width of your window.

## Customization

The ```master_template.pde``` already contains an example with a graph of x³.Additionally you have already been made aware of the customiztion offered by the setup methods and the drawing methods.

Now what you need to understand is that the main use of the ```Offset(...);``` & ```SizeSetup(...)``` is. It is to allow drawing multiple graphs in the same window as other items including other graph plotter objects
![Graph with 2 plotter Objects](/Graph%20Plotter/images/screenshots/Screenshot%20(8).png)

These can be found in the ```examples``` folder

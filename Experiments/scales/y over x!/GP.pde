public class GraphPlotter {
    // Control Variables
    private boolean Points;       // Mark each Value on the graph with a dot
    private boolean SubGrid;      // Draw a smaller grid of 1/10 inside the Grid
    private String XTitle;    // Title for the X-axis
    private String YTitle;    // Title for the Y-axis

    // Grid Variables
    private float YMin;
    private float YMax;
    private float YStep;
    private int XMin;
    private int XMax;
    private float XStep;
    public  int totalPoints;  // totalnumber of points to display

    // Size Variables
    private int WidthP;
    private int HeightP;
    private int OffsetX = 0;
    private int OffsetY = 0;
    
    public String scale = "Norm";

    // Setup General Control Methods
    // Setup Graph Plotter Settings
    void GraphSetup(boolean points, boolean subGrid, String xTitle, String yTitle) {
        Points = points;
        SubGrid = subGrid;
        XTitle = xTitle;
        YTitle = yTitle;
    }

    // Setup Grid
    void GridSetup(float yMin, float yMax, float yStep, int xMin, int xMax, float xStep) {
        YMin = yMin;
        YMax = yMax;
        YStep = yStep;
        XMin = xMin;
        XMax = xMax;
        XStep = xStep;
        totalPoints = (XMax - XMin + 1);
    }

    // Setup Size
    void SizeSetup(int widthP, int heightP) {
        WidthP = widthP;
        HeightP = heightP;
    }

    // Draw at an offset
    void Offset(int offX, int offY) {
      OffsetX = offX;
      OffsetY = offY;
    }

    // fills the background of the Grid with a specific color
    void fillBackground(color backgroundColor) {
        strokeWeight(0);
        stroke(255);
        fill(backgroundColor);
        rect(OffsetX, OffsetY, (WidthP) + OffsetX, (HeightP) + OffsetY);
    }

    // Draw the Grid
    void DrawGrid() {
        // draw SubGrid
          if (SubGrid) {
            //print("Begin \n");
              // Y sub grid
              for (float i = XMin; i < XMax; i+= XStep/10) {
                  float sc = lanczosGamma(i + 1);
                  // Map each x value to a coordinate
                  float x = map(sc, lanczosGamma(XMin + 1), lanczosGamma(XMax + 1), 100, WidthP - 50);
  
                  // Draw Vertical Line
                  strokeWeight(0.5);
                  stroke(200);  // Light gray color for subgrid
                  line((x) + OffsetX, (HeightP - 50) + OffsetY, (x) + OffsetX, (50) + OffsetY);
                  //print("drawing at " + sc + " for " + i + "\n");
              }
              
              // X sub grid
              for (float i = YMin; i < YMax; i+= YStep/10) {
                  // Map each y value to a coordinate
                  float y = map(i, YMin, YMax, HeightP - 50, 50);
  
                  // Draw Horizontal Line
                  strokeWeight(0.5);
                  stroke(200);  // Light gray color for subgrid
                  line((100) + OffsetX, (y) + OffsetY, (WidthP - 50) + OffsetX, (y) + OffsetY);
              }
          }
          // Draw Main Grid
          // Y grid
          for (float i = XMin; i < XMax + 1; i+= XStep) {
              float sc = lanczosGamma(i + 1);
              // Map each x value to a coordinate
              float x = map(sc, lanczosGamma(XMin + 1), lanczosGamma(XMax + 1), 100, WidthP - 50);
  
              // Draw Vertical Line
              strokeWeight(1.5);
              stroke(160);  // Dark gray color for grid
              line((x) + OffsetX, (HeightP - 50) + OffsetY, (x) + OffsetX, (50) + OffsetY);
              //print("drawing at " + sc + " for " + i + "\n");
  
              // Display value of current x coordinate on the horizontal axis
              textAlign(CENTER);
              fill(0);
              if (i != 0 ) {  // Don't rewrite 0 on top of 0
                  text(String.valueOf(i), (x) + OffsetX, (HeightP - 30) + OffsetY);
              }
          }
  
          // X Grid
          for (float i = YMin; i < YMax + 1; i+= YStep) {
            // Map each y value to a coordinate
            float y = map(i, YMin, YMax, HeightP - 50, 50);
              
            if (y <= HeightP - 50 && y >= 50) {
              // Draw Horizontal Line
              strokeWeight(1.5);
              stroke(160);  // Dark gray color for grid
              line((100) + OffsetX, (y) + OffsetY, (WidthP - 50) + OffsetX, (y) + OffsetY);
    
              // Display value of current y coordinate on the vertical axis
              textAlign(RIGHT);
              fill(0);
              if (i != 0 ) {  // Don't rewrite 0 on top of 0
                  text(String.valueOf(i), (90) + OffsetX, (y) + OffsetY);
              }
            }
          }

        // Drawing the axes
        stroke(0); 
        strokeWeight(2); 
        fill(0);
        
        // X axis
        int y = int(map(0, YMin, YMax, HeightP - 50, 50));
        textAlign(RIGHT);
        text(String.valueOf(0), (90) + OffsetX, (y) + OffsetY);
        line((100) + OffsetX, (y) + OffsetY, (WidthP - 50) + OffsetX, (y) + OffsetY);
        
        // Y axis
        int x = int(map(0, XMin, XMax, 100, WidthP - 50));
        textAlign(CENTER);
        text(String.valueOf(0), (x) + OffsetX, (HeightP - 30) + OffsetY);
        line((x) + OffsetX, (HeightP - 50) + OffsetY, (x) + OffsetX, (50) +  OffsetY);

        // Label the axes
        fill(0);
        textAlign(CENTER);
        text(XTitle, (WidthP / 2) + OffsetX, (HeightP - 10) + OffsetY);
        textAlign(RIGHT);
        text(YTitle, (30) + OffsetX, (HeightP / 2) + OffsetY);
    }

    // Draw the graph
    void DrawGraph(float[] graph, color graphColor) {
      stroke(graphColor);
      for (int i = 0; i < totalPoints - 1; i++) {
        float X1 = 0;
        float X2 = 0;
        float Y1 = 0;
        float Y2 = 0;
        float x1 = 0;
        float x2 = 0;
        float y1 = 0;
        float y2 = 0;
        boolean drawPoints = Points;

        // Get coordinate of current value
          x1 = map(lanczosGamma(i + 1), lanczosGamma(x(0) + 1), lanczosGamma(x(totalPoints - 1) + 1), 100, WidthP - 50);
          y1 = yCo(graph[i]);
  
          // Get coordinate of next value
          x2 = map(lanczosGamma(i + 2), lanczosGamma(x(0) + 1), lanczosGamma(x(totalPoints - 1) + 1), 100, WidthP - 50);
          y2 = yCo(graph[i + 1]);
        
        // Calculate Gradient for filtering lines
        float m = (y2 - y1) / (x2 - x1);
        
        // Fill OUT variables with intitial data
        X1 = x1;
        X2 = x2;
        Y1 = y1;
        Y2 = y2;
        
        // Exception cases to force Y values inside the grid
        // Modify out variables using coordinate geometry
        
        // y1 above grid
        if (y1 < 50) {
          Y1 = 50;
          X1 = (Y1 - y1 + m*x1) / m;
          drawPoints = false;
        }
        
        // y1 below grid
        if (y1 > HeightP - 50) {
          Y1 = HeightP - 50;
          X1 = (Y1 - y1 + m*x1) / m;
          drawPoints = false;
        }
        
        // y2 above grid
        if (y2 < 50) {
          Y2 = 50;
          X2 = (Y2 - y1 + m*x1) / m;
          drawPoints = false;
        } 
        
        // y2 below grind
        if (y2 > HeightP - 50) {
          Y2 = HeightP - 50;
          X2 = (Y2 - y1 + m*x1) / m;
          drawPoints = false;
        }
        DrawSegment(drawPoints, X1, Y1, X2, Y2);
      }
    }
    
    // Draws a straight line segment from one point to another also uses boolean to decide whther to draw points on ends of the segment
    void DrawSegment(boolean drawPoint, float X1, float Y1, float X2, float Y2) {
      // Draw line from current value to next value
      strokeWeight(2);    // Thickness of 2 pixels
      line((X1) + OffsetX, (Y1) + OffsetY, (X2) + OffsetX, (Y2) + OffsetY);
      
      // Draw Points of both values
      if (drawPoint) {
        strokeWeight(10);
        point((X1) + OffsetX, (Y1) + OffsetY);
        point((X2) + OffsetX, (Y2) + OffsetY);
      }
      
    }

    // Added function to return x value using the index value
    float x(int PointNo) {
        return map(PointNo, 0 , totalPoints - 1, XMin, XMax);  // Use this for writing equations using x eg: y = 4x - 29
    }
    
    // Converts Y value on window to Y coordinate on the grid
    float yCo(float y) {
      return map(y, YMin, YMax, HeightP - 50, 50);
    }
    
    // Converts X value on window to X coordinate on the grid
    float xCo(float x) {
      return map(x, XMin, XMax, 100, WidthP - 50);
    }
}

final float PI = 3.14159265358979323846264338327950288419716939937510;

float lanczosGamma(float z) {
  float[] p = {
    676.5203681218851,
    -1259.1392167224028,
    771.32342877765313,
    -176.61502916214059,
    12.507343278686905,
    -0.13857109526572012,
    9.9843695780195716e-6,
    1.5056327351493116e-7
  };

  int g = 7;
  
  if (z < 0.5) {
    // Reflection formula to handle values less than 0.5
    return PI / (sin(PI * z) * lanczosGamma(1 - z));
  }

  z -= 1;
  float x = 0.99999999999980993;
  for (int i = 0; i < p.length; i++) {
    x += p[i] / (z + i + 1);
  }
  float t = z + g + 0.5;
  return sqrt(2 * PI) * pow(t, z + 0.5) * exp(-t) * x;
}

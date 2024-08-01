public class GraphPlotter {
    // Control Variables
    private boolean Points;       // Mark each Value on the graph with a dot
    private boolean SubGrid;      // Draw a smaller grid of 1/10 inside the Grid
    private String XTitle;    // Title for the X-axis
    private String YTitle;    // Title for the Y-axis

    // Grid Variables
    private int YMin;
    private int YMax;
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
    private color bg = color(255,255,255);

    // Setup General Control Methods
    // Setup Graph Plotter Settings
    void GraphSetup(boolean points, boolean subGrid, String xTitle, String yTitle) {
        Points = points;
        SubGrid = subGrid;
        XTitle = xTitle;
        YTitle = yTitle;
    }

    // Setup Grid
    void GridSetup(int yMin, int yMax, float yStep, int xMin, int xMax, float xStep) {
        YMin = yMin;
        YMax = yMax;
        YStep = yStep;
        XMin = xMin;
        XMax = xMax;
        XStep = xStep;
        totalPoints = XMax - XMin + 1;
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

    void fillBackground(color backgroundColor) {
        strokeWeight(0);
        stroke(255);
        fill(backgroundColor);
        rect(OffsetX, OffsetY, (WidthP) + OffsetX, (HeightP) + OffsetY);
        bg = backgroundColor;
    }

    // Draw the Grid
    void DrawGrid() {
      
        strokeWeight(0);
        stroke(255);
        fill(bg);
        // Clear Bottom
        rect(OffsetX, (HeightP - 50) + OffsetY, WidthP, 50);
        // Clear Side
        rect(OffsetX, OffsetY, 100, HeightP);

        // draw SubGrid
        if (SubGrid) {

            // Y sub grid
            for (float i = XMin; i < XMax; i+= XStep/10) {
                // Map each x value to a coordinate
                int x = int(map(i, XMin, XMax, 100, WidthP - 50));

                // Draw Vertical Line
                strokeWeight(0.5);
                stroke(200);  // Light gray color for subgrid
                line((x) + OffsetX, (HeightP - 50) + OffsetY, (x) + OffsetX, (50) + OffsetY);
            }
            
            // X sub grid
            for (float i = YMin; i < YMax + 1; i+= YStep/10) {
                // Map each y value to a coordinate
                int y = int(map(i, YMin, YMax, HeightP - 50, 50));

                // Draw Horizontal Line
                strokeWeight(0.5);
                stroke(200);  // Light gray color for subgrid
                line((100) + OffsetX, (y) + OffsetY, (WidthP - 50) + OffsetX, (y) + OffsetY);
            }
        }
        // Draw Main Grid
        // Y grid
        for (float i = XMin; i < XMax + 1; i+= XStep) {
            // Map each x value to a coordinate
            int x = int(map(i, XMin, XMax, 100, WidthP - 50));

            // Draw Vertical Line
            strokeWeight(1.5);
            stroke(160);  // Dark gray color for grid
            line((x) + OffsetX, (HeightP - 50) + OffsetY, (x) + OffsetX, (50) + OffsetY);

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
            int y = int(map(i, YMin, YMax, HeightP - 50, 50));

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

        // Get coordinate of current value
        float x1 = map(i, 0, totalPoints - 1, 100, WidthP - 50);
        float y1 = map(graph[i], YMin, YMax, HeightP - 50, 50);

        // Get coordinate of next value
        float x2 = map(i + 1, 0, totalPoints - 1, 100, WidthP - 50);
        float y2 = map(graph[i + 1], YMin, YMax, HeightP - 50, 50);

        // Draw line from current value to next value
        strokeWeight(2);    // Thickness of 2 pixels
        line((x1) + OffsetX, (y1) + OffsetY, (x2) + OffsetX, (y2) + OffsetY);

        // Draw Points of both values
        if (Points) {
            strokeWeight(10);
            point((x1) + OffsetX, (y1) + OffsetY);
            point((x2) + OffsetX, (y2) + OffsetY);
        }
      }
    }

    // Added function to return x value using the index value
    float x(int PointNo) {
        return map(PointNo, 0 , totalPoints - 1, XMin, XMax);  // Use this for writing equations using x eg: y = 4x - 29
    }
}

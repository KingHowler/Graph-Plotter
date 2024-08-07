GraphPlotter GP1;
GraphPlotter GP2;

float[] DataArrayLowResolution;
float[] DataArrayHighResolution;

void setup() {
  size(1200, 1000);
  
  GP1 = new GraphPlotter();
  GP1.GraphSetup(false, false, "", "");
  GP1.GridSetup(-8, 8, 2, -2, 2, 1);
  GP1.SizeSetup(width - 150, height - 150);
  GP1.Offset(50, 50);
  
  GP2 = new GraphPlotter();
  GP2.GraphSetup(false, false, "", "");
  GP2.GridSetup(-8, 8, 2, -2, 2, 1);
  GP2.SizeSetup(width - 150, height - 150);
  GP2.Offset(50, 50);
  
  GP2.totalPoints *= 10;
  
  DataArrayLowResolution = new float[GP1.totalPoints];
  DataArrayHighResolution = new float[GP2.totalPoints];
  
  fillData();
}

void fillData() {
  for (int i = 0; i < GP1.totalPoints; i++) {
    DataArrayLowResolution[i] = GP1.x(i)*GP1.x(i)*GP1.x(i);
  }
  for (int i = 0; i < GP2.totalPoints; i++) {
    DataArrayHighResolution[i] = GP2.x(i)*GP2.x(i)*GP2.x(i);
  }
}

void draw() {
  GP1.fillBackground(color(255));
  GP1.DrawGrid();
  GP1.DrawGraph(DataArrayLowResolution, color(255,0,0));
  GP2.DrawGraph(DataArrayHighResolution, color(0,0,255));
}

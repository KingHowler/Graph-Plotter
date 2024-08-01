GraphPlotter GP = new GraphPlotter();
float[] DataHolder ;

void setup() {
  size(1000, 600);
  GP.GraphSetup(false, false, "X axis", "Yaxis");
  GP.GridSetup(-8, 8, 1, -2, 2, 1);
  GP.totalPoints *= 10;
  GP.SizeSetup(width - 150, height - 150);
  GP.Offset(50, 50);
  DataHolder = new float[GP.totalPoints];
  
  fillData();
}

void fillData() {
  for (int i = 0; i < GP.totalPoints; i++) {
    DataHolder[i] = GP.x(i)*GP.x(i)*GP.x(i);
  }
}

void draw() {
  GP.fillBackground(color(255));
  GP.DrawGrid();
  GP.DrawGraph(DataHolder, color(255, 0, 0));
}

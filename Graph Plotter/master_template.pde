GraphPlotter GP = new GraphPlotter();
float[] DataHolder ;

void setup() {
  size(1000, 600);
  GP.GraphSetup(true, false, "X axis", "Yaxis");
  GP.GridSetup(-220, 220, 20, -6, 6, 1);
  GP.SizeSetup(width - 100, height - 100);
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
  background(255);
  GP.DrawGrid();
  GP.DrawGraph(DataHolder, color(255, 0, 0));
}

GraphPlotter GP = new GraphPlotter();
float[] DataHolder;

void setup() {
  size(1900, 900);
  GP.GraphSetup(true, true, "X axis", "Yaxis");
  GP.GridSetup(-100, 100, 100, 0, 20, 5);
  GP.totalPoints *= 10;
  GP.SizeSetup(width - 150, height - 150);
  GP.Offset(50, 50);
  DataHolder = new float[GP.totalPoints];
  
  fillData();
}

void fillData() {
  for (int i = 0; i < GP.totalPoints; i++) {
    DataHolder[i] = fib(GP.x(i));
  }
}

void draw() {
  GP.fillBackground(color(255));
  GP.DrawGrid();
  //GP.DrawGraph(DataHolder, color(255, 0, 0));
  stroke(255, 0, 0);
  GP.DrawSegment(true, GP.xCo(10), GP.yCo(20), GP.xCo(15), GP.yCo(40));
}

float fib(float n) {
  if (n <= 1) {
    return n;
  } else {
    return fib(n-1) + fib(n-2);
  }
}

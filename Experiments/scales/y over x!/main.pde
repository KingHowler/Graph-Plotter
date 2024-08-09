GraphPlotter GP;

float[] DataArray;

void setup() {
  size(1900, 900);
  
  GP = new GraphPlotter();
  GP.GraphSetup(false, true, "", "");
  GP.GridSetup(0, lanczosGamma(5 + 1), 20, 0, 5, 1);
  GP.SizeSetup(width, height);
  
  DataArray = new float[GP.totalPoints];
  
  for(int i = 0; i < GP.totalPoints; i++) {
   DataArray[i] = lanczosGamma(i + 1); 
   print(DataArray[i] + "\n");
  }
}

void draw() {
  GP.fillBackground(color(255));
  GP.DrawGrid();
  GP.DrawGraph(DataArray, color(255,0,0));
}

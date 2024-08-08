import processing.pdf.*;

GraphPlotter GP;

float[] DataArray;

void setup() {
  size(1900, 900, PDF, "logscale.pdf");
  
  GP = new GraphPlotter();
  GP.GraphSetup(false, true, "", "");
  GP.GridSetup(0, 500, 100, 0, 500, 1);
  GP.totalPoints *= 1;
  GP.SizeSetup(width, height);
  GP.scale = "lnX";
  
  DataArray = new float[GP.totalPoints];
  
  fillData();
}

void draw() {
  GP.fillBackground(color(255));
  GP.DrawGraph(DataArray, color(0, 120, 198));
  GP.DrawGrid();
  exit();
}

void fillData() {
  for(int i = 0; i < GP.totalPoints; i++) {
    DataArray[i] = exp(GP.x(i));
    if(DataArray[i] == 0) {
      DataArray[1] = 10;
    }
  }
}

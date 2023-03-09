

float angleX = 0.0;
float incX = 0.0;
float angleY = 0.0;
float t = 0.0;
final float incT = 0.001;

PMatrix3D M = new PMatrix3D();
 
void setup()  { 
  size(640, 640, P3D); 
  noStroke(); 
  colorMode(RGB, 1); 

} 
 
PVector u = new PVector(0, 1, 0); // Y axis
PVector v = new PVector(1/sqrt(2.0), 1/sqrt(2.0), 0); // Dirction (1,1) axis
//PVector v = new PVector(1, 0, 0);
  
  
  
  
void draw()  { 
  background(0);
  
  
  angleX += incX;  
  if (startInt) {
    t += incT;
    if (t>1.0) {
      t = 0;
    }
  }
  
  
  Quaternion q1 = new Quaternion(angleX, u);
  Quaternion q2 = new Quaternion(angleX, v);
  Quaternion current = new Quaternion();
  
  pushMatrix();
 
  if (startInt) {
    current = current.slerp(q1, q2, t);
    M = current.toMatrix();
  }else {
    M = q1.toMatrix();
  }
  
  stroke(0, 1, 0);
  translate(width/2, height/2, -30);
  drawLine(u);
  stroke(1, 0, 0);
  if (startInt) {
    drawLine(v);
    //drawLine();
    stroke(0, 0, 1);
    
    drawLine(current.getAxis());
  }
  
  
  noStroke(); 
 
  popMatrix();
  drawCube();
} 

void drawLine(PVector u) {
  line(-300*u.x,-300*u.y , -300*u.z, 300*u.x, 300*u.y, 300*u.z); 
}

void drawCube() {
  pushMatrix(); 
  translate(width/2, height/2, -30); 
  applyMatrix(M);
  scale(90);
  rotateY(angleY);
  
  beginShape(QUADS);

  fill(1, 0, 0); vertex(-1,  1,  1);
  fill(1, 0, 0); vertex( 1,  1,  1);
  fill(1, 0, 0); vertex( 1, -1,  1);
  fill(1, 0, 0); vertex(-1, -1,  1);

  fill(1, 1, 1); vertex( 1,  1,  1);
  fill(1, 1, 1); vertex( 1,  1, -1);
  fill(1, 1, 1); vertex( 1, -1, -1);
  fill(1, 1, 1); vertex( 1, -1,  1);

  fill(1, 1, 0); vertex( 1,  1, -1);
  fill(1, 1, 0); vertex(-1,  1, -1);
  fill(1, 1, 0); vertex(-1, -1, -1);
  fill(1, 1, 0); vertex( 1, -1, -1);

  fill(0, 1, 0); vertex(-1,  1, -1);
  fill(0, 1, 0); vertex(-1,  1,  1);
  fill(0, 1, 0); vertex(-1, -1,  1);
  fill(0, 1, 0); vertex(-1, -1, -1);

  fill(0, 1, 1); vertex(-1,  1, -1);
  fill(0, 1, 1); vertex( 1,  1, -1);
  fill(0, 1, 1); vertex( 1,  1,  1);
  fill(0, 1, 1); vertex(-1,  1,  1);

  fill(1, 0, 1); vertex(-1, -1, -1);
  fill(1, 0, 1); vertex( 1, -1, -1);
  fill(1, 0, 1); vertex( 1, -1,  1);
  fill(1, 0, 1); vertex(-1, -1,  1);

  endShape(QUADS);
  
  popMatrix(); 
}


boolean startInt = false;

void keyPressed() {
   if (key == ' ') {
      if (incX > 0.0) {
        incX = 0.0;
      }else {
        incX = 0.01;
      }
   }
   
   if (key == 'i') {
     print(key);
     startInt = !startInt;
   }
   
   if (key == 'r') {
       t = 0.0;
       startInt = false;
       angleX = 0;
       incX = 0.0;
   }
}

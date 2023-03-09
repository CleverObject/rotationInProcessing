import java.util.Stack;  // for your matrix stack
Stack<PMatrix2D> matrixStack = new Stack<PMatrix2D>();

void setup() {
  size(1000, 1000);  // don't change, and don't use the P3D renderer
  colorMode(RGB, 1.0f);
  // put additional setup here
  Vp = getViewPort();
  matrixStack.push(M.get());
}

PMatrix2D M = new PMatrix2D();
PMatrix2D V = new PMatrix2D();
PMatrix2D Pr = new PMatrix2D();
PMatrix2D Vp = new PMatrix2D();

int off = 100;
void draw() {
  background(0);
  switch (testMode) {
  case PATTERN:
    drawTest(1000);
    drawTest(100);
    drawTest(1);
    break;
  case SCENE:
    drawScene();
    break;
  }
}

// feel free to add a new file for drawing your scene
void drawScene() {
  background(0);
  
  //Layer 1
  myPush();
  myTranslate(0, 150);
  myScale(0.5, 0.5);
  drawPerson();
  
    myPush();
      myRotate(-PI/6);
      myTranslate(100, 100);
      drawPerson();
      
      myPush();
        myRotate(-PI/6);
        myTranslate(300, 300);
        drawPerson();
           myPush();
          myRotate(-PI/6);
          myTranslate(300, 300);
          drawPerson();
              myPush();
              myRotate(-PI/6);
              myTranslate(300, 300);
              drawPerson();
              myPop();
          myPop();
      myPop();
      
    myPop();
  myPop();
}

void drawPerson() {
drawCube1(); // body
  drawStick();
  drawHead();

}


void drawHead() {
  myPush(); // Layer 
    myTranslate(0, -225);
    myScale(0.5, 0.5);
    drawCube1();
    
    myPush();
      myRotate(-PI/2);
      drawTrangleFan();
      
      myPush();
      
      myPop();
      
      
    myPop();
  myPop();
}


void drawCube1() {
  stroke(1);
  strokeWeight(3);
  fill(1.0, 0.0, 0.0);
  beginShape(QUADS);
  myVertex(-150, 150);
  myVertex(-150, -150);
  myVertex(150, -150);
  myVertex(150, 150);
  endShape();
}

void drawStick() {
  myPush();
  myTranslate(230, 600);
  myScale(1.0, 1.5);
  drawLegs();
  myPop();
}

void mouseDragged() {
  /*
   how much the mouse has moved between this frame and the previous one,
   measured in viewport coordinates - you will have to do further
   calculations with these numbers
   */
  float xMove = mouseX - pmouseX;
  float yMove = mouseY - pmouseY;
  // implement click-and-drag panning here
  center.x += xMove / zoom / sx;
  center.y += yMove / zoom / sy;
  
  //PVector tv = new PVector(ox, oy);
  V = getCamera(center, up, perp, zoom);
}

void mousePressed() {
  // right-click to zoom in place
  print("clicked");
  
  
  
}




// Some shapes 
void drawTrangleFan() {
  fill(0.3, 0.5, 0.5);
  beginShape(TRIANGLE_FAN);
    myVertex(230, 200);
   myVertex(230, 60); 
   myVertex(368, 200); 
   myVertex(230, 340); 
    myVertex(88, 200); 
    myVertex(230, 60); 
endShape();
}


void drawLegs() {
  beginShape(QUADS);
myVertex(120, 80);
myVertex(120, 300);
myVertex(200, 300);
myVertex(200, 80);
myVertex(260, 80);
myVertex(260, 300);
myVertex(340, 300);
myVertex(340, 80);
endShape();
}

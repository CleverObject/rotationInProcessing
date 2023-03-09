// don't change these keys
final char KEY_ROTATE_CW = ']';
final char KEY_ROTATE_CCW = '[';
final char KEY_ZOOM_IN = '='; // plus sign without the shift
final char KEY_ZOOM_OUT = '-';
final char KEY_ORTHO_MODE = 'o';
final char KEY_DISPLAY_MODE = 'd';

enum OrthoMode {
  IDENTITY, // straight to viewport with no transformations (Pr, V and M are all the identity)
    CENTER600, // bottom left is (-300,-300), top right is (300,300), center is (0,0)
    TOPRIGHT600, // bottom left is o(0,0), top right is (600,600)
    FLIPX, // same as CENTER600 but reflected through y axis (x -> -x)
    ASPECT // uneven aspect ratio: x is from -300 to 300, y is from -100 to 100
}
OrthoMode orthoMode = OrthoMode.IDENTITY;

enum DisplayMode {
    PATTERN, 
    SCENE
}
DisplayMode testMode = DisplayMode.PATTERN;
//DisplayMode testMode = DisplayMode.SCENE;

//Initial angle and scale
float angle = 0.0;
float scale = 1.0;

// Proportion changed by projection mode
float sx = 1.0;
float sy = 1.0;

void keyPressed() {
  
  if (keyCode == KEY_ROTATE_CW) {
    angle+=0.1;
    updateUpAndPerp();
      
  }else if (keyCode == KEY_ROTATE_CCW) {
    angle-=0.1;
    updateUpAndPerp();
    
  }else if (keyCode == KEY_ZOOM_IN) {
    zoom *= 1.1;
    updateV();
   }else if (keyCode == KEY_ZOOM_OUT) {
    zoom *= 0.9;
    updateV();
  }else if (key == KEY_ORTHO_MODE) {
    
    //// Press 'o' to switch orthoMode
    if (orthoMode == OrthoMode.IDENTITY) {
      orthoMode = OrthoMode.CENTER600;
      Pr = getOrtho(-300,300,-300,300);
      
    }else if (orthoMode == OrthoMode.CENTER600) {
      orthoMode = OrthoMode.TOPRIGHT600;
      Pr = getOrtho(0, 600, 0, 600);
      
    }else if (orthoMode == OrthoMode.TOPRIGHT600) {
      orthoMode = OrthoMode.FLIPX;
      Pr = getOrtho(300, -300, -300, 300);
      
    }else if (orthoMode == OrthoMode.FLIPX) {
      orthoMode = OrthoMode.ASPECT;
      Pr = getOrtho(-300,300,-100,100);
     
    }else if (orthoMode == OrthoMode.ASPECT) {
      orthoMode = OrthoMode.IDENTITY;
      Pr.reset();
      sx = 1.0;
      sy = 1.0;
    }
  }else if (key == KEY_DISPLAY_MODE) {
    if (testMode == DisplayMode.PATTERN) {
        testMode = DisplayMode.SCENE;
    }else {
       testMode = DisplayMode.PATTERN;
    }
  }
} 

void updateUpAndPerp() {
  PMatrix2D r = rotateMatrix(angle);
    up.x = r.multX(up.x, up.y);
    up.y = r.multY(up.x, up.y);
    perp = r.mult(perp, perp);
    updateV();
}

void updateV() {
  V = getCamera(center, up, perp, zoom);
}


final int NUM_LINES = 11;
// draw a test pattern, centered on (0,0), with the given scale
void drawTest(float scale) {
    float left, right, top, bottom;
    left = bottom = -scale/2;
    right = top = scale/2;

    strokeWeight(1);
    beginShape(LINES);
    for (int i=0; i<NUM_LINES; i++) {
      float x = left + i*scale/(NUM_LINES-1);
      float y = bottom + i*scale/(NUM_LINES-1);

      setHorizontalColor(i);
      myVertex(left, y);
      myVertex(right, y);
  
      setVerticalColor(i);
      myVertex(x, bottom);
      myVertex(x, top);
    }
  endShape(LINES);
}

void setHorizontalColor(int i) {
  int r, g, b;
  r = (i > NUM_LINES/2) ? 0 : 1;
  g = (i > NUM_LINES/2) ? 1 : 0;
  b = 0;
  stroke(r, g, b);
}

void setVerticalColor(int i) {
  int r, g, b;
  r = (i > NUM_LINES/2) ? 1 : 0;
  g = (i > NUM_LINES/2) ? 1 : 0;
  b = (i > NUM_LINES/2) ? 0 : 1;
  stroke(r, g, b);
}

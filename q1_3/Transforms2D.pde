// construct viewport matrix using width and height of canvas
PMatrix2D getViewPort() {
  return new PMatrix2D(1.0, 0.0, width/2, 0.0, -1.0, height/2);
}

// construct projection matrix using 2D boundaries
PMatrix2D getOrtho(float left, float right, float bottom, float top) {
  sx =  width/(right - left);
  sy =  height/(top - bottom);
  PMatrix2D s = scaleMatrix(width/(right - left), height/(top - bottom));
  PMatrix2D t = translateMatrix(-(left + right) / 2, -(bottom + top) / 2);
  s.apply(t);
  return s;
}

PVector center = new PVector(0.0, 0.0);
PVector up = new PVector(0, 1.0);
PVector perp = new PVector(1.0, 0);
float zoom = 1.0;

// construct camera matrix using camera position, up vector, and zoom setting
PMatrix2D getCamera(PVector center, PVector up, PVector perp, float zoom) {
  PMatrix2D s = scaleMatrix(zoom, zoom);
  PMatrix2D t = translateMatrix(center.x, -center.y);
  s.apply(t);
  PMatrix2D r = rotateMatrix(angle);
  s.apply(r);
  return s;
}

PMatrix2D scaleMatrix(float sx, float sy) {
  return new PMatrix2D(sx, 0.0, 0.0, 0.0, sy, 0.0);
}

PMatrix2D translateMatrix(float tx, float ty) {
  return new PMatrix2D(1.0, 0.0, tx, 0.0, 1.0, ty);
}

PMatrix2D rotateMatrix(float angle) {
  return new PMatrix2D(cos(angle), sin(angle), 0.0, -sin(angle), cos(angle), 0.0);
}

/*
Functions that manipulate the matrix stack
 */

void myPush() {
  matrixStack.push(M.get());
}

void myPop() {
  M = matrixStack.pop();
  
}

/*
Functions that update the model matrix
 */

void myScale(float sx, float sy) {
  PMatrix2D ms = scaleMatrix(sx, sy);
    applyMyMatrix(ms);
}


void myTranslate(float tx, float ty) {
   PMatrix2D mt = translateMatrix(-tx, -ty);
   applyMyMatrix(mt);
   
}

void myRotate(float theta) {
  //print(matrixStack.size());
  PMatrix2D mr = rotateMatrix(theta);
  applyMyMatrix(mr);
}

void applyMyMatrix(PMatrix2D mat) {
  //PMatrix2D top = matrixStack.peek();
  // PMatrix2D copy = top.get();
  // //top.apply(mat);
   M.apply(mat);
  
   
  //PMatrix2D VpCp = Vp.get();
  //VpCp.apply(Pr);
  //VpCp.apply(V);
  //VpCp.apply(M);
  // applyMatrix(VpCp);
}


/*
Receives a point in object space and applies the complete transformation
 pipeline, Vp.Pr.V.M.point, to put the point in viewport coordinates.
 Then calls vertex to plot this point on the raster
 */
void myVertex(float x, float y) {
  // apply transformations here
 
  PMatrix2D VpCp = Vp.get();
  VpCp.apply(Pr);
  VpCp.apply(V);
  VpCp.apply(M);
  float xp = VpCp.multX(x, y);
  float yp = VpCp.multY(x, y);
  
  // this is the only place in your program where you are allowed
  // to use the vertex command
  vertex(xp, yp);
}

// overload for convenience
void myVertex(PVector vert) {
  myVertex(vert.x, vert.y);
}

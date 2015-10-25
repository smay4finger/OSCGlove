import netP5.*;
import oscP5.*;

import processing.serial.*;
import controlP5.*;
import java.util.*;

PShape hand;

void setup() {
  size(300, 300, P3D);
  frameRate(30);

  createUI();

  hand = createShape(BOX, 100, 10, 100);
  hand.setFill(0x20ff0000);
}

void draw() {
  hint(ENABLE_DEPTH_TEST);
  pushMatrix();

  background(128);

  stroke(255, 255, 0);
  strokeWeight(4);
  line( width/2, 
    height/2, 
    0, 
    -gloveLinearY * 10.0 + width/2, 
    gloveLinearZ * 10.0 + height/2, 
    -gloveLinearX * 10.0);

  stroke(0, 255, 0);
  line(width/2, 
    height/2, 
    0, 
    -gloveGravityY * 10.0 + width/2, 
    gloveGravityZ * 10.0 + height/2, 
    -gloveGravityX * 10.0);

  hand.resetMatrix();
  hand.rotateZ(radians(-gloveEulerZ));
  hand.rotateX(radians(-gloveEulerY));
  hand.translate(width/2, height/2);
  shape(hand);


  popMatrix();
  hint(DISABLE_DEPTH_TEST);
}
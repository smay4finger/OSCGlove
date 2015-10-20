import netP5.*;
import oscP5.*;

import processing.serial.*;
import controlP5.*;
import java.util.*;

PShape hand;

void setup() {
  size(500, 300, P3D);
  frameRate(30);

  createUI();

  hand = createShape(BOX, 100, 10, 100);
}

void draw() {
  background(128);
  
  hand.resetMatrix();
  hand.rotateZ(radians(-gloveOrientationZ));
  hand.rotateX(radians(-gloveOrientationY));
  hand.translate(width/2, height/2);

  shape(hand);
}
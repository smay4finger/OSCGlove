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
  hand.setFill(0xffff0000);
}

void draw() {
  hint(ENABLE_DEPTH_TEST);
  pushMatrix();

  background(128);

  hand.resetMatrix();
  hand.rotateZ(radians(-gloveEulerZ));
  hand.rotateX(radians(-gloveEulerY));
  hand.translate(width/2, height/2);

  shape(hand);

  popMatrix();
  hint(DISABLE_DEPTH_TEST);
}
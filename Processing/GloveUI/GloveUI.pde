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

  hand = createShape(BOX, 30, 30, 10);
}

void draw() {
  background(128);

  hand.resetMatrix();
  hand.rotateY(map(mouseX, 0, width, 0, PI*2));
  hand.rotateX(map(mouseY, 0, height, 0, PI*2));
  hand.translate(width/2, height/2);

  shape(hand);
}
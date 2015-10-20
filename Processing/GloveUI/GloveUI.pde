import processing.serial.*;
import controlP5.*;
import java.util.*;

PShape hand;

void setup() {
  size(500, 300, P3D);
  frameRate(30);
  
  createUI();

  hand = createShape(BOX, 30, 30, 10);
  hand.rotateX(0.5);
  hand.rotateY(0.5);
  hand.rotateZ(0.5);
}

void draw() {
  background(129);
  
  hand.resetMatrix();
  hand.rotateX(map(mouseY, 0, width, 0, PI));
  hand.rotateZ(map(mouseX, 0, width, 0, PI));
  hand.translate(width/2, height/2);
  
  shape(hand);
}
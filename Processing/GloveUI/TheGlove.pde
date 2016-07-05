Serial glove;

public volatile float gloveEulerX = 0.0;
public volatile float gloveEulerY = 0.0;
public volatile float gloveEulerZ = 0.0;

public volatile float gloveLinearX = 0.0;
public volatile float gloveLinearY = 0.0;
public volatile float gloveLinearZ = 0.0;

public volatile float gloveGravityX = 0.0;
public volatile float gloveGravityY = 0.0;
public volatile float gloveGravityZ = 0.0;

public volatile int gloveMiddleFinger = 0;
public volatile int gloveRingFinger = 0;
public volatile int gloveLittleFinger = 0;

public volatile int gloveButtons = 0;

public void gloveConnect(String serialPort) {
  if (glove != null) {
    gloveDisconnect();
  }
  println("glove connect to " + serialPort);
  glove = new Serial(this, serialPort, 115200);
  glove.bufferUntil('\n');
}

public void gloveDisconnect() {
  if (glove != null) {
    println("glove disconnect");
    glove.stop();
    glove = null;
  }
}

void serialEvent(Serial p) {
  String inString = p.readString();
  try {
    JSONObject data = parseJSONObject(inString);
    gloveEulerX = data.getJSONObject("e").getFloat("x");
    gloveEulerY = data.getJSONObject("e").getFloat("y");
    gloveEulerZ = data.getJSONObject("e").getFloat("z");
    gloveLinearX = data.getJSONObject("l").getFloat("x");
    gloveLinearY = data.getJSONObject("l").getFloat("y");
    gloveLinearZ = data.getJSONObject("l").getFloat("z");
    gloveGravityX = data.getJSONObject("g").getFloat("x");
    gloveGravityY = data.getJSONObject("g").getFloat("y");
    gloveGravityZ = data.getJSONObject("g").getFloat("z");
    gloveMiddleFinger = data.getInt("m");
    gloveRingFinger = data.getInt("r");
    gloveLittleFinger = data.getInt("lf");
    gloveButtons = data.getInt("b");

    float alpha = radians(-45);
    float x, y, z;
    
    // rotate euler coordinates about X axis by -45°
    x = gloveEulerX;
    y = cos(alpha)*gloveEulerY - sin(alpha)*gloveEulerZ;
    z = sin(alpha)*gloveEulerY + cos(alpha)*gloveEulerZ;
    gloveEulerX = x;
    gloveEulerY = y;
    gloveEulerZ = z;

    // rotate gravity coordinates about Z axis by -45°
    alpha = radians(45);
    x = cos(alpha)*gloveGravityX - sin(alpha)*gloveGravityY;
    y = sin(alpha)*gloveGravityX + cos(alpha)*gloveGravityY;
    z = gloveGravityZ;
    gloveGravityX = x;
    gloveGravityY = y;
    gloveGravityZ = z;
    
    oscUpdate();
    uiUpdate();
  }
  catch(RuntimeException e) {
    println("Hell " + e);
  }
}
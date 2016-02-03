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
    gloveEulerX = data.getJSONObject("euler").getFloat("x");
    gloveEulerY = data.getJSONObject("euler").getFloat("y");
    gloveEulerZ = data.getJSONObject("euler").getFloat("z");
    gloveLinearX = data.getJSONObject("linear").getFloat("x");
    gloveLinearY = data.getJSONObject("linear").getFloat("y");
    gloveLinearZ = data.getJSONObject("linear").getFloat("z");
    gloveGravityX = data.getJSONObject("gravity").getFloat("x");
    gloveGravityY = data.getJSONObject("gravity").getFloat("y");
    gloveGravityZ = data.getJSONObject("gravity").getFloat("z");
    gloveMiddleFinger = data.getInt("a1");
    gloveRingFinger = data.getInt("a2");
    gloveLittleFinger = data.getInt("a3");

    oscUpdate();
    uiUpdate();
  }
  catch(RuntimeException e) {
    // ignore
    // there is no other chance, as Processing is doint this by design
  }
}
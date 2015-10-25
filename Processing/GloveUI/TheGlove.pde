Serial glove;

public volatile float gloveEulerX = 0.0;
public volatile float gloveEulerY = 0.0;
public volatile float gloveEulerZ = 0.0;

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

    oscUpdate();
    uiUpdate();
  }
  catch(RuntimeException e) {
    // ignore
    // there is no other chance, as Processing is doint this by design
  }
}
Serial glove;

public volatile float gloveOrientationX = 0.0;
public volatile float gloveOrientationY = 0.0;
public volatile float gloveOrientationZ = 0.0;

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
    gloveOrientationX = data.getJSONObject("orientation").getFloat("x");
    gloveOrientationY = data.getJSONObject("orientation").getFloat("y");
    gloveOrientationZ = data.getJSONObject("orientation").getFloat("z");
    oscUpdate();
  }
  catch(RuntimeException e) {
    // ignore
    // there is no other chance, as Processing is doint this by design
  }
}

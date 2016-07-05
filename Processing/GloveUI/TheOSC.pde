OscP5 oscClient;

void oscConnect(String hostname, int port) {
  if (oscClient != null) {
    oscDisconnect();
  }
  println("OSC connect to " + hostname + ":" + port);

  OscProperties properties = new OscProperties();
  properties.setRemoteAddress(hostname, port);
  properties.setListeningPort(port);
  properties.setSRSP(OscProperties.ON);
  properties.setDatagramSize(1024);
  oscClient = new OscP5(this, properties);
}

void oscDisconnect() {
  if (oscClient != null) {
    println("OSC disconnect");
    oscClient.stop();
    oscClient = null;
  }
}
static int oldButtons = 0;

static float oldGloveEulerZ = 0.0;
static float oldGloveEulerY = 0.0;
static float oldGloveEulerX = 0.0;
static int oldGloveMiddleFinger = 0;
static int oldGloveRingFinger = 0;
static int oldGloveLittleFinger = 0;

void oscUpdate() {
  if (oscClient != null) {
    if ( gloveEulerZ > (oldGloveEulerZ+uiDiffRotation.getValue()) 
          || gloveEulerZ < (oldGloveEulerZ-uiDiffRotation.getValue()) ) {
      oscClient.send("/glove/Z", new Object[] { gloveEulerZ });
      oldGloveEulerZ = gloveEulerZ;
    }
    if ( gloveEulerY > (oldGloveEulerY+uiDiffRotation.getValue()) 
          || gloveEulerY < (oldGloveEulerY-uiDiffRotation.getValue()) ) {
      oscClient.send("/glove/Y", new Object[] { gloveEulerY });
      oldGloveEulerY = gloveEulerY;
    }
    if ( gloveEulerX > (oldGloveEulerX+uiDiffRotation.getValue()) 
          || gloveEulerX < (oldGloveEulerX-uiDiffRotation.getValue()) ) {
      oscClient.send("/glove/X", new Object[] { gloveEulerX });
      oldGloveEulerY = gloveEulerX;
    }
    if ( gloveMiddleFinger > (oldGloveMiddleFinger+uiDiffFinger.getValue()) 
          || gloveMiddleFinger < (oldGloveMiddleFinger-uiDiffFinger.getValue()) ) {
      oscClient.send("/glove/finger/middle", new Object[] { gloveMiddleFinger });
      oldGloveMiddleFinger = gloveMiddleFinger;
    }
    if ( gloveRingFinger > (oldGloveRingFinger+uiDiffFinger.getValue()) 
          || gloveRingFinger < (oldGloveRingFinger-uiDiffFinger.getValue()) ) {
      oscClient.send("/glove/finger/ring", new Object[] { gloveRingFinger });
      oldGloveRingFinger = gloveRingFinger;
    }
    if ( gloveLittleFinger > (oldGloveLittleFinger+uiDiffFinger.getValue()) 
          || gloveLittleFinger < (oldGloveLittleFinger-uiDiffFinger.getValue()) ) {
      oscClient.send("/glove/finger/little", new Object[] { gloveLittleFinger });
      oldGloveLittleFinger = gloveLittleFinger;
    }
    if ( gloveButtons != oldButtons ) {
      oscClient.send("/glove/buttons", new Object[] {
        (gloveButtons & 0x01) == 0,
        (gloveButtons & 0x02) == 0,
        (gloveButtons & 0x04) == 0,
        (gloveButtons & 0x08) == 0,
        });
      oldButtons = gloveButtons;
    }
  }
}

void oscEvent(OscMessage theMessage) {
}
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

void oscUpdate() {
  if (oscClient != null) {

    oscClient.send("/glove/Z", new Object[] { gloveEulerZ });
    oscClient.send("/glove/Y", new Object[] { gloveEulerY });
    oscClient.send("/glove/X", new Object[] { gloveEulerX });
    oscClient.send("/glove/finger/middle", new Object[] { gloveMiddleFinger });
    oscClient.send("/glove/finger/ring", new Object[] { gloveRingFinger });
    oscClient.send("/glove/finger/little", new Object[] { gloveLittleFinger });

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
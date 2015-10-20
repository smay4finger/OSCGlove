OscP5 oscClient;

void oscConnect(String hostname, int port) {
  if (oscClient != null) {
    oscDisconnect();
  }
  println("OSC connect to " + hostname + ":" + port);
  oscClient = new OscP5(this, hostname, port, OscP5.TCP);
}

void oscDisconnect() {
  if (oscClient != null) {
    println("OSC disconnect");
    oscClient.stop();
    oscClient = null;
  }
}

void oscEvent(OscMessage theMessage) {
  System.out.println("### got a message " + theMessage);
}
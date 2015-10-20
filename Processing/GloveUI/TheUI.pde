ControlP5 cp5;

Textfield uiHostname;
Button uiConnectOSC;
ScrollableList uiSelectedSerialPort;
Button uiConnectSerialPort;

public void createUI() {

  cp5 = new ControlP5(this);

  CallbackListener toFront = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      theEvent.getController().bringToFront();
      ((ScrollableList)theEvent.getController()).open();
    }
  };

  CallbackListener close = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      ((ScrollableList)theEvent.getController()).close();
    }
  };

  uiHostname = cp5.addTextfield("uiHostname")
    .setPosition(5, 5)
    .setSize(150, 20)
    .setLabel("")
    .setValue("localhost")
    ;
  uiConnectOSC = cp5.addButton("uiConnectOSC")
    .setPosition(160, 5)
    .setSize(50, 20)
    .setLabel("connect")
    .setSwitch(true)
    ;
  uiSelectedSerialPort = cp5.addScrollableList("uiSelectedSerialPort")
    .addItems(Arrays.asList(Serial.list()))
    .setPosition(5, 30)
    .setSize(150, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .onEnter(toFront)
    .onLeave(close)
    .setLabel("")
    .setValue(0)
    .close()
    ;
  uiConnectSerialPort = cp5.addButton("uiConnectSerialPort")
    .setPosition(160, 30)
    .setSize(50, 20)
    .setLabel("connect")
    .setSwitch(true)
    ;
  cp5.addFrameRate()
    .setInterval(10)
    .setPosition(5, height-15)
    .setSize(40, 20)
    ;
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(uiConnectOSC)) {
    println("connect to OSC");
    if (uiConnectOSC.isOn()) {
      uiHostname.setLock(true);
    } else {
      uiHostname.setLock(false);
    }
  }

  if (theEvent.isFrom(uiConnectSerialPort)) {
    println("connect to serial port");
    if (uiConnectSerialPort.isOn()) {
      uiSelectedSerialPort.setLock(true);
      uiSelectedSerialPort.setOpen(false);
    } else {
      uiSelectedSerialPort.setLock(false);
    }
  }

  if (theEvent.isFrom(uiSelectedSerialPort)) {
    println("selected serial port " + theEvent);
    println("    " + uiSelectedSerialPort.getValue());
  }
}
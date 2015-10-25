ControlP5 cp5;

Textfield uiHostnameOSC;
Numberbox uiPortOSC;
Button uiConnectOSC;
ScrollableList uiSelectedSerialPort;
Button uiConnectSerialPort;

Slider uiOrientationX;
Slider uiOrientationY;
Slider uiOrientationZ;

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

  cp5.addTab("default");
  cp5.addTab("glove settings");
  cp5.addTab("raw");

  uiHostnameOSC = cp5.addTextfield("uiHostnameOSC")
    .setPosition(5, 25)
    .setSize(100, 20)
    .setLabel("")
    .setValue("127.0.0.1")
    ;
  uiPortOSC = cp5.addNumberbox("uiPortOSC")
    .setPosition(110, 25)
    .setSize(45, 20)
    .setLabel("")
    .setValue(8000)
    .setRange(1, 65535)
    .setDecimalPrecision(0)
    ;
  uiConnectOSC = cp5.addButton("uiConnectOSC")
    .setPosition(160, 25)
    .setSize(50, 20)
    .setLabel("connect")
    .setSwitch(true)
    ;
  uiSelectedSerialPort = cp5.addScrollableList("uiSelectedSerialPort")
    .addItems(Arrays.asList(Serial.list()))
    .setPosition(5, 50)
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
    .setPosition(160, 50)
    .setSize(50, 20)
    .setLabel("connect")
    .setSwitch(true)
    ;

  cp5.addFrameRate()
    .setInterval(10)
    .setPosition(5, height-15)
    .setSize(40, 20)
    .moveTo("global")
    ;


  cp5.addLabel("ORIENTATION")
    .setPosition(5, 25)
    .setFont(createFont("", 15))
    .moveTo("raw");

  uiOrientationX = cp5.addSlider("X")
    .setPosition(5, 47)
    .setSize(150, 12)
    .setRange(0, 360)
    .setLock(true)
    .moveTo("raw");
  uiOrientationY = cp5.addSlider("Y")
    .setPosition(5, 62)
    .setSize(150, 12)
    .setRange(-180, 180)
    .setLock(true)
    .moveTo("raw");
  uiOrientationZ = cp5.addSlider("Z")
    .setPosition(5, 77)
    .setSize(150, 12)
    .setRange(-180, 180)
    .setLock(true)
    .moveTo("raw");
}

void uiUpdate() {
  uiOrientationX.setValue(gloveOrientationX);
  uiOrientationY.setValue(gloveOrientationY);
  uiOrientationZ.setValue(gloveOrientationZ);
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(uiConnectOSC)) {
    if (uiConnectOSC.isOn()) {
      uiHostnameOSC.setLock(true);
      uiPortOSC.setLock(true);
      oscConnect(uiHostnameOSC.getText(), (int)uiPortOSC.getValue());
    } else {
      uiHostnameOSC.setLock(false);
      uiPortOSC.setLock(false);
      oscDisconnect();
    }
  }

  if (theEvent.isFrom(uiConnectSerialPort)) {
    if (uiConnectSerialPort.isOn()) {
      uiSelectedSerialPort.setLock(true);
      uiSelectedSerialPort.setOpen(false);
      gloveConnect(uiSelectedSerialPort.getLabel());
    } else {
      uiSelectedSerialPort.setLock(false);
      gloveDisconnect();
    }
  }

  if (theEvent.isFrom(uiSelectedSerialPort)) {
    println("selected serial port " + theEvent);
    println("    " + uiSelectedSerialPort.getValue());
  }
}
ControlP5 cp5;

Textfield uiHostnameOSC;
Numberbox uiPortOSC;
Button uiConnectOSC;
ScrollableList uiSelectedSerialPort;
Button uiConnectSerialPort;

Slider uiEulerX;
Slider uiEulerY;
Slider uiEulerZ;

Slider uiLinearX;
Slider uiLinearY;
Slider uiLinearZ;

Slider uiGravityX;
Slider uiGravityY;
Slider uiGravityZ;

Slider uiMiddleFinger;
Slider uiRingFinger;
Slider uiLittleFinger;

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

  uiEulerX = cp5.addSlider("X (euler)")
    .setPosition(5, 25)
    .setSize(150, 12)
    .setRange(0, 360)
    .setLock(true)
    .moveTo("raw");
  uiEulerY = cp5.addSlider("Y (euler)")
    .setPosition(5, 40)
    .setSize(150, 12)
    .setRange(-180, 180)
    .setLock(true)
    .moveTo("raw");
  uiEulerZ = cp5.addSlider("Z (euler)")
    .setPosition(5, 55)
    .setSize(150, 12)
    .setRange(-180, 180)
    .setLock(true)
    .moveTo("raw");

  uiLinearX = cp5.addSlider("X (linear)")
    .setPosition(5, 75)
    .setSize(150, 12)
    .setRange(-10, 10)
    .setLock(true)
    .moveTo("raw");
  uiLinearY = cp5.addSlider("Y (linear)")
    .setPosition(5, 90)
    .setSize(150, 12)
    .setRange(-10, 10)
    .setLock(true)
    .moveTo("raw");
  uiLinearZ = cp5.addSlider("Z (linear)")
    .setPosition(5, 105)
    .setSize(150, 12)
    .setRange(-10, 10)
    .setLock(true)
    .moveTo("raw");

  uiGravityX = cp5.addSlider("X (gravity)")
    .setPosition(5, 125)
    .setSize(150, 12)
    .setRange(-10, 10)
    .setLock(true)
    .moveTo("raw");
  uiGravityY = cp5.addSlider("Y (gravity)")
    .setPosition(5, 140)
    .setSize(150, 12)
    .setRange(-10, 10)
    .setLock(true)
    .moveTo("raw");
  uiGravityZ = cp5.addSlider("Z (gravity)")
    .setPosition(5, 155)
    .setSize(150, 12)
    .setRange(-10, 10)
    .setLock(true)
    .moveTo("raw");

  uiMiddleFinger = cp5.addSlider("middle finger")
    .setPosition(5, 185)
    .setSize(150, 12)
    .setRange(0, 1023)
    .setLock(true)
    .moveTo("raw");
  uiRingFinger = cp5.addSlider("ring finger")
    .setPosition(5, 200)
    .setSize(150, 12)
    .setRange(0, 1023)
    .setLock(true)
    .moveTo("raw");
  uiLittleFinger = cp5.addSlider("little finger")
    .setPosition(5, 215)
    .setSize(150, 12)
    .setRange(0, 1023)
    .setLock(true)
    .moveTo("raw");}

void uiUpdate() {
  uiEulerX.setValue(gloveEulerX);
  uiEulerY.setValue(gloveEulerY);
  uiEulerZ.setValue(gloveEulerZ);
  uiLinearX.setValue(gloveLinearX);
  uiLinearY.setValue(gloveLinearY);
  uiLinearZ.setValue(gloveLinearZ);
  uiGravityX.setValue(gloveGravityX);
  uiGravityY.setValue(gloveGravityY);
  uiGravityZ.setValue(gloveGravityZ);
  uiMiddleFinger.setValue(gloveMiddleFinger);
  uiRingFinger.setValue(gloveRingFinger);
  uiLittleFinger.setValue(gloveLittleFinger);
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
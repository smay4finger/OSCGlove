ControlP5 cp5;

public void createUI() {

  cp5 = new ControlP5(this);

  cp5.addScrollableList("uiSelectedSerialPort")
    .setPosition(5, 5)
    .setSize(150, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .setLabel("")
    .addItems(Arrays.asList(Serial.list()));
  cp5.addButton("uiConnectSerialPort")
    .setPosition(160, 5)
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
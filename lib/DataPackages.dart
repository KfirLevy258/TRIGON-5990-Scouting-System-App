class AutoUpperTargetData {
  int innerPort;
  int outerPort;
  int powerCellsShoot;

  AutoUpperTargetData(int innerPort, int upperPort, int powerCellsShoot){
    this.innerPort = innerPort;
    this.outerPort = upperPort;
    this.powerCellsShoot = powerCellsShoot;
  }
}

class TeleopUpperTargetData {
  int innerPort;
  int outerPort;
  int powerCellsShoot;
  Map<String, double> shotFrom;

  TeleopUpperTargetData(int innerPort, int upperPort, int powerCellsShoot, double xValue, double yValue){
    this.innerPort = innerPort;
    this.outerPort = upperPort;
    this.powerCellsShoot = powerCellsShoot;
    this.shotFrom = {'x': xValue, 'y': yValue};
  }
}

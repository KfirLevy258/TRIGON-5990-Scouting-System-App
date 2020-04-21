

class PitData {
  String dtMotorType;
  String wheelDiameter;
  String powerCellAmount;
  String canScore;
  String heightOfTheClimb;

  bool canStartFromAnyPosition;
  bool canRotateTheRoulette;
  bool canStopTheRoulette;
  bool canClimb;

  String robotWeightData;
  String robotWidthData;
  String robotLengthData;
  String dtMotorsData;
  String conversionRatio;
  String robotMinClimb ;
  String robotMaxClimb;
  
  PitData() {
    this.dtMotorType = 'Not selected';
    this.wheelDiameter = 'Not selected';
    this.powerCellAmount = 'Not selected';
    this.canScore = 'Not selected';
    this.heightOfTheClimb= 'Not selected';

    this.canStartFromAnyPosition = false;
    this.canRotateTheRoulette = false;
    this.canStopTheRoulette = false;
    this.canClimb = false;

    this.robotWeightData = "kilograms";
    this.robotWidthData = "Centimeters";
    this.robotLengthData = "Centimeters";
    this.dtMotorsData = "Amount";
    this.conversionRatio = "Numerator";
    this.robotMinClimb = "Centimeters";
    this.robotMaxClimb = "Centimeters";
  }

  copy(PitData other) {
    this.dtMotorType = other.dtMotorType;
    this.wheelDiameter = other.wheelDiameter;
    this.powerCellAmount = other.powerCellAmount;
    this.canScore = other.canScore;
    this.heightOfTheClimb= other.heightOfTheClimb;

    this.canStartFromAnyPosition = other.canStartFromAnyPosition;
    this.canRotateTheRoulette = other.canRotateTheRoulette;
    this.canStopTheRoulette = other.canStopTheRoulette;
    this.canClimb = other.canClimb;

    this.robotWeightData = other.robotWeightData;
    this.robotWidthData = other.robotWidthData;
    this.robotLengthData = other.robotLengthData;
    this.dtMotorsData = other.dtMotorsData;
    this.conversionRatio = other.conversionRatio;
    this.robotMinClimb = other.robotMinClimb;
    this.robotMaxClimb = other.robotMaxClimb;
  }

}
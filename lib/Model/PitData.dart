

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
    this.dtMotorType = 'לא נבחר';
    this.wheelDiameter = 'לא נבחר';
    this.powerCellAmount = 'לא נבחר';
    this.canScore = 'לא נבחר';
    this.heightOfTheClimb= 'לא נבחר';

    this.canStartFromAnyPosition = false;
    this.canRotateTheRoulette = false;
    this.canStopTheRoulette = false;
    this.canClimb = false;

    this.robotWeightData = "קילוגרמים";
    this.robotWidthData = "סנטימטרים";
    this.robotLengthData = "סנטימטרים";
    this.dtMotorsData = "כמות";
    this.conversionRatio = "מונה";
    this.robotMinClimb = "סנטימטרים";
    this.robotMaxClimb = "סנטימטרים";
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
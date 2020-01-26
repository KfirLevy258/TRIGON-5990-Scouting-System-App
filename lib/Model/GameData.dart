
class GameData {
  String qualNumber;
  String tournament;
  String userId;
  String teamNumber;
  String teamName;
  String winningAlliance;

  // Pre game data:
  String startingPosition;

  // Auto data:
  int autoInnerScore;
  int autoOuterScore;
  int autoBottomScore;
  int autoPowerCellsOnRobotEndOfAuto;
  bool climb1BallCollected;
  bool climb2BallCollected;
  bool climb3BallCollected;
  bool climb4BallCollected;
  bool climb5BallCollected;
  bool trench1BallCollected;
  bool trench2BallCollected;
  bool trench3BallCollected;
  bool trench4BallCollected;
  bool trench5BallCollected;

  // Teleop data:
  int teleopInnerScore;
  int teleopOuterScore;
  int teleopBottomScore;
  bool trenchRotate;
  bool trenchStop;
  List<String> shotFrom;

// End game data:
  String climbStatus;
  int climbLocation;
  String whyDidntClimb;

  GameData() {
    this.qualNumber = null;
    this.tournament = null;
    this.userId = null;
    this.teamNumber = null;
    this.teamName = null;
    this.winningAlliance = 'לא נבחר';

    this.startingPosition='לא נבחר';

    this.autoInnerScore = 0;
    this.autoOuterScore = 0;
    this.autoBottomScore = 0;
    this.autoPowerCellsOnRobotEndOfAuto = 0;
    this.climb1BallCollected = false;
    this.climb2BallCollected = false;
    this.climb3BallCollected = false;
    this.climb4BallCollected = false;
    this.climb4BallCollected = false;
    this.trench1BallCollected = false;
    this.trench2BallCollected = false;
    this.trench3BallCollected = false;
    this.trench4BallCollected = false;
    this.trench5BallCollected = false;

    this.teleopInnerScore = 0;
    this.teleopOuterScore = 0;
    this.teleopBottomScore = 0;
    this.trenchRotate = false;
    this.trenchStop = false;

    this.climbStatus = null;
    this.climbLocation = null;
    this.whyDidntClimb = null;
  }

  copy(GameData other) {
    this.qualNumber = other.qualNumber;
    this.tournament = other.tournament;
    this.userId = other.userId;
    this.teamName = other.teamName;
    this.teamNumber= other.teamNumber;
    this.winningAlliance = other.winningAlliance;

    this.startingPosition = other.startingPosition;

    this.autoInnerScore = other.autoInnerScore;
    this.autoOuterScore = other.autoOuterScore;
    this.autoBottomScore = other.autoBottomScore;
    this.autoPowerCellsOnRobotEndOfAuto = other.autoPowerCellsOnRobotEndOfAuto;
    this.climb1BallCollected = other.climb1BallCollected;
    this.climb2BallCollected = other.climb2BallCollected;
    this.climb3BallCollected = other.climb3BallCollected;
    this.climb4BallCollected = other.climb4BallCollected;
    this.climb5BallCollected = other.climb5BallCollected;
    this.trench1BallCollected = other.trench1BallCollected;
    this.trench2BallCollected = other.trench2BallCollected;
    this.trench3BallCollected = other.trench3BallCollected;
    this.trench4BallCollected = other.trench4BallCollected;
    this.trench5BallCollected = other.trench5BallCollected;

    this.teleopInnerScore = other.teleopInnerScore;
    this.teleopOuterScore = other.teleopOuterScore;
    this.teleopBottomScore = other.teleopBottomScore;
    this.trenchRotate = other.trenchRotate;
    this.trenchStop = other.trenchStop;
    this.shotFrom = other.shotFrom;

    this.climbStatus = other.climbStatus;
    this.climbLocation = other.climbLocation;
    this.whyDidntClimb = other.whyDidntClimb;

  }

}
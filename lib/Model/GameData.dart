
class GameData {
  String qualNumber;
  String tournament;
  String userId;
  String teamNumber;
  String teamName;

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
  String climbLocation;
  String whyDidntClimb;

}
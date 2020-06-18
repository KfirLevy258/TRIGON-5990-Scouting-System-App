import 'package:simple_rsa/simple_rsa.dart';
import 'Model/GameData.dart';

final PUBLIC_KEY =
    "MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgHky3XQcYK0u2NwfMTvNUeWutSyD" +
      "+aHkeiQdrfDtY21sQvSLOzJVJqebLL4X0cad3d5nlIgyRI1lnYL+wQsuqKZ9Gda9" +
      "K+ciuYLYbyCidxzb0uiZL4PEckuZkr2doFnbJUlrNUnCkA1PxgwsV6IJqX17UnfY" +
      "lZe+4Ss78D58jo1PAgMBAAE=";




Future<String> RSAEncrypt(String toEncrypt) async {
  try {
    final tmp = await encryptString(
        toEncrypt, PUBLIC_KEY);
    return tmp;
  } catch (e) {
    print(e);
  }
}

Future objectEncrypt(GameData dataToSave) async{
  var futures = List<Future>();
  futures.add(RSAEncrypt(dataToSave.allianceColor));
  futures.add(RSAEncrypt(dataToSave.winningAlliance));
  futures.add(RSAEncrypt(dataToSave.startingPosition));
  futures.add(RSAEncrypt(dataToSave.autoInnerScore.toString()));
  futures.add(RSAEncrypt(dataToSave.autoOuterScore.toString()));
  futures.add(RSAEncrypt(dataToSave.autoUpperShoot.toString()));
  futures.add(RSAEncrypt(dataToSave.autoBottomScore.toString()));
  futures.add(RSAEncrypt(dataToSave.autoBottomShoot.toString()));
  futures.add(RSAEncrypt(dataToSave.autoPowerCellsOnRobotEndOfAuto.toString()));
  futures.add(RSAEncrypt(dataToSave.climb1BallCollected.toString()));
  futures.add(RSAEncrypt(dataToSave.climb2BallCollected.toString()));
  futures.add(RSAEncrypt(dataToSave.climb3BallCollected.toString()));
  futures.add(RSAEncrypt(dataToSave.climb4BallCollected.toString()));
  futures.add(RSAEncrypt(dataToSave.climb5BallCollected.toString()));
  futures.add(RSAEncrypt(dataToSave.trench1BallCollected.toString()));
  futures.add(RSAEncrypt(dataToSave.trench2BallCollected.toString()));
  futures.add(RSAEncrypt(dataToSave.trench3BallCollected.toString()));
  futures.add(RSAEncrypt(dataToSave.trench4BallCollected.toString()));
  futures.add(RSAEncrypt(dataToSave.trench5BallCollected.toString()));
  futures.add(RSAEncrypt(dataToSave.trenchSteal1BallCollected.toString()));
  futures.add(RSAEncrypt(dataToSave.trenchSteal2BallCollected.toString()));
  futures.add(RSAEncrypt(dataToSave.autoLine.toString()));
  futures.add(RSAEncrypt(dataToSave.teleopInnerScore.toString())); //22
  futures.add(RSAEncrypt(dataToSave.teleopOuterScore.toString())); //23
  futures.add(RSAEncrypt(dataToSave.teleopUpperShoot.toString()));//24
  futures.add(RSAEncrypt(dataToSave.teleopBottomScore.toString()));//25
  futures.add(RSAEncrypt(dataToSave.teleopBottomShoot.toString()));//26
  futures.add(RSAEncrypt(dataToSave.fouls.toString()));//27
  futures.add(RSAEncrypt(dataToSave.preventedBalls.toString()));//28
  futures.add(RSAEncrypt(dataToSave.trenchRotate.toString()));//29
  futures.add(RSAEncrypt(dataToSave.trenchStop.toString()));//30
  futures.add(RSAEncrypt(dataToSave.didDefense.toString()));//31
  futures.add(RSAEncrypt(dataToSave.ballsRP.toString()));//32
  futures.add(RSAEncrypt(dataToSave.climbStatus.toString()));//33
  futures.add(RSAEncrypt(dataToSave.climbLocation.toString()));//34
  futures.add(RSAEncrypt(dataToSave.whyDidntClimb.toString()));//35
  futures.add(RSAEncrypt(dataToSave.climbRP.toString()));//36

  var teleopUpperDataTemp = List<Future>();
  dataToSave.teleopUpperData.forEach((element) {
    var temp = List<Future>();
    temp.add(RSAEncrypt(element.innerPort.toString()));
    temp.add(RSAEncrypt(element.outerPort.toString()));
    temp.add(RSAEncrypt(element.powerCellsShoot.toString()));
    temp.add(RSAEncrypt(element.shotFrom['x'].toString()));
    temp.add(RSAEncrypt(element.shotFrom['y'].toString()));
    teleopUpperDataTemp.add(Future.wait(temp));
  });
  futures.add(Future.wait(teleopUpperDataTemp));

  var autoUpperDatTemp = List<Future>();
  dataToSave.autoUpperData.forEach((element) {
    var temp = List<Future>();
    temp.add(RSAEncrypt(element.innerPort.toString()));
    temp.add(RSAEncrypt(element.outerPort.toString()));
    temp.add(RSAEncrypt(element.powerCellsShoot.toString()));
    autoUpperDatTemp.add(Future.wait(temp));
  });
  futures.add(Future.wait(autoUpperDatTemp));

  var res =  await Future.wait(futures);
  return res;
}



import 'package:flutter/material.dart';
import 'package:pit_scout/RSAEncrypt.dart';
import 'authentication.dart';
import 'root.dart';
import 'package:provider/provider.dart';
import 'package:pit_scout/Model/PitDataModel.dart';
import 'package:pit_scout/Model/GameDataModel.dart';
import 'package:dcdg/dcdg.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final title = 'Kfir Levy';

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PitDataModel>(create: (_) => PitDataModel()),
        ChangeNotifierProvider<GameDataModel>(create: (_) => GameDataModel(),)
      ],
      child: MaterialApp(
        title: title,
//        theme: ThemeData.dark(),
        home: RootPage(auth: Auth()),
      ),
    );
  }
}


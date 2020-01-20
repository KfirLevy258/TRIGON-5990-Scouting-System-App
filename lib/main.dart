import 'package:flutter/material.dart';
import 'package:pit_scout/TournamentSelect.dart';
import 'authentication.dart';
import 'root.dart';
import 'package:provider/provider.dart';
import 'package:pit_scout/Model/PitDataModel.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final title = 'Kfir Levy';

    return ChangeNotifierProvider(
      create: (context) => PitDataModel(),

      child: MaterialApp(
        title: title,
        home:  RootPage(auth: Auth()),
//      home: TournamentSelectPage(),
      ),
    );
  }
}


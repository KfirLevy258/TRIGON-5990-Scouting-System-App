import 'package:flutter/material.dart';
import 'package:pit_scout/TournamentSelect.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final title = 'Kfir Levy';

    return MaterialApp(
      title: title,
      home: TournamentSelectPage(),
    );
  }
}


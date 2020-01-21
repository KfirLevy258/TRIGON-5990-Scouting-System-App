import 'package:flutter/material.dart';
import 'authentication.dart';
import 'root.dart';
import 'package:provider/provider.dart';
import 'package:pit_scout/Model/PitDataModel.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final title = 'Kfir Levy';

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PitDataModel>(create: (_) => PitDataModel()),
      ],
      child: MaterialApp(
        title: title,
        home:  RootPage(auth: Auth()),
      ),
    );
  }
}


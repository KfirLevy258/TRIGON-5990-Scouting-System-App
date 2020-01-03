import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'PitScouting/PitTeamSelect.dart';
import 'Scouting/ScoutingMatchSelect.dart';
import 'SuperScouting/SuperMatchSelect.dart';

class MainMenu extends StatefulWidget {
  final String tournament;

  MainMenu({Key key, @required this.tournament}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TRIGON 5990 Scouting app',
          textAlign: TextAlign.center,
        ),
      ),
      body: bodyWidgetSelect(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped, // new
        currentIndex: currentIndex, // new
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            title: Text('Pit'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            title: Text('Game'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Super')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              title: Text('My Schedule')
          )
        ],
      ),
    );
  }

  Widget bodyWidgetSelect(index) {
    switch (index) {
      case 0: return TeamSelectPage(tournament: widget.tournament);
      case 1: return MatchSelect(tournament: widget.tournament);
      case 2: return SuperMatchSelect(tournament: widget.tournament);
      default: return Container();
    }
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}

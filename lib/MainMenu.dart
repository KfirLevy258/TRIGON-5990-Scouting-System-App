import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'PitScouting/PitTeamSelect.dart';
import 'Scouting/ScoutingMatchSelect.dart';
import 'SuperScouting/SuperMatchSelect.dart';

class MainMenu extends StatefulWidget {
  final int currentIndex;
  final String tournament;

  MainMenu({Key key, @required this.tournament, this.currentIndex}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState(tournament, currentIndex);
}

class _MainMenuState extends State<MainMenu> {
  String tournament;
  int currentIndex;
  List<Widget> _children;

  _MainMenuState(String tournament, int currentIndex){
    this.tournament = tournament;
    if (currentIndex==null){
      this.currentIndex = 0;
    } else {
      this.currentIndex = currentIndex;
    }
    _children = [
      TeamSelectPage(tournament: tournament),
      MatchSelect(tournament: tournament),
      SuperMatchSelect(tournament: tournament),
      Container(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TRIGON 5990 Scouting app',
          textAlign: TextAlign.center,
        ),
      ),
      body: _children[currentIndex], // new
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

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}

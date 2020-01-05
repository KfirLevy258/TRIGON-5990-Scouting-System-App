import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Image.dart';
import 'PitScouting/PitTeamSelect.dart';
import 'Scouting/ScoutingMatchSelect.dart';
import 'SuperScouting/SuperMatchSelect.dart';
import 'package:pit_scout/test.dart';
import 'package:pit_scout/forbidden.dart';

class MainMenu extends StatefulWidget {
  final String tournament;
  final String userId;

  MainMenu({Key key, @required this.tournament, this.userId}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int currentIndex = 0;
  bool pitScoutEnable = false;
  bool gameScoutEnabled = false;
  bool superScoutEnabled = false;

  @override
  void initState() {
    Firestore.instance.collection('users').document(widget.userId).get()
    .then((res) {
      setState(() {
        pitScoutEnable = res.data['pitScouting'];
        superScoutEnabled = res.data['superScouting'];
        gameScoutEnabled = res.data['gameScouting'];
      });
    });
    super.initState();
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
      case 0: return pitScoutEnable ? TeamSelectPage(tournament: widget.tournament) : ForbiddenPage();
      case 1: return gameScoutEnabled ? MatchSelect(tournament: widget.tournament) : ForbiddenPage();
      case 2: return superScoutEnabled ? SuperMatchSelect(tournament: widget.tournament) : ForbiddenPage();
      case 3: return ImageStuff(tournament: widget.tournament, teamNumber: '1574',);
      default: return Container();
    }
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}

import 'package:circle_wave_progress/circle_wave_progress.dart';
import 'package:flutter/material.dart';
import 'package:mafia_god/components/timer.dart';

class GamePage extends StatefulWidget {
  final List players;

  GamePage(this.players);

  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  bool isNight = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isNight ? Colors.white12 : Colors.blue,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.all(8),
                crossAxisCount: 3,
                children: widget.players
                    .map((player) => Opacity(
                          opacity: player['status'] == 'dead' ? .5 : 1,
                          child: InkWell(
                            splashColor: Colors.red,
                            onLongPress: () {
                              setState(() {
                                player['status'] = 'dead';
                              });
                            },
                            onTap: () {
                              if (player['status'] == 'dead') return;
                              setState(() {
                                player['status'] = player['status'] == 'alive'
                                    ? 'marked'
                                    : 'alive';
                              });
                            },
                            child: Card(
                              color: player['status'] == 'marked'
                                  ? Colors.brown
                                  : Colors.white10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(player['name']),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    player['role'],
                                    style: TextStyle(
                                      color: Colors.white30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Timer(),
          ],
        ),
      ),
    );
  }
}

import 'package:mafia_god/components/timer.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: isNight ? Colors.white12 : Colors.blueGrey[200],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  GridView.count(
                    padding: EdgeInsets.fromLTRB(8,8,8,350),
                    crossAxisCount: 3,
                    children: widget.players
                        .map((player) => Opacity(
                              opacity: player['status'] == 'dead' ? .3 : 1,
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
                                    player['status'] =
                                        player['status'] == 'alive'
                                            ? 'marked'
                                            : 'alive';
                                  });
                                },
                                child: Card(
                                  color: player['status'] == 'marked'
                                      ? Colors.grey[700]
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
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Timer(),
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  isNight = !isNight;
                });
              },
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              child: Text(
                isNight ? 'روز میشه' : 'شب میشه',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              shape: StadiumBorder(),
            ),
          ],
        ),
      ),
    );
  }
}

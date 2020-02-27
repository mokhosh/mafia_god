import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:mafia_god/components/timer.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  final List players;
  final assetsAudioPlayer = AssetsAudioPlayer();

  GamePage(this.players);

  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  final Timer timer = Timer();
  bool isNight = false;
  List<String> assetAudioPaths = [
    "assets/audios/theme.mp3",
    "assets/audios/love-theme.mp3",
    "assets/audios/hiphop.mp3",
  ];

  @override
  void initState() {
    widget.assetsAudioPlayer.openPlaylist(Playlist(
      startIndex: -1,
      assetAudioPaths: assetAudioPaths,
    ));
    widget.assetsAudioPlayer.stop();
    super.initState();
  }

  @override
  void dispose() {
    widget.assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isNight ? Colors.grey[900] : Colors.blueGrey[200],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isNight = !isNight;
          });

          if (isNight) {
            timer.resetTimer();
            widget.assetsAudioPlayer.playlistPlayAtIndex(Random().nextInt(assetAudioPaths.length));
          } else {
            widget.assetsAudioPlayer.stop();
          }
        },
        child: Icon(isNight ? Icons.wb_sunny : Icons.brightness_3),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        mini: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GridView.count(
              padding: EdgeInsets.fromLTRB(8, 8, 8, isNight ? 8 : 220),
              crossAxisCount: 3,
              children: widget.players
                  .map((player) => Opacity(
                        opacity: player['status'] == 'dead' ? .3 : 1,
                        child: InkWell(
                          splashColor: Colors.red,
                          onLongPress: () {
                            if (player['status'] == 'dead') return;
                            setState(() {
                              player['status'] = 'dead';
                              widget.players.remove(player);
                              widget.players.add(player);
                            });
                          },
                          onTap: () {
                            if (player['status'] == 'dead') return;
                            setState(() {
                              player['status'] = player['status'] == 'alive'
                                  ? 'marked'
                                  : 'alive';
                            });
                            if (!isNight) {
                              if (player['status'] == 'marked') {
                                timer.startTimer();
                              } else if (player['status'] == 'alive') {
                                timer.resetTimer();
                              }
                            }
                          },
                          child: Card(
                            color: player['status'] == 'marked'
                                ? Colors.grey[700]
                                : Colors.white10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  player['name'],
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  player['role'],
                                  style: TextStyle(
                                    color: Colors.white30,
                                    fontSize: 18,
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
              child: Offstage(
                offstage: isNight,
                child: timer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

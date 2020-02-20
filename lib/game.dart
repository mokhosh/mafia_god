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
  bool isNight = false;

  @override
  void initState() {
    widget.assetsAudioPlayer.openPlaylist(Playlist(
      startIndex: -1,
      assetAudioPaths: [
        "assets/audios/theme.mp3",
        "assets/audios/love-theme.mp3",
        "assets/audios/mandolina.mp3",
        "assets/audios/hiphop.mp3",
      ],
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
            widget.assetsAudioPlayer.playlistPlayAtIndex(Random().nextInt(4));
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
            if (! isNight) Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Timer(),
            ),
          ],
        ),
      ),
    );
  }
}

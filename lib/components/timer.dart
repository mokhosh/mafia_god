import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  final beepPlayer = AssetsAudioPlayer();

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  final GlobalKey<AnimatedCircularChartState> chartKey =
      GlobalKey<AnimatedCircularChartState>();
  final StopWatchTimer stopWatchTimer = StopWatchTimer();
  var second = 0;

  @override
  void initState() {
    widget.beepPlayer.open('assets/audios/beep.mp3');
    widget.beepPlayer.stop();

    stopWatchTimer.secondTime.listen(
      (value) => setState(() {
        second = value;

        if (chartKey.currentState != null) {
          chartKey.currentState.updateData([
            CircularStackEntry([
              CircularSegmentEntry(value.toDouble(), Colors.red[900]),
              CircularSegmentEntry(30 - value.toDouble(), Colors.white60),
            ]),
          ]);
        }
      }),
    );
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (second > 30) {
      widget.beepPlayer.play();
      stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    }
    return Card(
      color: Colors.white10,
      clipBehavior: Clip.antiAlias,
      shape: CircleBorder(),
      child: InkWell(
        customBorder: StadiumBorder(),
        onTap: () {
          if (stopWatchTimer.isRunning()) {
            stopWatchTimer.onExecute.add(StopWatchExecute.reset);
          } else {
            stopWatchTimer.onExecute.add(StopWatchExecute.start);
          }
        },
        child: AnimatedCircularChart(
          key: chartKey,
          size: Size(200, 200),
          chartType: CircularChartType.Radial,
          edgeStyle: SegmentEdgeStyle.round,
          holeLabel: second.toString(),
          labelStyle: new TextStyle(
            color: second > 25 ? Colors.red[900] : Colors.white60,
            fontWeight: FontWeight.bold,
            fontFamily: 'Vazir',
            fontSize: 85,
            height: second == 0 ? null : 2,
          ),
          initialChartData: [
            CircularStackEntry([
              CircularSegmentEntry(0.0, Colors.red[900]),
              CircularSegmentEntry(30.0, Colors.white60),
            ]),
          ],
        ),
      ),
    );
  }
}

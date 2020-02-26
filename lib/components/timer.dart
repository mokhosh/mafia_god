import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  final beepPlayer = AssetsAudioPlayer();
  final StopWatchTimer stopWatchTimer = StopWatchTimer();
  final GlobalKey<AnimatedCircularChartState> chartKey =
      GlobalKey<AnimatedCircularChartState>();

  void startTimer() {
    this.stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    this.stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  void resetTimer() {
    this.stopWatchTimer.onExecute.add(StopWatchExecute.reset);
  }

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  var second = 0;

  @override
  void initState() {
    widget.beepPlayer.open('assets/audios/beep.mp3');
    widget.beepPlayer.stop();

    widget.stopWatchTimer.secondTime.listen(
      (value) => setState(() {
        second = value;

        if (widget.chartKey.currentState != null) {
          widget.chartKey.currentState.updateData([
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
  Widget build(BuildContext context) {
    if (second > 30) {
      widget.beepPlayer.play();
      widget.stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    }
    return Card(
      color: Colors.white10,
      clipBehavior: Clip.antiAlias,
      shape: CircleBorder(),
      child: InkWell(
        customBorder: StadiumBorder(),
        onTap: () {
          if (widget.stopWatchTimer.isRunning()) {
            widget.stopWatchTimer.onExecute.add(StopWatchExecute.stop);
          } else {
            widget.stopWatchTimer.onExecute.add(StopWatchExecute.start);
          }
        },
        onLongPress: () {
          widget.stopWatchTimer.onExecute.add(StopWatchExecute.reset);
        },
        child: AnimatedCircularChart(
          key: widget.chartKey,
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

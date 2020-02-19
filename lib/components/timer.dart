import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
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
    stopWatchTimer.secondTime.listen(
      (value) => setState(() {
        second = value;

        if (chartKey.currentState != null) {
          chartKey.currentState.updateData([
            CircularStackEntry([
              CircularSegmentEntry(value.toDouble(), Colors.red),
              CircularSegmentEntry(30 - value.toDouble(), Colors.white10),
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
      stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    }
    return InkWell(
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
        size: Size(300, 300),
        chartType: CircularChartType.Radial,
        edgeStyle: SegmentEdgeStyle.round,
        holeLabel: second.toString(),
        labelStyle: new TextStyle(
          color: second > 25 ? Colors.red : Colors.white10,
          fontWeight: FontWeight.bold,
          fontSize: 72.0,
        ),
        initialChartData: [
          CircularStackEntry([
            CircularSegmentEntry(0.0, Colors.red),
            CircularSegmentEntry(30.0, Colors.white10),
          ]),
        ],
      ),
    );
  }
}

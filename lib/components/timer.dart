import 'package:circle_wave_progress/circle_wave_progress.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  final StopWatchTimer stopWatchTimer = StopWatchTimer();

  @override
  void dispose() async {
    super.dispose();
    await stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: stopWatchTimer.secondTime,
      initialData: 0,
      builder: (context, snap) {
        final value = snap.data;
        if (value > 30) {
          stopWatchTimer.onExecute.add(StopWatchExecute.reset);
        }
        return InkWell(
          onTap: () {
            if (stopWatchTimer.isRunning()) {
              stopWatchTimer.onExecute.add(StopWatchExecute.reset);
            } else {
              stopWatchTimer.onExecute.add(StopWatchExecute.start);
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleWaveProgress(
                backgroundColor: stopWatchTimer.secondTime.value == 0 ? Colors.red : Colors.white12,
                waveColor: Colors.white12,
                size: 200,
                progress: stopWatchTimer.secondTime.value.toDouble() * 3,
              ),
              Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

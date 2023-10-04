import 'dart:async';

import 'package:flutter/material.dart';

class second extends StatefulWidget {
  const second({Key? key}) : super(key: key);

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {

  late Stopwatch _stopwatch;
  late Timer _timer;
  late StreamController<int> _streamController;
  late Stream<int> _timerStream;
  int _elapsedMillisecondss = 0;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _streamController = StreamController<int>();
    _timerStream = _streamController.stream;
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void startTimer(){
    _stopwatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      _elapsedMillisecondss = _stopwatch.elapsedMilliseconds;
      _streamController.sink.add(_elapsedMillisecondss);
    });
  }

  void stopTimer(){
    _stopwatch.stop();
    _timer.cancel();
  }

  void resetTimer(){
    _stopwatch.reset();
    _elapsedMillisecondss = 0;
    _streamController.sink.add(_elapsedMillisecondss);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<int>(
          stream: _timerStream,
          builder: (context, snapshot) {
            final int milliseconds = snapshot.data ?? 0;
            final int seconds = (milliseconds / 1000).floor();
            final int minutes = (seconds / 60).floor();
            final int hours = (minutes / 60).floor();
            
            return Text("${hours.toString().padLeft(2,'0')}:${minutes.toString().padLeft(2,'0')}:${(seconds % 60).toString().padLeft(2,'0')}.${(milliseconds % 1000).toString().padLeft(3,'0')}",
            style: TextStyle(fontSize: 24),
            );
        },),
        SizedBox(height: 16,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: startTimer,
                child: Text("Start")
            ),
            SizedBox(width: 16.0,),
            ElevatedButton(
                onPressed: stopTimer,
                child: Text("Stop")
            ),
            SizedBox(width: 16.0,),
            ElevatedButton(
                onPressed: resetTimer,
                child: Text("Reset")
            )
          ],
        ),
      ],
    );
  }
}

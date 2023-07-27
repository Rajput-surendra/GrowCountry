import 'package:flutter/material.dart';
class Timer extends StatefulWidget {
  int? time;
   Timer({Key? key, this.time}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> with SingleTickerProviderStateMixin{

  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(minutes: 5));
    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return
      // MaterialApp(
      // // theme:
      // //ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      // debugShowCheckedModeBanner: false,
      // home:
      Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Countdown(
            animation: StepTween(
              begin: widget.time! ,
              end: 0,
            ).animate(_controller!),
          ),
        ),
      )
    // )
        ;
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key, key, required this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    return Text(
      "$timerText",
      style: TextStyle(
        fontSize: 110,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
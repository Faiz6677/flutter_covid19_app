import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
  AnimationController(vsync: this, duration: Duration(seconds: 3))
    ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () =>
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeScreen();
        })),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            AnimatedBuilder(
                animation: _controller,
                child: Image.asset(
                  'assets/images/covid19 virus.png',
                  height: 200,
                  width: 200,
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 1.0 * math.pi,
                    child: child,
                  );
                }),
            SizedBox(
              height: 100,
            ),
            Text(
              'Covid-19 \n Flutter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline3,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

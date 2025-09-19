import 'dart:async';
// import 'package:bb_ui/assets';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }
  startTimer(){
    var duration= const Duration(seconds: 2);
    return Timer(duration, route);
  }
  route(){
    Navigator.of(context).pushReplacementNamed('/login');
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: 200.0,
      ),
      decoration: BoxDecoration(color: Colors.white),
        child: Image.asset(
            'assets/splash_screen_2.png',
               fit: BoxFit.cover,
        ),
    );
  }
}

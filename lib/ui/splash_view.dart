import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/farm.jpg"),
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

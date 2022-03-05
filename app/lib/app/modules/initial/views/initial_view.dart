import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:splashscreen/splashscreen.dart';

import '../controllers/initial_controller.dart';

class InitialView extends GetView<InitialController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(
      child: Stack(
        children: [
          SplashScreen(
            seconds: 2,
            gradientBackground: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white,
                Colors.white,
              ]
            ),
            navigateAfterSeconds: controller.verifyAuth(),
            loaderColor: Colors.transparent,
          ),
          Container(
            margin: EdgeInsets.all(100),
            child: Center(
              child: Text(
                'Mikhuy',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          )
        ]
      )
    )
    );
  }
}

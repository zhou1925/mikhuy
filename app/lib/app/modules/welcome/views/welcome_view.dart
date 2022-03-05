import 'package:app/app/constants/constants.dart';
import 'package:app/app/global/widgets/rounded_button.dart';
import 'package:app/app/modules/initial/views/components/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
      child: Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Bienvenido a Mikhuy",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Lottie.asset(
                      'assets/json/delivery_animation.json',
                      width: size.height * 0.45,
                      height: size.height * 0.45,
                    ),
            // SvgPicture.asset(
            //   "assets/icons/welcome_cats_thqn.svg",
            //   height: size.height * 0.45,
            // ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "INGRESAR",
              textColor: Colors.white,
              color: Colors.red,
              press: () {
                Get.offAndToNamed('/login');
              },
            ),
            RoundedButton(
              text: "CREAR UNA CUENTA",
              color: kRedLigthColor,
              textColor: Colors.black,
              press: () {
                Get.offAndToNamed('/signup');
              },
            ),
          ],
        ),
      ),
      )
    )
    );
  }
}

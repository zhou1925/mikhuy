

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarCustom{

  static show(String title, String subtitle, Color color) {
    Get.snackbar(
      '$title',
      '$subtitle',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      icon: Icon(Icons.notification_important),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5 )
    );
  }

  static primary(String title, String subtitle) {
    show(title, subtitle, Color(0xffcce5ff));
  }
}
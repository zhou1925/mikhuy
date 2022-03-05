// import 'package:app/app/modules/home/bindings/home_binding.dart';
// import 'package:app/app/modules/home/bindings/home_binding.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'app/theme/appThemeData.dart';

void main() async {
  await GetStorage.init('mikhuy');

  HttpOverrides.global = new MyHttpOverrides();
  


  runApp(
    GetMaterialApp(
      title: 'Mikhuy',
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      initialRoute: Routes.INITIAL,
      getPages: AppPages.routes,
      // initialBinding: HomeBinding(), // optional for the moment
    )
  );
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


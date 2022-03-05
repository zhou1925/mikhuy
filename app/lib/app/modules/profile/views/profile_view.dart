import 'package:app/app/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {

  final box = GetStorage('mikhuy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: AppBar(
        title: Text('Actualizar Cuenta', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              
              child: SvgPicture.asset(
                'assets/icons/back_arrow.svg',
                width: 24,
                height: 24,
                color: Colors.black87
              )
            ),
          )
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [

                

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:60.0, vertical: 5),
                  child: Text(
                    "Actualiza tu Numero",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    )
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:60.0, vertical: 10),
                  child: TextFormField(
                    controller: controller.newPhoneCtrl,
                    decoration: InputDecoration(
                      labelText: 'Nuevo numero',
                      hintText: '${box.read('user_phone').toString()}',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:60.0, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.updatePhoneNumber();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kBlackButtonColor,
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    child: Text(
                      'Actualizar Numero',
                      style: TextStyle(color: Colors.white),
                    )
                  ),
                ),

                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:60.0, vertical: 5),
                  child: Text(
                    "Actualiza tu Contraseña",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    )
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:60.0, vertical: 10),
                  child: TextFormField(
                    controller: controller.oldPasswordCtrl,
                    decoration: InputDecoration(
                      labelText: 'Contraseña Actual',
                      hintText: 'Ingresa tu Contraseña actual',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:60.0, vertical: 10),
                  child: TextFormField(
                    controller: controller.newPasswordCtrl,
                    decoration: InputDecoration(
                      labelText: 'Nueva Contraseña',
                      hintText: 'Ingresa tu nueva Contraseña',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),

                Obx(
                  () =>
                  Visibility(
                    visible: !controller.isLoading.value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:60.0, vertical: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          controller.updatePassword();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kBlackButtonColor,
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        child: Text(
                          'Actualizar Contraseña',
                          style: TextStyle(color: Colors.white),
                        )
                      ),
                    ),
                  )
                ),

                Obx(
                  () =>
                  Visibility(
                    visible: controller.isLoading.value,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      width: Get.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: TextButton(
                          
                          onPressed: (){},
                          child: CircularProgressIndicator(),
                        )
                      ),
                    )
                  )
                )


              ],
            )
          )
        ),
      )
    );
  }
}


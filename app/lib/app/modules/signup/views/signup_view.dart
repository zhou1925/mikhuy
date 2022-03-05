import 'package:app/app/global/widgets/alert_dialogs.dart';
import 'package:app/app/global/widgets/already_have_an_account_check.dart';
import 'package:app/app/global/widgets/rounded_button.dart';
import 'package:app/app/global/widgets/rounded_input_field.dart';
import 'package:app/app/global/widgets/rounded_password_field.dart';
import 'package:app/app/modules/signup/views/components/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: Get.height * 0.03),
                Text('Crear Cuenta',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red)),
                SizedBox(height: Get.height * 0.03),
                RoundedInputField(
                  hintText: "Numero de celular",
                  controller: controller.phoneController,
                  onChanged: (value) {},
                ),
                // RoundedInputField(
                //   hintText: "nombre",
                //   controller: controller.usernameCtrl,
                //   onChanged: (value) {},
                // ),
                Obx(
                    () => RoundedPasswordField(
                      showPassword: controller.showPassword.value,
                      showPassBtn: () {
                        controller.showPassword.value = !controller.showPassword.value;
                      },
                      controller: controller.passwordCtrl,
                      onChanged: (value) {},
                    ),
                  ),

                SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    children: [
                      Text('Confirmar Contraseña'),
                    ],
                  ),
                ),
                SizedBox(height: 2),


                Obx(
                    () => RoundedPasswordField(
                      showPassword: controller.showPassword.value,
                      showPassBtn: () {
                        controller.showPassword.value = !controller.showPassword.value;
                      },
                      controller: controller.password2Ctrl,
                      onChanged: (value) {},
                    ),
                ),

                Obx(
                    () => Visibility(
                      visible: !controller.isloading.value,
                      child: RoundedButton(
                        text: "CREAR CUENTA",
                        press: () async {
                          // controller.register2();
                          controller.isloading.value = true;

                          if(controller.formKey.currentState.validate()) {
                            if(controller.passwordCtrl.text == controller.password2Ctrl.text) {
                              var response = await http.post(
                                'https://www.mikhuy.xyz/users/',
                                body: {
                                  "phone": controller.phoneController.text,
                                  "password": controller.passwordCtrl.text
                                },
                                headers: {}
                              );
                              if(response != null) {
                                  controller.isloading.value = false;
                                  show_account_success();
                              } else {
                                controller.isloading.value = false;
                                show_failure_dialog();
                              }
                            } else {
                              controller.isloading.value = false;
                              show_password_not_match_dialog();
                            }
                          }
                        },
                      ),
                    )
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.isloading.value,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
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
                  ),
                SizedBox(height: Get.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    controller.toLogin();
                  },
                ),
    
                SizedBox(height: Get.height * 0.05),
    
              ],
            ),
          ),
        ),
      )
      
      ),
    );
  }
}

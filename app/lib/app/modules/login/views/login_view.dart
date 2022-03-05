import 'package:app/app/global/widgets/alert_dialogs.dart';
import 'package:app/app/global/widgets/already_have_an_account_check.dart';
import 'package:app/app/global/widgets/rounded_button.dart';
import 'package:app/app/global/widgets/rounded_input_field.dart';
import 'package:app/app/global/widgets/rounded_password_field.dart';
import 'package:app/app/modules/login/views/components/background.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {

  final box = GetStorage('mikhuy');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(
      child: Background(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                SizedBox(height: Get.height * 0.03),
                Text('Ingresar',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red)),
                SizedBox(height: Get.height * 0.03),
                RoundedInputField(
                  hintText: "Número de celular",
                  controller: controller.usernameCtrl,
                  onChanged: (value) {},
                  icon: Icons.phone,
                ),
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
                Obx(
                  () => Visibility(
                    visible: !controller.isloading.value,
                    child: RoundedButton(
                      text: "INGRESAR",
                      press: () async {
                        // controller.login();
                        controller.isloading.value = true;
                        var response = await http.post(
                          'https://www.mikhuy.xyz/login/',
                          body: {
                            "username": controller.usernameCtrl.text,
                            "password": controller.passwordCtrl.text
                          },
                          headers: {
                            "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
                          }
                        );

                        if(response != null && response.statusCode < 300) {
                          var data = json.decode(response.body);
                          box.write('token', data['token']);
                          box.write('user', data['user']); // set user
                          box.write('user_id', data['user']['id']); // set user id
                          box.write('user_phone', data['user']['phone']); // set user phone
                          controller.isloading.value = false;
                          // print('${box.read('token')}');
                          Get.offAllNamed(Routes.HOME);
                        }
                        else {
                          controller.isloading.value = false;
                          show_failure_dialog();
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
                  press: () {
                    controller.toRegister();
                  },
                ),

                // InkWell(
                //   onTap: () async {
                //     var response = await http.get(
                //       'https://www.mikhuy.xyz/trucks/',
                //       headers: {
                //         "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
                //       }
                //     ); 
                //     if(response != null) {
                //       print(response.body);
                //     } else {
                //       print('error');
                //     }
                //   },
                //   child: Text(
                //     'get trucks http'
                //   ),
                // )
              ],
            ),
          ),
        ),
        )
      )
    );
  }
}

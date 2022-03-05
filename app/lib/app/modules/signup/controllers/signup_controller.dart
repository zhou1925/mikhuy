import 'package:app/app/data/provider/auth_provider.dart';
import 'package:app/app/global/widgets/alert_dialogs.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final AuthApiClient authApiClient = Get.find<AuthApiClient>();

  final formKey = GlobalKey<FormState>();

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController password2Ctrl = TextEditingController();


  RxBool showPassword = false.obs;
  RxBool isloading = false.obs;

  void toLogin() {
    Get.offAndToNamed(Routes.LOGIN);
  }

  register2() async {
    isloading.value = true;
    
    if(formKey.currentState.validate()) {
      if(passwordCtrl.text == password2Ctrl.text) {
        var response = await authApiClient.register(
          phoneController.text,
          passwordCtrl.text
        );

        if(response != null) {
          isloading.value = false;
          show_account_success();
        } else {
          isloading.value = false;
          show_failure_dialog();
        }


      } else {
        isloading.value = false;
        show_password_not_match_dialog();
      }
    }
  }
}

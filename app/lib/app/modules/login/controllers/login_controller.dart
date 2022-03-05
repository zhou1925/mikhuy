import 'package:app/app/data/provider/auth_provider.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final AuthApiClient authApiClient = Get.find<AuthApiClient>();

  final formKey = GlobalKey<FormState>();
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  final box = GetStorage('mikhuy');

  RxBool showPassword = false.obs;
  RxBool isloading = false.obs;

  void login() async {
    isloading.value = true;
    var response = await authApiClient.login(usernameCtrl.text, passwordCtrl.text);
    print(response);
    if(response != null) {
      // set token
      box.write('token', response['token']);
      box.write('user', response['user']); // set user
      box.write('user_id', response['user']['id']); // set user id
      box.write('user_phone', response['user']['phone']); // set user phone
      isloading.value = false;
      Get.offAllNamed(Routes.HOME);
    }
    isloading.value = false;
  }

  // void login() async {
  //   if(formKey.currentState.validate()) {
  //     isloading.value = true;
  //     auth = await repository.login(usernameCtrl.text, passwordCtrl.text);
  //     if(auth == null){
  //       print('something went wrong');
  //       isloading.value = true;
  //     }else {
  //       box.write('auth', auth);
  //       Get.offAllNamed(Routes.HOME);
  //     }
  //     isloading.value = false;
  //   }
  //   print('login');
  // }

  // void login2() async{
  //   if (formKey.currentState.validate()){
  //     isloading.value = true;
  //     await repository.login(usernameCtrl.text, passwordCtrl.text).then((auth){
  //       if(auth != null){
  //         box.write('auth', auth);
  //         refresh();
  //         Get.offAllNamed(Routes.HOME);
  //       }
  //       isloading.value = false;
  //     }).catchError((err){
  //       isloading.value = false;
  //     });
      
  //   }
  // }

  void toRegister() {
    Get.offAndToNamed(Routes.SIGNUP);
  }
}

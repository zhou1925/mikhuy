import 'dart:convert';
import 'package:app/app/constants/constants.dart';
import 'package:app/app/global/widgets/alert_dialogs.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;


final box = GetStorage('mikhuy');


updatePhoneApi(String newPhone) async {
    String token = box.read('token');
    var user_id = box.read('user_id');
    var apiEndpoint = baseIpUrl + "/users/${user_id}/";

    var response = await http.put(
      apiEndpoint,
      body :
      {
        "phone": newPhone,
      },
      headers: {
        "Authorization": 'Token ' + token,
      }
    );

    if (response != null) {
      return json.decode(response.body);
    } else {
      return null;
    }

  }

updatePasswordApi(String old_password, String new_password) async {
    String token = box.read('token');
    var user_id = box.read('user_id');
    var apiEndpoint = baseIpUrl + "/users/${user_id}/change_password/";

    var response = await http.put(
      apiEndpoint,
      body:
      {
        "old_password": old_password,
        "new_password": new_password
      },
      // contentType: 'application/json',
      headers: {
        "Authorization": 'Token ' + token,
      }
    );

    if (response != null) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

class ProfileController extends GetxController {
  // Loader
  RxBool isLoading = false.obs;

  // Form
  final formKey = GlobalKey<FormState>();
  TextEditingController newPhoneCtrl = TextEditingController();
  TextEditingController oldPasswordCtrl = TextEditingController();
  TextEditingController newPasswordCtrl = TextEditingController();


  updatePhoneNumber() async {
    if(formKey.currentState.validate()) {
      isLoading.value = true;

      var response = await updatePhoneApi(newPhoneCtrl.text);

      if(response != null) {
        show_success_phone_update_dialog();
      } else {
       show_failure_dialog();
      }

    }
    isLoading.value = false;
  }
  

  updatePassword() async {
    if(formKey.currentState.validate()) {
      isLoading.value = true;
      var response = await updatePasswordApi(oldPasswordCtrl.text, newPasswordCtrl.text);
      if(response != null) {
        show_password_update_success_dialog();
      } else {
        show_password_update_fail_dialog();
      }

    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
  }

}

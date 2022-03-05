import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/app/constants/constants.dart';
import 'package:app/app/global/widgets/alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



final box = GetStorage('mikhuy');

getCart() async {
  var apiEndpoint = baseIpUrl + "/cart/";
  String token = box.read('token');
  var response = await http.get(
    Uri.parse(apiEndpoint),
    headers: {
      "Authorization": 'Token ' + token,
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    }
  );
  // print('get cart method');
  // print(response.body);
  if (response != null) {
    return json.decode(response.body);
  } else {
    return null;
  }
}

createOrderRequest(String name, String address, String address2, String note) async {
  var apiEndpoint = baseIpUrl + "/orders/checkout/";
  String token = box.read('token');
  var user_id = box.read('user_id');
  var response = await http.post(
    Uri.parse(apiEndpoint),
    body : {
      "profile_id": user_id.toString(),
      "name": name,
      "address_line_1": address,
      "address_line_2": address2,
      "note": note
    },
    headers: {
      "Authorization": 'Token ' + token,
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    }
  );
  if (response != null) {
    return json.decode(response.body);
  } else {
    return null;
  }
}

class BillingController extends GetxController {

  Map billingProfile = {}.obs;
  RxBool isLoading = false.obs;
  RxBool makeOrderLoading = false.obs;
  RxBool truckActive = false.obs;

  Map cart = {}.obs;
  List cartProducts = [].obs;
  
  final formKey = GlobalKey<FormState>();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController address1Ctrl = TextEditingController();
  TextEditingController address2Ctrl = TextEditingController();
  TextEditingController noteCtrl = TextEditingController();
  
  @override
  void onInit() {
    getCurrentCart();
    super.onInit();
    
  }

  getCurrentCart() async {
    isLoading.value = true;
    var response = await getCart();
    cart.clear();
    cartProducts.clear();
    if(response != null) {
      cart = response;
      response['products'].forEach((product) {
        cartProducts.add(product);
      });
    }
    isLoading.value = false;
  }

  _checkTruckActive() async {
    // endpoint call to check trucks active
    var apiEndpoint = baseIpUrl + '/trucks/active';
    var response = await http.get(
      Uri.parse(apiEndpoint),
      headers: {
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      }
    );
    
    if(json.decode(response.body) == true) {
      // truckActive.value = true;
      return true;
    } else {
      // truckActive.value = false;
      return false;
    }
  }

  createOrder() async {
    if(formKey.currentState.validate()) {
      makeOrderLoading.value = true;
      var isTruckActive = await _checkTruckActive();
      if(isTruckActive == true) {
        var response = await createOrderRequest(
          nameCtrl.text, 
          address1Ctrl.text, 
          address2Ctrl.text, 
          noteCtrl.text
        );
      
        if(response != null) {
          show_order_success_dialog();
          } else {
            // something went wrong in call order endpoint
            show_failure_dialog();
        }
      } else {
        // if there is no trucks active return dialog
        show_no_trucks_active_dialog();
      }
      makeOrderLoading.value = false;
    }
  }

}

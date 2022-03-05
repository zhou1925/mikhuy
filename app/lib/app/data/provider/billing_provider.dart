import 'dart:convert';

import 'package:app/app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BillingApiClient extends GetConnect {

  final box = GetStorage('mikhuy');

  getCart() async {

    var apiEndpoint = baseIpUrl + "/cart/";

    String token = box.read('token');
    var response = await get(
      apiEndpoint,
      headers: {"Authorization": 'Token ' + token}
    );

    if(response.hasError){
      return null;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    } else {
      return null;
    }
  }

  checkTruckActive() async {
    var apiEndpoint = baseIpUrl + '/trucks/active';

    var response = await get(apiEndpoint);

    if(response.hasError){
      return null;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    } else {
      return null;
    }

  }


  createOrder(String name, String address, String address2, String note) async {
    var apiEndpoint = baseIpUrl + "/orders/checkout/";
    String token = box.read('token');
    var user_id = box.read('user_id');

    var response = await post(
      apiEndpoint,
      // body
      {
        "profile_id": user_id.toString(),
        "name": name,
        "address_line_1": address,
        "address_line_2": address2,
        "note": note
      },
      // contentType: 'application/json',
      headers: {
        "Authorization": 'Token ' + token,
        "Content-Type": 'application/json'
      }
    );

    if (response != null) {
      return json.decode(response.body);
    } else {
      return null;
    }

  }




  // Stripe integration
  // createPaymentIntent(int profile_id) async {
  //   var apiEndpoint = 'http://192.168.1.69:8000/checkout/?profile_id=${profile_id}';
  //   String token = box.read('token');
  //   var response = await post(
  //     apiEndpoint,
  //     // body
  //     {
  //       "profile_id": profile_id
  //     },
  //     headers: {
  //       "Authorization": 'Token ' + token,
  //       "Content-Type": 'application/json'
  //     }
  //   );

  //   if(response.hasError){
  //     print(response.statusText);
  //   }

  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     return response.body;
  //   } else {
  //     print('error add item in cart provider');
  //     return null;
  //   }
  // }

  // createPaymentIntent2(int profile_id) async {
  //   const apiEndpoint = 'http://192.168.1.69:8000/checkout/?profile_id=';
  //   String token = box.read('token');
  //   var response = await post(
  //     apiEndpoint,
  //     // body
  //     {
  //       "profile_id": profile_id
  //     },
  //     headers: {
  //       "Authorization": 'Token ' + token,
  //       "Content-Type": 'application/json'
  //     }
  //   );

  //   if(response.hasError){
  //     print(response.statusText);
  //   }

  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     return response.body;
  //   } else {
  //     print('error add item in cart provider');
  //     return null;
  //   }
  // }

  // checkoutOrder(int billing_profile_id) async {
  //   const apiEndpoint = 'http://192.168.1.69:8000/checkout/';
  //   String token = box.read('token');
  //   var response = await post(
  //     apiEndpoint,
  //     // body
  //     {
  //       "profile_id": billing_profile_id
  //     },
  //     headers: {
  //       "Authorization": 'Token ' + token,
  //       "Content-Type": 'application/json'
  //     }
  //   );

  //   if(response.hasError){
  //     print(response.statusText);
  //   }

  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     return response.body;
  //   } else {
  //     print('error add item in cart provider');
  //     return null;
  //   }
  // }

}
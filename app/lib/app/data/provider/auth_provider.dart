
import 'package:get/get.dart';


class AuthApiClient extends GetConnect {

  login(String username, String password) async {
    // print('AUTH PROVIDER');
    final apiEndpoint = 'https://www.mikhuy.xyz/login/';

    var response = await post(
      apiEndpoint,
      {
        "username": username,
        "password": password
      },
      headers: {
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      }
      // headers: headers,
      // headers: {
      //   'Content-Type': 'application/json',
      //   'Access-Control-Allow-Origin': '*',
      // }
    );

    // if(response.hasError){
    //   return null;
    // }


    if(response != null) {
      // print(response.body);
    } else {
      // print('resposne auth provider');
    }


    // if (response.statusCode >= 200 && response.statusCode < 300) {
    //   // return response2.body;
    //   print(response.body);

    // } else {
    //   print('AUTH PROVIDER RETURN NULL STATUS 400');
    //   return null;
    // }
  }

  

  register(String phone, String password) async {

    // var apiEndpoint = baseIpUrl + "/users/";
    var apiEndpoint = 'https://167.99.3.134/users/';
    var response = await post(
      apiEndpoint,
      {
        "phone": phone,
        "password": password,
      },
      headers: {
        "Content-Type": 'application/json'
      }
    ).timeout(Duration(seconds: 10));

    if(response.hasError){
      return null;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    } else {
      return null;
    }
  }

}
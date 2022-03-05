import 'package:app/app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileApiClient extends GetConnect {

  final box = GetStorage('mikhuy');

  updatePhone(String newPhone) async {
    String token = box.read('token');
    var user_id = box.read('user_id');
    var apiEndpoint = baseIpUrl + "/users/${user_id}/";

    var response = await put(
      apiEndpoint,
      // body
      {
        "phone": newPhone,
      },
      // contentType: 'application/json',
      headers: {
        "Authorization": 'Token ' + token,
        "Content-Type": 'application/json'
      }
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

  updatePassword(String old_password, String new_password) async {
    String token = box.read('token');
    var user_id = box.read('user_id');
    var apiEndpoint = baseIpUrl + "/users/${user_id}/change_password/";

    var response = await put(
      apiEndpoint,
      // body
      {
        "old_password": old_password,
        "new_password": new_password
      },
      // contentType: 'application/json',
      headers: {
        "Authorization": 'Token ' + token,
        "Content-Type": 'application/json'
      }
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

}
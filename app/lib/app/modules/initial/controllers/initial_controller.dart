import 'package:app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class InitialController extends GetxController {

  final box = GetStorage('mikhuy');

  String verifyAuth() {
    var token = box.read('token');
    // print(token);
    if( token == null) {
      return Routes.WELCOME;
    }else {
      return Routes.HOME;
    }
  }
  
}

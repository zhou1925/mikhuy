import 'package:app/app/data/provider/auth_provider.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<AuthApiClient>(() => AuthApiClient());
    // Get.lazyPut<AuthRepository>(() => AuthRepository());
    // Get.lazyPut<AuthApiClient>(() => AuthApiClient());
  }
}

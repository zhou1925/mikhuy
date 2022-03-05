import 'package:app/app/data/provider/auth_provider.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(
      () => SignupController(),
    );

    Get.lazyPut<AuthApiClient>(
      () => AuthApiClient(),
    );
  }
}

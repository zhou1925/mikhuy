import 'package:app/app/data/provider/profile_provider.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );

    Get.lazyPut<ProfileApiClient>(
      () => ProfileApiClient(),
    );
  }
}

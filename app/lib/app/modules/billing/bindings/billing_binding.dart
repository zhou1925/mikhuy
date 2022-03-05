import 'package:app/app/data/provider/billing_provider.dart';
import 'package:get/get.dart';

import '../controllers/billing_controller.dart';

class BillingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillingController>(
      () => BillingController(),
    );

    Get.lazyPut<BillingApiClient>(
      () => BillingApiClient(),
    );
  }
}

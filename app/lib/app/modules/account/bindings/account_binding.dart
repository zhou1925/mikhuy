import 'package:app/app/data/provider/billing_provider.dart';
import 'package:get/get.dart';

import '../controllers/account_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(
      () => AccountController(),
    );

    Get.lazyPut<BillingApiClient>(
      () => BillingApiClient(),
    );
  }
}

import 'package:app/app/data/provider/cart_provider.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(
      () => CartController(),
    );

    Get.lazyPut<CartApiClient>(
      () => CartApiClient(),
    );

    // Get.create<CartController>(() => CartController());
    // Get.put<CartController>(CartController(), tag: 'totalCart');
  }
}

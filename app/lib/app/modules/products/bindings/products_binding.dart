import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../controllers/products_controller.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsController>(
      () => ProductsController(),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}

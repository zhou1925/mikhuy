import 'package:app/app/data/provider/cart_provider.dart';
import 'package:app/app/data/provider/products_provider.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsApiClient>(
      () => ProductsApiClient(),
    );
    
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<CartApiClient>(
      () => CartApiClient(),
    );
    
  }
}

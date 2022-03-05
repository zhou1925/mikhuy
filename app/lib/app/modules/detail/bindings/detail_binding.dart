import 'package:app/app/data/provider/detail_provider.dart';
import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailApiClient>(
      () => ProductDetailApiClient(),
    );

    Get.lazyPut<DetailController>(
      () => DetailController(),
    );
  }
}

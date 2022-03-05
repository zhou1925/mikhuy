import 'package:app/app/data/provider/order_provider.dart';
import 'package:app/app/data/provider/orders_provider.dart';
import 'package:app/app/modules/order/controllers/order_controller.dart';
import 'package:get/get.dart';

import '../controllers/orders_controller.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersController>(
      () => OrdersController(),
    );

    Get.lazyPut<OrderController>(
      () => OrderController(),
    );

    Get.lazyPut<OrdersApiClient>(
      () => OrdersApiClient(),
    );

    Get.lazyPut<OrderApiClient>(
      () => OrderApiClient(),
    );
  }
}

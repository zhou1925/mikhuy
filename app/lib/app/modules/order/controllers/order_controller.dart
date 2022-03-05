import 'package:app/app/constants/constants.dart';
import 'package:app/app/global/widgets/alert_dialogs.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


final box = GetStorage('mikhuy');

  getOrderDetailApi(String orderId) async {
    var apiEndpoint = baseIpUrl + "/accounts/orders/";

    String token = box.read('token');

    var response = await http.get(
      apiEndpoint + orderId,
      headers: {"Authorization": 'Token ' + token}
    );

    if (response != null) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  cancelOrderApi(String order_id) async {
    String token = box.read('token');
    var apiEndpoint = baseIpUrl + "/orders/checkout/";
    var response = await http.put(
      apiEndpoint,
      body :
      {
        "order_id": order_id,
        "status": "canceled"
      },
      headers: {
        "Authorization": 'Token ' + token,
        
      }
    );

    if (response != null) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }





class OrderController extends GetxController {

  var order = [].obs;
  List cartProducts = [].obs;
  RxBool isLoading = false.obs;
  RxBool cancelLoader = false.obs;
  String orderStatus = '';


  @override
  void onClose() {
    order.clear();
    cartProducts.clear();
    super.onClose();
  }

  cancelOrder(String order_id) async {
    cancelLoader.value = true;

    var response = await cancelOrderApi(order_id);

    if(response != null) {
      show_cancel_order_dialog();
    }

    cancelLoader.value = false;
  }

  getOrderStatus() {
    switch (orderStatus) {
      case 'created':
        return 0;
        break;
      case 'received':
        return 1;
        break;
      case 'shipped':
        return 2;
        break;
      case 'delivered':
        return 3;
        break;
      case 'paid':
        return 4;
        break;
      default:
        return 0;
        break;
    }
  }

  void loadOrder(String orderId) async {
    isLoading.value = true;
    var response = await getOrderDetailApi(orderId);
    order.clear();
    cartProducts.clear();
    // print('product data cleared!');
    if(response != null) {
      order.add(response);
      orderStatus = response['status'];
      // print(response['status']);
      response['cart']['products'].forEach((product) {
        cartProducts.add(product);
      });
    }
    // print(cartProducts[0]['product']);
    // print(cartProducts[0]['product']['image']);
    // print(order);
    // print(order[0]);
    // print(order[0]['billing_profile']);
    // print(response);
    // print(order[0]['billing_profile']['id']);
    // print(order[0]['billing_profile']['user']);
    // print(order[0]['billing_profile']['name']);
    // print(order[0]['order_id']);
    // print(order[0]['cart']);
    // print(order[0]['status']);
    // print(order[0]['shipping_total']);
    // print(order[0]['cart_total']);
    // print(order[0]['tax_total']);
    // print(order[0]['total']);
    // print(order[0]['total_in_paise']);
    isLoading.value = false;    
  }

}

import 'package:app/app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OrderApiClient extends GetConnect {

  final box = GetStorage('mikhuy');

  getOrderDetail(String orderId) async {
    var apiEndpoint = baseIpUrl + "/accounts/orders/";

    String token = box.read('token');

    var response = await get(
      apiEndpoint + orderId,
      headers: {"Authorization": 'Token ' + token}
    );

    if(response.hasError){
      return null;
    }

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  cancelOrder(String order_id) async {
    String token = box.read('token');
    var apiEndpoint = baseIpUrl + "/orders/checkout/";

    var response = await put(
      apiEndpoint,
      // body
      {
        "order_id": order_id,
        "status": "canceled"
      },
      // contentType: 'application/json',
      headers: {
        "Authorization": 'Token ' + token,
        "Content-Type": 'application/json'
      }
    );

    if(response.hasError){
      return null;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    } else {
      return null;
    }
  }

}
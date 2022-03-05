import 'package:app/app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OrdersApiClient extends GetConnect {

  final box = GetStorage('mikhuy');
  
  createOrder() async {
    var apiEndpoint = baseIpUrl + "/checkout/";
    String token = box.read('token');
    var response = await post(
      apiEndpoint,
      {
        
      },
      headers: {"Authorization": 'Token ' + token}
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

  getOrders() async {
    var apiEndpoint = baseIpUrl + "/accounts/orders/";

    String token = box.read('token');
    var response = await get(
      apiEndpoint,
      headers: {"Authorization": 'Token ' + token}
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
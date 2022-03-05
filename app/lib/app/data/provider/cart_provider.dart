import 'package:app/app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartApiClient extends GetConnect {

  final box = GetStorage('mikhuy');

  getCart() async {
    var apiEndpoint = baseIpUrl + "/cart/";

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

  deleteItemInCart(int productId) async {
    var apiEndpoint = baseIpUrl + "/cart/cart-item/${productId}/";

    String token = box.read('token');

    var response = await delete(
      apiEndpoint,
      headers: {
        "Authorization": 'Token ' + token,
        "Content-Type": 'application/json'
      }
    );

    if(response.hasError){
      return null;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      return null;
    }
  }

  addItemToCart(int productId, int productQuantity) async {
    var apiEndpoint = baseIpUrl + "/cart/";
    String token = box.read('token');
    var response = await post(
      apiEndpoint,
      {
        'id': productId,
        'quantity': productQuantity
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

  updateProductQuantity(int cartProductId, int productQuantity, int productId) async {
    var apiEndpoint = baseIpUrl + "/cart/cart-item/${cartProductId}/";
    String token = box.read('token');
    var response = await put(
      apiEndpoint,
      {
        'product': productId,
        'quantity': productQuantity
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
import 'package:app/app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


final box = GetStorage('mikhuy');

getCart() async {
  var apiEndpoint = baseIpUrl + "/cart/";
  String token = box.read('token');
  var response = await http.get(
    Uri.parse(apiEndpoint),
    headers: {
      "Authorization": 'Token ' + token
    }
  );

  if (response != null) {
    return json.decode(response.body);
  } else {
    return null;
  }
}

deleteItemInCartApi(String productId) async {
  var apiEndpoint = baseIpUrl + "/cart/cart-item/${productId}/";
  String token = box.read('token');
  var response = await http.delete(
    Uri.parse(apiEndpoint),
    headers: {
      "Authorization": 'Token ' + token,
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    }
  );
  if (response != null) {
    return true;
  } else {
    return null;
  }
}

addItemToCart(int productId, int productQuantity) async {
  var apiEndpoint = baseIpUrl + "/cart/";
  String token = box.read('token');
  var response = await http.post(
    apiEndpoint,
    body:{
      'id': productId,
      'quantity': productQuantity
    },
    headers: {
      "Authorization": 'Token ' + token,
      "Content-Type": 'application/json',
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    }
  );

  if (response != null) {
    return json.decode(response.body);
  } else {
    return null;
  }
}

updateProductQuantity(String cartProductId, String productQuantity, String productId) async {
  var apiEndpoint = baseIpUrl + "/cart/cart-item/${cartProductId}/";
  String token = box.read('token');
  var response = await http.put(
    apiEndpoint,
    body: {
      'product': productId,
      'quantity': productQuantity
    },
    headers: {
      "Authorization": 'Token ' + token,
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    }
  );
  if (response != null) {
    return json.decode(response.body);
  } else {
    return null;
  }
}

class CartController extends GetxController {

  Map cart = {}.obs;
  List cartProducts = [].obs;
  var total = 5.obs;
  RxBool isLoading = false.obs;
  List<String> itemsDrop = ["1", "2", "3","4","5","6","7","8","9"];
  var selected = "1";
  final quantitySelected = "1".obs;

  // cart controller medium
  var quantity = 0.obs;
  var totalCart = 0.obs;


  void setSelected(String value, String productId){
    // print('${value} selection productId:${productId}');
    selected = value;
    quantitySelected.value = value;
  }

  loadCart() async {
    isLoading.value = true;
    var response = await getCart();
    cart.clear();
    cartProducts.clear();
    if(response != null) {
      cart = response;
      response['products'].forEach((product) {
        cartProducts.add(product);
      });
    }
    
    isLoading.value = false;
  }

  
  @override
  void onClose() {
    cart.clear();
    cartProducts.clear();
    super.onClose();
  }

  @override
  void onInit() {
    loadCart();
    super.onInit();
    update();
  }

  void refreshUi() {
    Get.create<CartController>(() => CartController());
    Get.put<CartController>(CartController());
    Get.find<CartController>();
    refresh();
    update();
  }

  deleteItemInCart(productCartId) async {
    var response = await deleteItemInCartApi(productCartId);
    if(response == true) {
      loadCart();
    }
  }

  Future addItemToCart(productId, productQuantity) async {
    // POST return cart object
    isLoading.value = true;
    var response = await addItemToCart(productId, productQuantity);
    cart.clear();
    cartProducts.clear();
    if(response != null) {
      cart = response;
      response['products'].forEach((product) {
        cartProducts.add(product);
      });
    }
    refresh();
    update();
    isLoading.value = false;
  }

  updateItemInCart(cartProductId, productQuantity, productId) async {
    var response = await updateProductQuantity(
      cartProductId, 
      productQuantity, 
      productId
    );
    
    if(response != null) {
      loadCart();
    }
  }

}

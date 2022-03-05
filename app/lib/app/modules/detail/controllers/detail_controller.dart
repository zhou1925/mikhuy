import 'package:app/app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

getProductDetail(String slug) async {
    var apiEndpoint = baseIpUrl + "/products/list/";
    var response = await http.get(
      Uri.parse(apiEndpoint + slug + '/'),
      headers: {
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      }
    );


    if (response != null) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  getRelatedProducts(String productId) async {
    var apiEndpoint = baseIpUrl + "/products/related/";
    var response = await http.get(
      Uri.parse(apiEndpoint + productId + '/'),
      headers: {
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      }
    );


    if (response != null) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

class DetailController extends GetxController {

  var product = [].obs;
  var relatedProducts = [].obs;
  // RxMap product2 = {}.obs;
  RxBool isloading = false.obs;
  RxBool cartIsLoading = false.obs;
  var aguments = Get.arguments;

  // @override
  // void onInit() {
  //   loadProduct(null);
  //   loadRelatedProducts("1");
  //   super.onInit();
    
  // }

  @override
  void onClose() {
    product.clear();
    relatedProducts.clear();
    super.onClose();
  }

  void loadRelatedProducts(String productId) async {
    isloading.value = true;
    var response = await getRelatedProducts(productId);
    relatedProducts.clear();
    if(response != null) {
      response.forEach((product) {
          relatedProducts.add(product);
        });
    }
    // print(relatedProducts);
    isloading.value = false;

  }


  void loadProduct(String slug) async {
    isloading.value = true;
    var response = await getProductDetail(slug);
    product.clear();
    // print('product data cleared!');
    if(response != null) {
      product.add(response);
    }
    // print(product[0]['image']);
    isloading.value = false;
    // print('new product data////////////////////');
    // print(product);
    // print(product[0]['id']);
    // print(product[0]['product'][0]['title']);
    // print('Category data inside of product');
    // print(product[0]['product']);
    // print('copy DAta');
    
  }
}

import 'package:app/app/data/provider/category_provider.dart';
import 'package:app/app/data/provider/products_provider.dart';
import 'package:app/app/modules/cart/controllers/cart_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


getProductList() async {
    var apiEndpoint = "https://www.mikhuy.xyz/products/list/";
    var response = await http.get(
      Uri.parse(apiEndpoint),
      headers: {
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      }
    
    );

    // print(response.body);

    if (response != null) {
      return json.decode(response.body);
    } else {
      return null;
    }
}


class HomeController extends GetxController {
  // esential
  final box = GetStorage('mikhuy');
  // final productsApiClient = Get.find<ProductsApiClient>();
  final apiClient = ProductsApiClient(); // home
  final categoryApiClient = CategoryApiClient();
  final CartController cartController = Get.put(CartController());
  // final categoryController = CategoryController();

  RxInt indexDish = 0.obs;
  RxInt selectedTab = 0.obs;

  // bttom nav custom
  RxInt selectedIndex = 0.obs;
  Color backgroundColorNav = Colors.white;

  // Home
  RxBool isloading = false.obs;
  List products = [].obs;
  // search by names list is required
  List productsName = [].obs;

  @override
  void onInit() {
    loadData();
    choiceDishIndex(0);
    super.onInit();
  }


  void choiceIndex(int index) {
    selectedIndex.value = index;
  }

  void choiceDishIndex(int index) {
    // print('on page changed index ${index}');
    indexDish.value = index;
    // print(indexDish.value == index);
    refresh();
    // print('index dish value contorller ${indexDish.value}');
  }

  choiceTabIndex(int index) {
    selectedTab.value = index;
    if(selectedTab.value == 0) {
      return Get.toNamed('/home');
    }
    // else if (selectedTab.value == 1) {
    //   return Get.toNamed('/trucks');
    // }
    else if (selectedTab.value == 1) {
      cartController.loadCart();
      return Get.toNamed('/cart');
    }
    else if (selectedTab.value == 2) {
      return Get.toNamed('/account');
    }
    else {
      return Get.toNamed('/home');
    }
  }

  void logout(){
    box.erase();
    Get.offAllNamed('/welcome');
  }

  void loadData() async {
    isloading.value = true;
    var response = await getProductList();
    products.clear();
    if(response != null) {
      // [{}]
      response.forEach((product) {
          // product['is_']
          products.add(product);
          productsName.add(product['title']);
        });
    }
    // print(products);
    isloading.value = false;
  }

}

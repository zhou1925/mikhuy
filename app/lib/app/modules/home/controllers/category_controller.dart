import 'package:app/app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

getCategoryList() async {
    var apiEndpoint = baseIpUrl + "/products/category/";
    var response = await http.get(
      Uri.parse(apiEndpoint),
      headers: {
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      }
    );


    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  getCategoryDetail(String categoryId) async {
    var apiEndpoint = baseIpUrl + "/products/category/";
    var response = await http.get(
      Uri.parse(apiEndpoint + categoryId + '/'),
      headers: {
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      }
    );


    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }


class CategoryController extends GetxController {

  var currentIndex = 0.obs;
  List categories = [].obs;
  RxBool isloading = false.obs;
  // Categories names
  List categoryData = [].obs;
  // Categories content
  List categoryDataDetail = [].obs;

  @override
  void onInit() {
    // print('${categoryDataDetail.length} category data detail length init');
    // print('${categories.length} categories length init');
    loadData(1.toString());
    loadCategory();
    // print('${categories.length} categories length after api call');
    // print('${categoryDataDetail.length} category data detail length after api call');
    super.onInit();
  }

  // @override
  // void onReady() {
  //   loadData(1.toString());
  //   loadCategory();
  //   super.onReady();
  // }

  // load titles category
  void loadCategory() async {
    isloading.value = true;
    var response = await getCategoryList();
    if(response != null) {
      response.forEach((category) {
          categories.add(category);
        });
    }
    isloading.value = false;
  }


  // Load data by ID and data of product
  void loadData(String categoryId) async {
    isloading.value = true;
    var response = await getCategoryDetail(categoryId);
    // print(response);
    // print('clear data');
    // print(categoryData);
    // categoryData.clear();
    // print('category data cleared!');
    if(response != null) {
      categoryData.clear();
      categoryData.add(response);
      categoryDataDetail = categoryData[0]['product'];

    }
    // refresh();
    isloading.value = false;
  }

}
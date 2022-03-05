import 'package:app/app/constants/constants.dart';
import 'package:get/get.dart';

class CategoryApiClient extends GetConnect {

  getCategoryList() async {
    var apiEndpoint = baseIpUrl + "/products/category/";
    var response = await get(apiEndpoint);

    if(response.hasError){
      return null;
    }

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  getCategoryDetail(String categoryId) async {
    var apiEndpoint = baseIpUrl + "/products/category/";
    var response = await get(apiEndpoint + categoryId + '/');

    if(response.hasError){
      return null;
    }

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

}
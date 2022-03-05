import 'package:app/app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class ProductsApiClient extends GetConnect{
  final box = GetStorage('mikhuy');

  getProductList() async {
    var apiEndpoint = baseIpUrl + "/products/list/";
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

  getProduct(slug) async {
    var apiEndpoint = baseIpUrl + "/products/list/";
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

}
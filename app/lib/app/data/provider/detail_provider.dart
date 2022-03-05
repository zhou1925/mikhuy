import 'package:app/app/constants/constants.dart';
import 'package:get/get.dart';

class ProductDetailApiClient extends GetConnect {

  getProductDetail(String slug) async {
    var apiEndpoint = baseIpUrl + "/products/list/";
    var response = await get(apiEndpoint + slug + '/');

    if(response.hasError){
      return null;
    }

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  getRelatedProducts(String productId) async {
    var apiEndpoint = baseIpUrl + "/products/related/";
    var response = await get(apiEndpoint + productId + '/');

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
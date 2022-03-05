import 'package:app/app/constants/constants.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeProvider {

  getProductList() async {
    var apiEndpoint = baseIpUrl + "/products/list/";
    var response = await http.get(
      Uri.parse(apiEndpoint),
      headers: {
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      }
    
    );

    // print(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

}

// class HomeProviderGetx extends GetConnect {

//   getProductList() async {
//     var apiEndpoint = baseIpUrl + "/products/list/";
//     var response = await get(apiEndpoint);

//     if(response.hasError){
//       return null;
//     }

//     if (response.statusCode == 200) {
//       return response.body;
//     } else {
//       return null;
//     }
//   }

// }
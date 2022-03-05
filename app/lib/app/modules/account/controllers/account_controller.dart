import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/app/constants/constants.dart';
import 'package:app/app/data/provider/billing_provider.dart';
import 'package:app/app/global/widgets/alert_dialogs.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AccountController extends GetxController {
  final box = GetStorage('mikhuy');

  final billingApiClient = BillingApiClient();
  RxBool isLoading = false.obs;
  RxBool truckActive = false.obs;

  void logout(){
    box.erase();
    Get.offAllNamed('/welcome');
  }

  checkTruckActive() async {
    // endpoint call to check trucks active
    var apiEndpoint = baseIpUrl + '/trucks/active';
    var response = await http.get(
      Uri.parse(apiEndpoint),
      headers: {
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      }
    );
    
    if(json.decode(response.body) == true) {
      show_truck_active_dialog();
    } else {
      show_no_trucks_active_dialog();
    }
  }


}

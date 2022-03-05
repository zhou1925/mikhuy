import 'package:app/app/constants/constants.dart';
import 'package:app/app/global/widgets/alert_dialogs.dart';
import 'package:app/app/modules/account/widgets/profile_menu.dart';
// import 'package:app/app/modules/account/widgets/profile_pic.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi cuenta', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              
              child: SvgPicture.asset(
                'assets/icons/back_arrow.svg',
                width: 24,
                height: 24,
                color: Colors.black87
              )
            ),
          )
        ),
      ),
      
      body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // ProfilePic(),
          SizedBox(height: 5),
          ProfileMenu(
            text: "Cambiar mi numero",
            icon: "assets/icons/phone.svg",
            press: () {
              Get.toNamed(Routes.PROFILE);
            },
          ),
          ProfileMenu(
            text: "Mis Ordenes",
            icon: "assets/icons/parcel.svg",
            press: () {
              Get.toNamed(Routes.ORDERS);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextButton(
              style: TextButton.styleFrom(
              primary: kBlackButtonColor,
              padding: EdgeInsets.all(20),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              backgroundColor: Color(0xFFF5F6F9),
              ),
              onPressed: () {
                controller.checkTruckActive();
              },
              child: Row(
                children: [
                  Icon(Icons.airport_shuttle_outlined),
                  SizedBox(width: 20),
                  Expanded(child: Text('Consultar remolque activo')),
                  Icon(Icons.arrow_forward_ios),
                ]
              ),
            ),
          ),
          ProfileMenu(
            text: "Sobre nosotros",
            icon: "assets/icons/question_mark.svg",
            press: () {
              Get.bottomSheet(Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: Container(
                    width: 300,
                    
                    child: Text(
                      about_me,
                      style: TextStyle(
                        color: kGreyColor
                      ),
                    ),
                  ),
              )));
            },
          ),
          ProfileMenu(
            text: "Centro de ayuda",
            icon: "assets/icons/question_mark.svg",
            press: () {
              show_contact_manager_dialog();
            },
          ),
          ProfileMenu(
            text: "Salir",
            icon: "assets/icons/log_out.svg",
            press: () {
              controller.logout();
            },
          ),
        ],
      ),
    )
    );
  }
}

import 'package:app/app/global/widgets/rounded_button.dart';
// import 'package:app/app/global/widgets/rounded_input_field.dart';
// import 'package:app/app/global/widgets/text_field_container.dart';
import 'package:app/app/modules/billing/controllers/billing_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';


class BillingView extends GetView<BillingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: AppBar(
        title: Text('Confirmar Orden', style: TextStyle(color: Colors.black)),
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

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: 
            Obx(() {
              if(controller.isLoading.value) {
                return Text('');
              }
              return 
              Chip(
                backgroundColor: Colors.transparent,
                labelPadding: EdgeInsets.all(6.0),
                label: Text('${controller.cart['total_cart_products'].toString()}'),
                avatar: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.shopping_cart_outlined, size: 20, color: Colors.black,)
                ),
              );
            })
          ),
        ],
      ),

    body: SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 2),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Productos',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),


              Obx(() {
                if(controller.isLoading.value == true) {
                  return Center(
                    child: Lottie.asset(
                      'assets/icons/burger_loader.json',
                      width: 100,
                      height: 100,
                    ),
                  );
                }

                return Container(
                  height: 150,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.cartProducts.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 150,
                        width: 130,
                        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                        ),    
                        child: Column(
                          children: [
                            SizedBox(height:10),
                            Container(
                              height: 26,
                              width: 26,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color(0xfff4f4f4),
                                image: 
                                DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    
                                    controller.cartProducts[index]['product']['image']
                                  )
                                ) 
                              )
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    // controller.isLoading.value ? '' :
                                    // controller.cartProducts[index]['product']['title'],
                                    controller.cartProducts[index]['product']['title'].toString().length < 10 ?
                                    controller.cartProducts[index]['product']['title'] :
                                    '${controller.cartProducts[index]['product']['title'].toString().substring(0, 10)}...',
                                    style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  // DropDown button
                                  Text(
                                    // categoryController.isloading.value ? '' :
                                    // 'S./ ${categoryController.categoryDataDetail[index]['price'].toString()}',
                                    // 'S./ ${controller.cartProducts[index]['product']['price'].toString()}',
                                    'x${controller.cartProducts[index]['quantity'].toString()}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  // DropDown button
                                  Text(
                                    // categoryController.isloading.value ? '' :
                                    // 'S./ ${categoryController.categoryDataDetail[index]['price'].toString()}',
                                    // 'S./ ${controller.cartProducts[index]['product']['price'].toString()}',
                                    'S./ ${controller.cartProducts[index]['product']['price'].toString()}',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              )
                            ),
                      
                      
                          ],
                      
                        )
                      );
                    }
                  ),
                );
              }),  

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Divider(),
              ),

              

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  onTap: () {},
                  controller: controller.nameCtrl,
                  
                  // cursorColor: Get.theme.primaryColorLight,
                  
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    hintText: "John Doe",
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  onTap: () {},
                  controller: controller.address1Ctrl,
                  // cursorColor: Get.theme.primaryColorLight,
                  decoration: InputDecoration(
                    labelText: 'Direccion',
                    hintText: "Jr. Los amantes Nro 112",
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),

              SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  onTap: () {},
                  controller: controller.address2Ctrl,
                  // cursorColor: Get.theme.primaryColorLight,
                  decoration: InputDecoration(
                    labelText: 'Referencia',
                    hintText: "Casa blanca/interior A/callejon/etc/",
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),

               SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  onTap: () {},
                  controller: controller.noteCtrl,
                  // cursorColor: Get.theme.primaryColorLight,
                  decoration: InputDecoration(
                    labelText: 'Notas adicionales',
                    hintText: "(Opcional) Sal extra/ Poco aceite/ mas aji/ ",
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),

              Obx(
                () {
                if(controller.isLoading.value) {
                  return Text('');
                }
                return
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),

                  child: Text(
                    'Total: S./ ${controller.cart['total'].toString()}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
                }
              ),
              
              Obx(
                  () => Visibility(
                    visible: !controller.makeOrderLoading.value,
                    child: RoundedButton(
                      
                      text: "Finalizar pedido",
                      press: () {
                        // create order in api
                        // if the order is success return alert dialog
                        controller.createOrder();
                      },
                    ),
                  )
                ),
                Obx(
                  () => Visibility(
                    visible: controller.makeOrderLoading.value,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      width: Get.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: TextButton(
                          
                          onPressed: (){},
                          child: CircularProgressIndicator(),
                        )
                      ),
                    )
                  )
                ),
            ],
          ),
        ),
      )

      )
    );
  }
}

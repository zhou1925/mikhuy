import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: AppBar(
        elevation: 0,
        title: Text('Mi Carrito', style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.transparent,
        centerTitle: true,
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
        // actions: [
        //     Padding(
        //       padding: const EdgeInsets.only(right: 20.0),
        //       child: IconButton(
        //         onPressed: () {
        //           Get.offAndToNamed(Routes.HOME);
        //         },
        //         icon: Icon(
        //           Icons.home_outlined,
        //           color: Colors.black87,
        //         )
        //       ),
        //     )
        //   ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

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

                if(controller.cartProducts.length == 0) {
                  return Center(child: Text('No hay productos en el carrito'));
                }

                return Container(
                  
                  child: ListView.builder(
                    controller: ScrollController(),
                    itemCount: controller.cartProducts.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 90,
                        width: 300,
                        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                        ),    
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: 
                                DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    controller.cartProducts[index]['product']['image']
                                    
                                  )
                                ) 
                              )
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.isLoading.value ? '' :
                                    controller.cartProducts[index]['product']['title'],
                                    // 'product name',
                                    style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  // DropDown button
                                  Text(
                                    // categoryController.isloading.value ? '' :
                                    // 'S./ ${categoryController.categoryDataDetail[index]['price'].toString()}',
                                    'S./ ${controller.cartProducts[index]['product']['price'].toString()}',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              )
                            ),

                            // Obx(() {
                            // return
                            // DropdownButton(
                            //   items: controller.itemsDrop
                            //   .map((String item) => 
                            //   DropdownMenuItem<String>(
                            //     child: Text(('1', '2', '3')),
                            //     value: item)
                            //   ).toList(),
                            //   value: controller.quantitySelected.value,
                            //   onChanged: (newValue) {
                            //     var productId = controller.cartProducts[index]['id'].toString();
                            //     controller.setSelected(newValue, productId);
                            //     controller.update();
                            //   },
                            // );
                            // }),
                            
                            Obx(() {
                              return Text(controller.cartProducts[index]['quantity'].toString());
                            }),

                            PopupMenuButton(
                              tooltip: 'Cantidad',
                              onSelected: (value) {
                                var cartProductId = controller.cartProducts[index]['id'].toString();
                                var productId = controller.cartProducts[index]['product']['id'].toString();
                                var productQuantity = value.toString();
                                // print('id of the product:${cartProductId} Product: ${productId} - quntity selected:${productQuantity}');
                                controller.updateItemInCart(cartProductId, productQuantity, productId);
                                // Get.bottomSheet(Container(
                                //   width: double.infinity,
                                //   height: 300,
                                //   color: Colors.greenAccent,
                                //   child: const Center(
                                //     child: Text('Bottom Sheet Content'),
                                //   )));
                                // Get.dialog(AlertDialog(
                                //   title: const Text('Dialog Title'),
                                //   content: const Text('This is the dialog content'),
                                //   actions: [
                                //     TextButton(
                                //         onPressed: () => Get.back(), // Close the dialog
                                //         child: const Text('Close'))
                                //   ],
                                // ));
                              },
                              icon: Icon(Icons.arrow_drop_down),
                              initialValue: 1,
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text("1"),
                                  value: 1,
                                ),
                                PopupMenuItem(
                                  child: Text("2"),
                                  value: 2,
                                ),
                                PopupMenuItem(
                                  child: Text("3"),
                                  value: 3,
                                ),
                                PopupMenuItem(
                                  child: Text("4"),
                                  value: 4,
                                ),
                                PopupMenuItem(
                                  child: Text("5"),
                                  value: 5,
                                ),
                                PopupMenuItem(
                                  child: Text("6"),
                                  value: 6,
                                ),
                                PopupMenuItem(
                                  child: Text("7"),
                                  value: 7,
                                ),
                                PopupMenuItem(
                                  child: Text("8"),
                                  value: 8,
                                ),
                                PopupMenuItem(
                                  child: Text("9"),
                                  value: 9,
                                ),
                              ]
                            ),

                            SizedBox(width: 15),
                            IconButton(
                              color: Color(0xffEB0F1C),
                              onPressed: (){
                                controller.deleteItemInCart(
                                  controller.cartProducts[index]['id'].toString(),
                                );
                              },
                              icon: Icon(
                                Icons.delete_outline,
                                color: Color(0xffEB0F1C),
                              )
                            )

                          ],

                        )
                      );
                    }
                  ),
                );
              }),

            ]
          ),
        )
      ),

      bottomNavigationBar: 
      Obx(() {
        if(controller.cartProducts.isEmpty) {
          return Container();
        }
        return
      
      Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
        child: Container(
          width: Get.width,
          height: 120,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
              )
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            color: Colors.white 
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Total: S./ ${controller.cart['total'].toString()}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ))
                ),
                SizedBox(height: 5),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.BILLING);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Text('Confirmar Pedido', style: TextStyle(color: Colors.white))
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 5),
                // Expanded(
                //   child: Container(
                //     padding: EdgeInsets.symmetric(horizontal: 20.0),
                //     height: 25,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: Colors.black,
                //     ),
                //     child: Center(
                //       child: Text('Pagar con Visa', style: TextStyle(color: Colors.white))
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
    })
    );
  }
}

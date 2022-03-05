import 'package:app/app/modules/order/controllers/order_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {

  final OrdersController ordersController = Get.put(OrdersController());
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: AppBar(
        title: Text('Mis ordenes', style: TextStyle(color: Colors.black)),
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

                if(ordersController.orders.isEmpty) {
                  return Center(child: Text('No hay ordenes'));
                }

                return Container(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: ordersController.orders.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          var order_code = ordersController.orders[index]['order_code'];
                        
                          orderController.loadOrder(order_code);
                          Get.toNamed(Routes.ORDER);
                        },
                        child: Container(
                          height: 160,
                          width: 300,
                          margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)
                          ),    
                          child: 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.amber[100],
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Text(
                                      '${ordersController.orders[index]['order_code']}',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  
                                  Icon(
                                    Icons.drag_indicator_rounded
                                  )
                                ]
                              ),
                              

                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Chip(
                                  backgroundColor: Colors.transparent,
                                  labelPadding: EdgeInsets.all(6.0),
                                  label: Text('${ordersController.orders[index]['cart_total'].toString()}'),
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    child: Icon(Icons.shopping_cart_outlined, size: 20, color: Colors.black,)
                                  ),
                                ),

                                Chip(
                                  backgroundColor: Colors.transparent,
                                  labelPadding: EdgeInsets.all(6.0),
                                  label: Text('${ordersController.orders[index]['shipping_total'].toString()}'),
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    child: Icon(Icons.delivery_dining_outlined, size: 20, color: Colors.black,)
                                  ),
                                ),

                                Chip(
                                  backgroundColor: Colors.transparent,
                                  labelPadding: EdgeInsets.all(6.0),
                                  label: Text('${ordersController.orders[index]['total'].toString()}'),
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    child: Text('S./', style: TextStyle(color: Colors.black),)
                                  ),
                                ),
                                
                              ]),

                              Container(
                                alignment: Alignment.topCenter,
                                child: LinearProgressIndicator(
                                  value:
                                  (ordersController.orders[index]['status'] == 'created') ? 0.2 :
                                  (ordersController.orders[index]['status'] == 'received') ? 0.4 :
                                  (ordersController.orders[index]['status'] == 'delivered') ? 0.6 :
                                  (ordersController.orders[index]['status'] == 'shipped') ? 0.8 :
                                  (ordersController.orders[index]['status'] == 'paid') ? 1 : 0.0,
                                  backgroundColor: Colors.grey[200],
                                  color: Colors.red[400]
                                )
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text(
                                  // '${ DateFormat('yyyy-MM-dd | kk:mm').format(DateTime.parse(ordersController.orders[index]['timestamp']))}',
                                  '${ DateFormat('yyyy-MM-dd').format(DateTime.parse(ordersController.orders[index]['timestamp']))}',
                                  style: TextStyle(color: Colors.grey[400]),
                                  ),
                                  Text(
                                  (ordersController.orders[index]['status'] == 'created') ? 'Creado' :
                                  (ordersController.orders[index]['status'] == 'received') ? 'Recibido' :
                                  (ordersController.orders[index]['status'] == 'shipped') ? 'Enviado' :
                                  (ordersController.orders[index]['status'] == 'delivered') ? 'Completado' :
                                  (ordersController.orders[index]['status'] == 'paid') ? 'Completado' :
                                  (ordersController.orders[index]['status'] == 'canceled') ? 'Cancelado' :
                                  (ordersController.orders[index]['status'] == 'refunded') ? 'Cancelado' :
                                  '...'
                                  , 
                                  style: TextStyle(
                                    color: 
                                    (ordersController.orders[index]['status'] == 'created') ? Colors.red[400] :
                                    (ordersController.orders[index]['status'] == 'received') ? Colors.blue[200] :
                                    (ordersController.orders[index]['status'] == 'shipped') ? Colors.amber[400] :
                                    (ordersController.orders[index]['status'] == 'paid') ? Colors.orange[400] :
                                    Colors.red[200]
                                  )),
                              ]),


                              // Expanded(
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Text(
                              //         'Codigo:',
                              //         style: TextStyle(
                              //         color: Colors.black87,
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.bold
                              //       )),
                              //       Text(
                              //         'total:',
                              //         style: TextStyle(
                              //         color: Colors.black87,
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.bold
                              //       )),
                              //     ],
                              //   ),
                              // ),
                              
                              // Container(
                              //   height: 50,
                              //   width: 50,
                              //   // decoration: BoxDecoration(
                              //   //   borderRadius: BorderRadius.circular(25),
                              //   //   image: 
                              //   //   DecorationImage(
                              //   //     fit: BoxFit.cover,
                              //   //     image: NetworkImage(
                              //   //       ordersController.cartProducts[index]['product']['image']
                                      
                              //   //     )
                              //   //   ) 
                              //   // )
                              // ),
                              
                              // Expanded(
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Text(
                              //         // controller.isLoading.value ? '' :
                              //         // controller.cartProducts[index]['product']['title'],
                              //         ordersController.orders[index]['order_code'],
                              //         style: TextStyle(
                              //         color: Colors.black87,
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.bold
                              //         ),
                              //       ),
                              //       SizedBox(height: 6),
                              //       // DropDown button
                              //       Text(
                              //         // categoryController.isloading.value ? '' :
                              //         // 'S./ ${categoryController.categoryDataDetail[index]['price'].toString()}',
                              //         // 'S./ ${controller.cartProducts[index]['product']['price'].toString()}',
                              //         ordersController.orders[index]['total'].toString(),
                              //         style: TextStyle(
                              //           color: Colors.red,
                              //           fontSize: 15,
                              //           fontWeight: FontWeight.bold
                              //         ),
                              //       ),
                              //     ],
                              //   )
                              // ),
                              
                              // Expanded(
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Text(
                              //         'Estado',
                              //         style: TextStyle(
                              //         color: Colors.black87,
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.bold
                              //       )),
                              //       Obx(() {
                              //     return Text(
                              //       (ordersController.orders[index]['status'] == 'created') ? 'Creado' :
                              //       (ordersController.orders[index]['status'] == 'received') ? 'Recibido' :
                              //       (ordersController.orders[index]['status'] == 'shipped') ? 'Enviado' :
                              //       (ordersController.orders[index]['status'] == 'delivered') ? 'Entregado' :
                              //       (ordersController.orders[index]['status'] == 'paid') ? 'Completado' :
                              //       (ordersController.orders[index]['status'] == 'refunded') ? 'Reembolzado' :
                              //       (ordersController.orders[index]['status'] == 'canceled') ? 'Cancelado' : '...'
                              //       );
                              //   }),

                              //   Text(

                              //        '${ DateFormat('yyyy-MM-dd | kk:mm').format(DateTime.parse(ordersController.orders[index]['timestamp']))}',
                              //         style: TextStyle(
                              //         color: Colors.black87,
                              //         fontSize: 8,
                              //         fontWeight: FontWeight.bold
                              //       )),
                              //     ],
                              //   ),
                              // ),
                              
                      
                              
                      
                              // SizedBox(width: 15),
                              // IconButton(
                              //   color: Color(0xffEB0F1C),
                              //   onPressed: (){
                                  
                              //   },
                              //   icon: Icon(
                              //     Icons.delete_outline,
                              //     color: Color(0xffEB0F1C),
                              //   )
                              // )
                      
                            ],
                      
                          )
                        ),
                      );
                    }
                  ),
                );
              }),

            ]
          ),
        )
      ),
    );
  }
}

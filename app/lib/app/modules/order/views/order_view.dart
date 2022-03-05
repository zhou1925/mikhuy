import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: AppBar(
        title: Text('Detalles', style: TextStyle(color: Colors.black)),
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
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Detalles',
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

              SizedBox(height:10),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  height: 70,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black12)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red
                        ),
                        child: Icon(
                            Icons.pin_drop_outlined,
                            color: Colors.white
                          ),
                      ),
                      SizedBox(width: 10),
                      Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () {
                            if(controller.isLoading.value) {
                              return Text('');
                            }
                            return
                            Text(
                              controller.order[0]['address_line_1'].toString().length < 30 ?
                              controller.order[0]['address_line_1'].toString() :
                              controller.order[0]['address_line_1'].toString().substring(0, 30), 
                              style: TextStyle(color: Colors.red[400])
                            );
                          } 
                          
                        ),
                        Obx(
                          () {
                            if(controller.isLoading.value) {
                              return Text('');
                            }

                            return
                            Text('${controller.order[0]['name']}', style: TextStyle(color: Colors.grey[400]));
                          } 
                        ),
                        Obx(
                          () {
                            if(controller.isLoading.value) {
                              return Text('');
                            }

                            return
                            Text('+51${controller.order[0]['user']['phone']}', style: TextStyle(color: Colors.red[200]));
                          } 
                        ),
                        ]
                      ),

                    ]
                  ),
                )
              ),

              SizedBox(height:10),

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
                  height: 200,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.cartProducts.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 200,
                        width: 150,
                        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        
                        child: Column(
                          children: [
                            SizedBox(height:10),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color(0xfff4f4f4),
                                image: 
                                DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    // "http://192.168.1.69:8000${controller.cartProducts[index]['product']['image']}"
                                    "${controller.cartProducts[index]['product']['image']}"
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
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  // DropDown button
                                  Text(
                                    // categoryController.isloading.value ? '' :
                                    // 'S./ ${categoryController.categoryDataDetail[index]['price'].toString()}',
                                    // 'S./ ${controller.cartProducts[index]['product']['price'].toString()}',
                                    'x${controller.order[0]['cart']['products'][index]['quantity'].toString()}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
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
                                      fontSize: 15,
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Estado de la Orden',
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

              // 1-created, 2-received, 3-shipped, 4-delivered, 5-paid, 6-refunded, 7-canceled

              // Obx(
              //   () {
              //   return 
              //     Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: Text('${controller.order[0]['status'].toString()}'),
              //   );
              // }  
              // ),
              

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Theme(
                  data: ThemeData(   
                    primarySwatch: Colors.red,
                    colorScheme: ColorScheme.light(
                    primary: Colors.red
                  )
                  ),
                  child: 
                  Obx(
                    () {
                      if(controller.isLoading()) {
                        return Container();
                      }

                      if(controller.order[0]['status'] == 'canceled' || controller.order[0]['status'] == 'refunded') {
                        return Container(width: 200, height: 100,child: Text('Tu orden ha sido cancelada'),);
                      }
                                            
                  return
                  Stepper(
                    type: StepperType.vertical,
                    currentStep: controller.getOrderStatus(),
                    controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                        return Row(
                          children: <Widget>[
                          ],
                        );
                    },
                    steps: [

                        // 1-created
                        Step(
                          title: Text('Orden Creada', style: TextStyle(fontWeight: FontWeight.bold)), 
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Tu orden ha sido creada. Si te equivocaste en algo puedes cancelar la orden antes de que preparemos la orden.'),
                              GestureDetector(
                                onTap: () {
                                  var order_id =  controller.order[0]['id'].toString();
                                  controller.cancelOrder(order_id);
                                  Get.offAllNamed('/home');
                                },
                                child: Container(
                                  width: 150,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)

                                  ),
                                  child: Center(child: Text('Cancelar Orden', style: TextStyle(color:Colors.white))),
                                ),
                              ),
                            ],
                          ),
                          state: controller.order[0]['status'] == 'created' ? StepState.complete : StepState.disabled,
                          isActive:
                            (controller.order[0]['status'] == 'created' || 
                            controller.order[0]['status'] == 'received' ||
                            controller.order[0]['status'] == 'shipped' ||
                            controller.order[0]['status'] == 'delivered' ||
                            controller.order[0]['status'] == 'paid') ? true : false
                        ),
                        // 2-received
                        Step(
                          title: Text('Orden Aceptada', style: TextStyle(fontWeight: FontWeight.bold)), 
                          content: Text('Recibimos tu orden. Ahora lo estamos preparando.'),
                          state: controller.order[0]['status'] == 'received' ? StepState.complete : StepState.disabled,
                          isActive:
                            (controller.order[0]['status'] == 'received' ||
                            controller.order[0]['status'] == 'shipped' ||
                            controller.order[0]['status'] == 'delivered' ||
                            controller.order[0]['status'] == 'paid') ? true : false
                        ),
                        // 3-
                        Step(
                          title: Text('Orden Enviada', style: TextStyle(fontWeight: FontWeight.bold)), 
                          content: RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                              children: [
                                TextSpan(text: 'Tu orden ha sido enviada a la direccion: '),
                                TextSpan(text: '${controller.order[0]['address_line_1']} ', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: 'cuando estemos cerca llamaremos a este numero: '),
                                TextSpan(text: '${controller.order[0]['user']['phone']} . ', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: 'El tiempo de entrega puede variar. Gracias por tu paciencia :)', style: TextStyle(fontSize: 12, color: Colors.red))
                              ]
                            )
                          ),
                          
                          state: controller.order[0]['status'] == 'shipped' ? StepState.complete : StepState.disabled,
                          isActive: 
                            (controller.order[0]['status'] == 'shipped' ||
                            controller.order[0]['status'] == 'delivered' ||
                            controller.order[0]['status'] == 'paid') ? true : false
                        ),
                        Step(
                          title: Text('Pedido Entregado', style: TextStyle(fontWeight: FontWeight.bold)), 
                          content: Text('Tu orden ha sido entregada satisfactoriamente.'),
                          state: controller.order[0]['status'] == 'delivered' ? StepState.complete : StepState.disabled,
                          isActive: 
                            (controller.order[0]['status'] == 'delivered' ||
                            controller.order[0]['status'] == 'paid') ? true : false
                        ),
                        Step(
                          title: Text('Pedido Completado', style: TextStyle(fontWeight: FontWeight.bold)), 
                          content: Text('Tu orden se ha completado satisfactoriamente, gracias por tu preferencia.'),
                          state: controller.order[0]['status'] == 'paid' ? StepState.complete : StepState.disabled,
                          isActive: controller.order[0]['status'] == 'paid' ? true : false
                        ),
                      
                    ]
                  );
                 }
                )
                ),
              ),

            ]
          ),
        )
      ),
    );
  }
}




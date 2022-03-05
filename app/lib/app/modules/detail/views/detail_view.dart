// import 'package:app/app/constants/constants.dart';
import 'package:app/app/global/widgets/alert_dialogs.dart';
import 'package:app/app/modules/cart/controllers/cart_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  final CartController cartController = Get.put(CartController());
  final box = GetStorage('mikhuy');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff4f4f4),
      // backgroundColor: Color(0xffFD1E2D),
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Descripcion', style: TextStyle(color: Colors.black87)),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: 
          Obx(
          () {
            if(controller.isloading.value) {
              return Center(child: CircularProgressIndicator());
            }
            return
          
          Container(
            color: Colors.white,
            width: Get.width,
            // height: Get.height,
            child: Column(
              children: [
                Obx(() {
                  if(controller.isloading.value == true) {
                    return Center(child: Text(''));
                  }
                return
                Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        ],
                        // image: DecorationImage(
                        //   image: NetworkImage(controller.product[0]['image']),
                        //   fit: BoxFit.fill
                        // ),
                      ),
                      height: 200,
                      width: 200,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image.network(controller.product[0]['image']),
                      ),

                      // child: CircleAvatar(
                      //   backgroundImage: 
                        
                      //   backgroundColor: Colors.transparent,
                      //   radius: 110,
                        
                      // ),
                      
                    ),

                    // Card(
                    //   elevation: 10,
                    //   child: ClipOval(
                    //     child: Image.network(
                    //       controller.product[0]['image'],
                    //       fit: BoxFit.fill,
                    //     )
                    //   ),
                    // ),
                    
                      // Container(
                      // decoration: BoxDecoration(                        
                      // image: DecorationImage(
                      //   image: NetworkImage(controller.product[0]['image']
                      // ),
                      // fit: BoxFit.cover)),
                      // height: 200.0,
                      // width: 200.0
                      // ),
                    SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(controller.product[0]['title'],
                            style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold)),
                      ),

                      // description
                      SizedBox(height: 10.0),

                      Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        '${controller.product[0]['description']}',
                        style: TextStyle(fontSize: 16, color: Color(0xff7A7A7A)),
                      ),
                      ),

                      SizedBox(height: 10),

                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom:5.0),
                        child: Container(
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      height: 50.0,
                      child: Center(
                        child: Text(
                          controller.isloading.value ? '' :
                          'S./ ${controller.product[0]['price'].toString()}',
                          style: TextStyle(
                            color: Colors.white,
                          )
                        ),
                      ),
                      ),
                      ),

                      // Agregar al carrito
                      InkWell(
                        onTap: () async {
                          var productId = controller.product[0]['id'].toString();
                          var productQuantity = "1";
                          String token = box.read('token');
                          controller.cartIsLoading.value = true;
                          var response = await http.post(
                            'https://www.mikhuy.xyz/cart/',
                            body:{
                              'id': productId,
                              'quantity': productQuantity
                            },
                            headers: {
                              "Authorization": 'Token ' + token,
                              
                              "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
                            }
                          );
                          if (response != null) {
                            show_add_cart_dialog(controller.product[0]['title']);
                          }
                          controller.cartIsLoading.value = false;
                          // cartController.addItemToCart(productId, productQuantity);
                          // Get.snackbar(
                          //   '${controller.product[0]['title']}',
                          //   'Fue agregado a tu carrito',
                          //   icon: Icon(Icons.notifications_outlined, color: Colors.white),
                          //   snackPosition: SnackPosition.TOP,
                          //   backgroundColor: Color(0xffFD1E2D),
                          //   borderRadius: 20,
                          //   margin: EdgeInsets.all(15),
                          //   colorText: Colors.white,
                          //   duration: Duration(seconds: 3),
                          //   isDismissible: true,
                          //   dismissDirection: SnackDismissDirection.HORIZONTAL,
                          //   forwardAnimationCurve: Curves.easeOutBack,
                          // );
                        },
                        child: Visibility(
                          visible: !controller.cartIsLoading.value,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom:5.0),
                            child: Container(
                          decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(10),
                            color: Colors.red,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          height: 50.0,
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/add_cart.svg',
                                  color: Colors.white,
                                  width: 20,
                                  height: 20
                                ),
                                SizedBox(width: 5),
                                Text(
                                  controller.isloading.value ? '' :
                                  'Agregar al carrito',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )
                                ),
                              ],
                            ),
                          ),
                          ),
                          ),
                        ),
                      ),
                      
                        Visibility(
                          visible: controller.cartIsLoading.value,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom:5.0),
                            child: Center(
                              child: CircularProgressIndicator()
                            ),
                          ),
                        ),


                        SizedBox(height: 10.0),
                        // similares
                        controller.relatedProducts.isEmpty ? Text('') :
                        Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Similares',
                            style: TextStyle(
                              // fontWeight: FontWeight.w600,
                              color: Color(0xff110001),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        ),
                        SizedBox(height: 10.0),
                        controller.relatedProducts.isEmpty ?
                        Container() :
                        Container (
                        height: 100.0,
                        child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.relatedProducts.length,
                        itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          var slug = controller.relatedProducts[index]['slug'].toString();
                          var productId = controller.relatedProducts[index]['id'].toString();
                          controller.loadProduct(slug);
                          controller.loadRelatedProducts(productId);
                          Get.offAndToNamed(Routes.DETAIL);
                        },
                        child: Container(
                          height: 90,
                          width: 250,
                          margin: EdgeInsets.only(left: 20),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Color(0xffFFECED),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child:
                          Row(
                            children: [
                      
                              Container(
                                height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      image: 
                                      DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          controller.relatedProducts[index]['image']
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
                                      controller.relatedProducts[index]['title'].toString().length < 20 ?
                                      controller.relatedProducts[index]['title']
                                      : '${controller.relatedProducts[index]['title'].toString().substring(0, 16)}...',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      controller.isloading.value ? '' :
                                      'S./ ${controller.relatedProducts[index]['price'].toString()}',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ],
                                )
                              ),
                      
                            ],
                          )
                        ),
                      );
                        }
                      ),
                      ),
                      SizedBox(height: 10.0)
                    
                  ],
                );
                }),
              ]
            ),
          );
          }
        )
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.red[700],
      //   onPressed: () {
          // var productId = controller.product[0]['id'];
          // var productQuantity = 1;
          // cartController.addItemToCart(productId, productQuantity);
          // Get.snackbar(
          //   '${controller.product[0]['title']}',
          //   'Fue agregado a tu carrito',
          //   icon: Icon(Icons.notifications_outlined, color: Colors.white),
          //   snackPosition: SnackPosition.TOP,
          //   backgroundColor: Color(0xffFD1E2D),
          //   borderRadius: 20,
          //   margin: EdgeInsets.all(15),
          //   colorText: Colors.white,
          //   duration: Duration(seconds: 3),
          //   isDismissible: true,
          //   dismissDirection: SnackDismissDirection.HORIZONTAL,
          //   forwardAnimationCurve: Curves.easeOutBack,
          // );
      //   },
      //   child: Container(
      //     child: CircleAvatar(
      //       backgroundColor: Color(0xffFD1E2D),
      //       child: SvgPicture.asset(
      //         'assets/icons/add_cart.svg',
      //         width: 32,
      //         height: 32,
      //         color: Colors.white,
      //       ),
      //     )
      //   ),
      //   elevation: 8,
        
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}


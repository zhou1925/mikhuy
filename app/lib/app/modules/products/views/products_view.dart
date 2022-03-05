import 'package:app/app/modules/detail/controllers/detail_controller.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {

  final HomeController homeController = Get.put(HomeController());
  final DetailController detailController = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: AppBar(
          title: Text('Nuestros Productos', style: TextStyle(color: Colors.black87),),
          elevation: 0,
          backgroundColor: Colors.transparent,
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

          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //     child: IconButton(
          //       onPressed: () {
          //         Get.toNamed(Routes.CART);
          //       },
          //       icon: Icon(
          //         Icons.shopping_cart_outlined,
          //         color: Colors.black87,
          //       )
          //     ),
          //   )
          // ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: GridView.builder(
            itemCount: homeController.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(4),
                child: Card(
                  elevation: 8,
                  shadowColor: Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: 
                    Obx(() {
                    // here
                    return
                    GestureDetector(
                      onTap: () {
                        var slug = homeController.products[index]['slug'];
                        var productId = homeController.products[index]['id'].toString();
                        detailController.loadProduct(slug);
                        detailController.loadRelatedProducts(productId);
                        Get.toNamed(Routes.DETAIL);
                      },
                      child: Column( 
                        children: [
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.center,
                            width: 85,
                            height: 85,
                            padding: EdgeInsets.only(left: 10, bottom: 10),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  homeController.products[index]['image']
                                )
                              )
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  homeController.products[index]['title'].toString().length < 20 ?
                                  homeController.products[index]['title']
                                  : '${homeController.products[index]['title'].toString().substring(0, 16)}...'
                                ),
                                Text(
                                  'S./ ${homeController.products[index]['price']}',
                                  style: TextStyle(
                                    color: Color(0xffEB0F1C) 
                                  ),
                                ),
                    
                              ]
                            ),
                          )
                        ]
                      ),
                    );
                    })

                  )
                ),
              );
            }
          ),
        )
      ),
    );
  }
}

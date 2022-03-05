import 'package:app/app/global/widgets/alert_dialogs.dart';
import 'package:app/app/modules/cart/controllers/cart_controller.dart';
import 'package:app/app/modules/detail/controllers/detail_controller.dart';
import 'package:app/app/modules/home/controllers/category_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'package:http/http.dart' as http;

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final HomeController homeController = Get.put(HomeController());
  final DetailController detailController = Get.put(DetailController());
  final CategoryController categoryController = Get.put(CategoryController());
  final CartController cartController = Get.put(CartController());

  final box = GetStorage('mikhuy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //divider
              SizedBox(height: 10),
              // app bar
              Appbar(),
              // divider
              SizedBox(height: 10),
              // searchbar
              // SearchBar(),
              // SearchBar2(),
              
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Autocomplete(
                  onSelected: (selection) {
                    // print(selection);
                  },
                  displayStringForOption: (option) => option,
                  fieldViewBuilder: (
                      BuildContext context,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      Function onSubmit
                    ) {
                      return TextField(
                        controller: fieldTextEditingController,
                        focusNode: fieldFocusNode,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'buscar por nombre',
                          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none
                            )
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 30,
                          )
                        )
                      );
                  },

                  optionsViewBuilder: (BuildContext context, 
                    Function onSelected,
                    Iterable productOptions ) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          child: Container(
                            // width: 350,
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              
                            ),
                            child: ListView.builder(
                              itemCount: productOptions.length,
                              itemBuilder: (context, index) {
                                var selectItem = productOptions.elementAt(index);
                                String slug = selectItem.replaceAll(RegExp(' +'), '-');
                                // when the user click the item
                                return InkWell(
                                  onTap: () {
                                    // print(index);
                                    // print(slug);
                                    // clear search bar
                                    // var slug = homeController.products[index]['slug'];
                                    // var productId = homeController.products[index]['id'].toString();
                                    
                                   
                                    var productId = categoryController.categoryDataDetail[index]['id'].toString();

                                    detailController.loadProduct(slug.toLowerCase());
                                    detailController.loadRelatedProducts(productId);
                                    Get.toNamed(Routes.DETAIL);
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    return onSelected('');
                                  },
                                  child: ListTile(
                                    // leading: Image.network(
                                    //   homeController.products[index]['image'],
                                    //   width: 100,
                                    //   height: 100
                                    // ),
                                    title: Text(selectItem),
                                  ),
                                );
                              }
                            ),
                          )
                        ),
                      );
                    },
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return List.empty();
                    }
                  return homeController.productsName
                  .where((product) => product.toLowerCase()
                    .startsWith(textEditingValue.text.toLowerCase())
                  )
                  .toList();
                  },
                ),
              ),
              
              //divider
              SizedBox(height: 10),
              //Recomended text
              RecomendedText(),
              //divider
              SizedBox(height: 10),
              
              Obx(() {
                if(homeController.isloading == true) {
                  return Center(
                    child: Lottie.asset(
                      'assets/icons/burger_loader.json',
                      
                      width: 100,
                      height: 100,
                    ),
                  );
                }
                return Container(
                  height: 320,
                  child: PageView.builder(
                    itemCount: homeController.products.length,
                    controller: PageController(viewportFraction: 0.8),
                    onPageChanged: (int index) => homeController.choiceDishIndex(index),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Obx(
                            () =>
                          
                          Positioned(
                            bottom: 0,
                            child: Transform.scale(
                              scale: index == homeController.indexDish.value ? 1 : 0.8,
                              child: //Card ocntinaer background 
                              Container(
                                height: 150,
                                width: 270,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: homeController.indexDish.value == index ? Color(0xffF00314) : Colors.white
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          homeController.products[index]['title'].toString().length < 20 ?
                                          homeController.products[index]['title'] 
                                          : '${homeController.products[index]['title'].toString().substring(0, 20)}...' ,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: index == homeController.indexDish.value ? Colors.white : Color(0xff281714)
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'S./ ${homeController.products[index]['price']}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: index == homeController.indexDish.value ? Colors.white : Colors.red[500]
                                          ),
                                        ),
                                      ],
                                    ),

                                    // InkWell(
                                    //   onTap: (){
                                    //     var productId = homeController.products[index]['id'];
                                    //     var productQuantity = 1;
                                    //     cartController.addItemToCart(productId, productQuantity);
                                    //     Get.snackbar(
                                    //       '${homeController.products[index]['title']}',
                                    //       'Fue agregado a tu carrito',
                                    //       icon: Icon(Icons.notification_important_outlined, color: Colors.white),
                                    //       snackPosition: SnackPosition.TOP,
                                    //       backgroundColor: Colors.deepPurpleAccent,
                                    //       borderRadius: 20,
                                    //       margin: EdgeInsets.all(15),
                                    //       colorText: Colors.white,
                                    //       duration: Duration(seconds: 3),
                                    //       isDismissible: true,
                                    //       dismissDirection: SnackDismissDirection.HORIZONTAL,
                                    //       forwardAnimationCurve: Curves.easeOutBack,
                                    //     );
                                    //   },
                                    //   child: CircleAvatar(
                                    //     radius: index == homeController.indexDish.value ? 28 : 26,
                                    //     backgroundColor: Colors.white,
                                    //     child: SvgPicture.asset(
                                    //       'assets/icons/add_cart.svg',
                                    //       width: index == homeController.indexDish.value ? 32 : 28,
                                    //       height: index == homeController.indexDish.value ? 32 : 28,
                                    //       color: Colors.red,
                                    //     )
                                    //   ),
                                    // )
                                  ],
                                )
                              ),
                            )
                          ),
                        ),
                          
                        Positioned(
                          top: -10,
                          left: -15,
                          child: CircleAvatar(
                            radius: 150,
                            backgroundColor: Colors.transparent,
                            child: GestureDetector(
                              onTap: () {
                                var slug = homeController.products[index]['slug'].toString();
                                var productId = homeController.products[index]['id'].toString();
                                detailController.loadProduct(slug);
                                detailController.loadRelatedProducts(productId);
                                Get.toNamed(Routes.DETAIL);
                              },
                              child: Container(
                              decoration: BoxDecoration(
                                // color: Colors.blue,
                                // image: DecorationImage(
                                  // image: NetworkImage(
                                  //   homeController.products[index]['image']
                                  // )
                                // )
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(homeController.products[index]['image'])
                                )
                              ), 
                              ),
                            )
                          )
                        )
                        
                        ] 
                        
                      );
                    }
                  ),
                );


              }),
              
        
              //Divider
              SizedBox(height: 20),
        
              // tab controller categories name
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: 
                  Obx(() {
                  // if (categoryController.isloading.value == true) {
                  //   return Text('');
                  // }
                  return DefaultTabController(
                  length: categoryController.categories.length,
                  child: TabBar(
                    onTap: (int index){
                      categoryController.loadData((index + 1).toString());
                      // print(index);
                    },
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.red[700],
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    indicator: MD2Indicator(
                      indicatorHeight: 5,
                      indicatorColor: Colors.red[700],
                      indicatorSize: MD2IndicatorSize.tiny,
                    ),
                    tabs: 
                      List.generate(
                        categoryController.categories.length,
                        (index) => new Tab(text: categoryController.categories[index]['title'])
                      ),

                      // Tab(text: categoryController.categories[0]['title']),
                  )
                );
                })
              ),
        
              //Divider
              SizedBox(height: 20),
        
              // fav container
              Obx(() {
                if(categoryController.isloading.value == true) {
                  return Text('');
                }
                if(categoryController.categoryData.isEmpty) {
                  return Text('');
                }

                return 
                Container(
                    height: 90,
                    child: 
                    // categoryController.categoryData.isEmpty ? Center(child: Text('no hay productos')) :
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: categoryController.categoryDataDetail.length,
                      itemBuilder: (context, index) {
                        return Shimmer(
                          color: Colors.white,
                          duration: Duration(seconds: 3),
                          direction: ShimmerDirection.fromLTRB(),
                          interval: Duration(seconds: 3),
                          enabled: categoryController.isloading == true,
                          child: 
                          Container(
                            height: 90,
                            width: 300,
                            margin: EdgeInsets.only(left: 20),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)
                            ),
                            child: 
                            Row(
                              children: [
                                categoryController.isloading.value ? Container(width: 70, height: 70) :
                                
                                GestureDetector(
                                  onTap: () {
                                    var slug = categoryController.categoryDataDetail[index]['slug'].toString();
                                    var productId = categoryController.categoryDataDetail[index]['id'].toString();
                                    detailController.loadProduct(slug);
                                    detailController.loadRelatedProducts(productId);
                                    Get.toNamed(Routes.DETAIL);
                                  },
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      image: 
                                      DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(categoryController.categoryDataDetail[index]['image'])
                                        // image: NetworkImage(
                                        //   categoryController.categoryDataDetail[index]['image']
                                          
                                        // )
                                      ) 
                                    )
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        categoryController.isloading.value ? '' :
                                        categoryController.categoryDataDetail[index]['title'].toString().length < 16 ?
                                        categoryController.categoryDataDetail[index]['title'] : 
                                        '${categoryController.categoryDataDetail[index]['title'].toString().substring(0,16)}...'
                                        ,
                                        style: TextStyle(
                                        color: Color(0xff281714),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        categoryController.isloading.value ? '' :
                                        'S./ ${categoryController.categoryDataDetail[index]['price'].toString()}',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ],
                                  )
                                ),
                        
                                InkWell(
                                  onTap: () async {
                                    var productId = categoryController.categoryDataDetail[index]['id'].toString();
                                    var productQuantity = "1";
                                    String token = box.read('token');
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
                                      show_add_cart_dialog(categoryController.categoryDataDetail[index]['title']);
                                    }
                                  },
                                  child: categoryController.isloading.value ? Container(width: 24, height: 24) : 
                                  CircleAvatar(
                                    backgroundColor: Color(0xffF00314),
                                    child: SvgPicture.asset(
                                      'assets/icons/add_cart.svg',
                                      width: 24,
                                      height: 24,
                                      color: Colors.white,
                                    )
                                  ),
                                )
                              ]
                            ),
                                        
                          ),
                        );
                      }
                    )
                  );
                
              }),
              
        
            //Divider
              SizedBox(height: 20),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )
        ),
        child: 
          Obx(() {

          return
          DotNavigationBar(
          currentIndex: homeController.selectedTab.value,
          
          selectedItemColor: Color(0xffEB0F1C),
          margin: EdgeInsets.symmetric(horizontal: 20),
          onTap: (index) {
            homeController.choiceTabIndex(index);
          },

          items: [
            DotNavigationBarItem(
              icon: homeController.selectedTab.value == 0 ? 
                Icon(Icons.home,) :
                Icon(Icons.home_outlined)
            ),
            // DotNavigationBarItem(
            //   icon:  homeController.selectedTab.value == 1 ? 
            //     Icon(Icons.pin_drop) :
            //     Icon(Icons.pin_drop_outlined)
            // ),
            DotNavigationBarItem(
              icon:  homeController.selectedTab.value == 1 ?
                Icon(Icons.shopping_cart) :
                Icon(Icons.shopping_cart_outlined)
            ),
            DotNavigationBarItem(
              icon:  homeController.selectedTab.value == 2 ?
                Icon(Icons.person) :
                Icon(Icons.person_outlined)
            ),
          ],
        );
        })
      ),
    );
  }
}


class RecomendedText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recomendado',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.red[400],
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          ),

          Row(  
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed('/products');
                },
                child: Text(
                  'Ver Todo',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red[200]
                  ),
                ),
              ),

              Icon(
                Icons.keyboard_arrow_right,
                color: Colors.red[300],
              )
            ],
          )


        ],
      ),
    );
  }
}



class SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Sumaq especial',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none
            )
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
            size: 30,
          )
        )
      ),
    );
  }
}

class Appbar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          InkWell(
            onTap: () {},
            child: Container(
              width: 20,
              height: 20,
                // child: SvgPicture.asset(
                //   'assets/icons/menu.svg',
                //   fit: BoxFit.scaleDown,
                //   color: Color(0xff281714),
                // ),
            ),
          ),
          Text(
            'Mikhuy',
            style: TextStyle(
              fontSize: 20,
              // fontWeight: FontWeight.bold,
              color: Color(0xff281714)
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed('/cart');
            },
            child: Container(
              width: 40,
              height: 40,
              // child: Icon(
              //   Icons.shopping_cart_outlined,
              //   color: Color(0xff281714),
              // )
            ),
          ),
          
        ],
      ),
    );
  }
}





// List continentOptions = ['Africa', 'Aceania', 'Aurger 2', 'Aurger 3', 'Avena', 'Acido2', 'Apera'];

// class SearchBar2 extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child: Autocomplete(
//         onSelected: (selection) {
//           print(selection);
//         },
//         displayStringForOption: (option) => option,
//         fieldViewBuilder: (
//             BuildContext context,
//             TextEditingController fieldTextEditingController,
//             FocusNode fieldFocusNode,
//             Function onSubmit
//           ) {
//             return TextField(
//               controller: fieldTextEditingController,
//               focusNode: fieldFocusNode,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 hintText: 'Sumaq especial',
//                 hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide(
//                     width: 0,
//                     style: BorderStyle.none
//                   )
//                 ),
//                 prefixIcon: Icon(
//                   Icons.search,
//                   color: Colors.grey,
//                   size: 30,
//                 )
//               )
//             );
//         },

//         optionsViewBuilder: (BuildContext context, 
//           Function onSelected,
//           Iterable continentOptions ) {
//             return Align(
//               alignment: Alignment.topLeft,
//               child: Material(
//                 child: Container(
//                   // width: 350,
//                   height: 250,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
                    
//                   ),
//                   child: ListView.builder(
//                     itemCount: continentOptions.length,
//                     itemBuilder: (context, index) {
//                       var item = continentOptions.elementAt(index);
//                       return InkWell(
//                         onTap: () {
//                           print(item);
//                           // clear search bar
//                           return onSelected('');
//                         },
//                         child: ListTile(
//                           leading: Image.network(
//                             'http://192.168.1.69:8000/media/products/10107164/5526108..png',
//                             width: 100,
//                             height: 100
//                           ),
//                           title: Text(item),
//                         ),
//                       );
//                     }
//                   ),
//                 )
//               ),
//             );
//           },
//         optionsBuilder: (TextEditingValue textEditingValue) {
//           if (textEditingValue.text.isEmpty) {
//             return List.empty();
//           }
//         return continentOptions
//         .where((continent) => continent.toLowerCase()
//           .startsWith(textEditingValue.text.toLowerCase())
//         )
//         .toList();
//         },
//       ),
//     );
//   }
// }

//////////////////////////Cotnainer with getvuilber
// Container(
//                 height: 320,
//                 child: 
//                   // homeController.isloading == true ? 
//                   // Center(
//                   //   child: Lottie.asset(
//                   //     'assets/icons/burger_loader.json',
//                   //     width: 100,
//                   //     height: 100,
//                   //   ),
//                   // ) 
//                   // :
//                   GetBuilder<HomeController>(
//                   builder: (_controller) =>
//                   PageView.builder(
//                   // itemCount: recomendedDishes.length,
//                   itemCount: _controller.products.length,
//                   controller: PageController(viewportFraction: 0.8),
//                   onPageChanged: (int index) => _controller.choiceDishIndex(index),
//                   itemBuilder: (context, index) {
//                     // return DishContainer(
//                     //   index: _controller.indexDish.value,
//                     //   // index: 1,
//                     //   i: i
//                     // );
//                     return Stack(
//                     children: [
//                       // Text(index.toString() + _controller.indexDish.toString()),
//                       // PageView
//                       Positioned(
//                         bottom: 0,
//                         child: 
                      
//                         Transform.scale(
//                           scale: index == _controller.indexDish ? 1 : 0.8,
//                           child: Container(
//                             height: 150,
//                             width: 270,
//                             padding: EdgeInsets.all(20),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(40),
//                               // color: index == _controller.indexDish ? Colors.red : Colors.white,
//                               color: index == _controller.indexDish ? Colors.red : Colors.white,
//                             ),

//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       _controller.products[index]['title'],
//                                       // 'name',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w500,
//                                         color: index == _controller.indexDish ? Colors.white : Colors.black
//                                       ),
//                                     ),
//                                     SizedBox(height: 10),
//                                     Text(
//                                       '\$  ${_controller.products[index]['price']}',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w500,
//                                         color: index == _controller.indexDish ? Colors.white : Colors.black
//                                       ),
//                                     ),
//                                   ],
//                                 ),

//                                 //Circle avatar
//                                 InkWell(
//                                   onTap: (){
//                                     print('add item to cart');
//                                   },
//                                   child: CircleAvatar(
//                                     backgroundColor: Colors.white,
//                                     child: SvgPicture.asset(
//                                       'assets/icons/add_cart.svg',
//                                       width: 24,
//                                       height: 24,
//                                       color: Colors.red,
//                                     )
//                                   ),
//                               )
//                               ],
//                             ),
//                           ),
//                         )
//                       ),

//                       // Image
//                       Positioned(
//                         top: -10,
//                         left: -15,
//                         child: CircleAvatar(
//                           radius: 150,
//                           backgroundColor: Colors.transparent,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: NetworkImage(
//                                   _controller.products[index]['image']
//                                 )
//                               )
//                             ), 
//                           )
//                         ),
//                       )
//                     ],
//                   );
//                   },
//                 ),
//                 ) 
//               ),
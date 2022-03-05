import 'package:get/get.dart';

import 'package:app/app/modules/account/bindings/account_binding.dart';
import 'package:app/app/modules/account/views/account_view.dart';
import 'package:app/app/modules/billing/bindings/billing_binding.dart';
import 'package:app/app/modules/billing/views/billing_view.dart';
import 'package:app/app/modules/cart/bindings/cart_binding.dart';
import 'package:app/app/modules/cart/views/cart_view.dart';
import 'package:app/app/modules/detail/bindings/detail_binding.dart';
import 'package:app/app/modules/detail/views/detail_view.dart';
import 'package:app/app/modules/home/bindings/home_binding.dart';
import 'package:app/app/modules/home/views/home_view.dart';
import 'package:app/app/modules/initial/bindings/initial_binding.dart';
import 'package:app/app/modules/initial/views/initial_view.dart';
import 'package:app/app/modules/login/bindings/login_binding.dart';
import 'package:app/app/modules/login/views/login_view.dart';
import 'package:app/app/modules/order/bindings/order_binding.dart';
import 'package:app/app/modules/order/views/order_view.dart';
import 'package:app/app/modules/orders/bindings/orders_binding.dart';
import 'package:app/app/modules/orders/views/orders_view.dart';
import 'package:app/app/modules/products/bindings/products_binding.dart';
import 'package:app/app/modules/products/views/products_view.dart';
import 'package:app/app/modules/profile/bindings/profile_binding.dart';
import 'package:app/app/modules/profile/views/profile_view.dart';
import 'package:app/app/modules/signup/bindings/signup_binding.dart';
import 'package:app/app/modules/signup/views/signup_view.dart';
import 'package:app/app/modules/trucks/bindings/trucks_binding.dart';
import 'package:app/app/modules/trucks/views/trucks_view.dart';
import 'package:app/app/modules/welcome/bindings/welcome_binding.dart';
import 'package:app/app/modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTS,
      page: () => ProductsView(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: _Paths.ORDERS,
      page: () => OrdersView(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.INITIAL,
      page: () => InitialView(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.BILLING,
      page: () => BillingView(),
      binding: BillingBinding(),
    ),
    GetPage(
      name: _Paths.TRUCKS,
      page: () => TrucksView(),
      binding: TrucksBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}

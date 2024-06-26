import 'package:get/get.dart';

import '../modules/categories/bindings/categories_binding.dart';
import '../modules/categories/views/categories_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/offers/bindings/offers_binding.dart';
import '../modules/offers/views/offers_view.dart';
import '../modules/onboarding_screen/bindings/onboarding_screen_binding.dart';
import '../modules/onboarding_screen/views/onboarding_screen_view.dart';
import '../modules/order_status/bindings/order_status_binding.dart';
import '../modules/order_status/views/order_status_view.dart';
import '../modules/pet_profiles/bindings/pet_profiles_binding.dart';
import '../modules/pet_profiles/views/pet_profiles_view.dart';
import '../modules/product_detail/bindings/product_detail_binding.dart';
import '../modules/product_detail/views/product_detail_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/seller_main/bindings/seller_main_binding.dart';
import '../modules/seller_main/views/seller_main_view.dart';
import '../modules/seller_orders/bindings/seller_orders_binding.dart';
import '../modules/seller_orders/views/seller_orders_view.dart';
import '../modules/seller_products/bindings/seller_products_binding.dart';
import '../modules/seller_products/views/seller_products_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/user_cart/bindings/user_cart_binding.dart';
import '../modules/user_cart/views/user_cart_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGN_IN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING_SCREEN,
      page: () => const OnboardingScreenView(),
      binding: OnboardingScreenBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.OFFERS,
      page: () => const OffersView(),
      binding: OffersBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORIES,
      page: () => const CategoriesView(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: _Paths.PET_PROFILES,
      page: () => const PetProfilesView(),
      binding: PetProfilesBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAIL,
      page: () => const ProductDetailView(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: _Paths.USER_CART,
      page: () => const UserCartView(),
      binding: UserCartBinding(),
    ),
    GetPage(
      name: _Paths.SELLER_MAIN,
      page: () => const SellerMainView(),
      binding: SellerMainBinding(),
    ),
    GetPage(
      name: _Paths.SELLER_PRODUCTS,
      page: () => const SellerProductsView(),
      binding: SellerProductsBinding(),
    ),
    GetPage(
      name: _Paths.SELLER_ORDERS,
      page: () => const SellerOrdersView(),
      binding: SellerOrdersBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_STATUS,
      page: () => const OrderStatusView(),
      binding: OrderStatusBinding(),
    ),
  ];
}

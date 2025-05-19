import 'package:flutter/material.dart';
import '../presentation/product_detail_screen/product_detail_screen.dart';
import '../presentation/shopping_cart_screen/shopping_cart_screen.dart';
import '../presentation/product_listing_screen/product_listing_screen.dart';
import '../presentation/checkout_screen/checkout_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String splashScreen = '/splash-screen';
  static const String productDetailScreen = '/product-detail-screen';
  static const String shoppingCartScreen = '/shopping-cart-screen';
  static const String productListingScreen = '/product-listing-screen';
  static const String checkoutScreen = '/checkout-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(), // Using SplashScreen as initial route
    splashScreen: (context) => const SplashScreen(),
    productDetailScreen: (context) => const ProductDetailScreen(),
    shoppingCartScreen: (context) => const ShoppingCartScreen(),
    productListingScreen: (context) => const ProductListingScreen(),
    checkoutScreen: (context) => const CheckoutScreen(),
  };
}

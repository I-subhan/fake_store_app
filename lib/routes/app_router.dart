import 'package:flutter/material.dart';
import '../views/auth/login_screen.dart';
import '../views/cart/cart_screen.dart';
import '../views/home/home_screen.dart';
import '../views/products/product_list_screen.dart';
import '../views/profile/profile_screen.dart';
import '../views/splash/splash_screen.dart';

class AppRouter {
  static Map<String, WidgetBuilder> routes = {
    "/": (_) => LoginScreen(),
    "/products": (_) => HomeScreen(),
    "/cart": (_) => CartScreen(),
    "/profile": (_) => ProfileScreen(),
    "/splash": (_) => SplashScreen(),


  };
}

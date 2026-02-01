import 'package:flutter/material.dart';
import '../../core/utils/token_storage.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    check();
  }

  void check() async {
    final token = await TokenStorage.getToken();

    await Future.delayed(const Duration(seconds: 3));

    if (token != null) {
      Navigator.pushReplacementNamed(context, "/products");
    } else {
      Navigator.pushReplacementNamed(context, "/");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/app_theme.dart';

import 'routes/app_router.dart';

import 'viewmodels/auth_cubit.dart';
import 'viewmodels/product_cubit.dart';
import 'viewmodels/cart_cubit.dart';
import 'viewmodels/profile_cubit.dart';

import 'data/repositories/auth_repository.dart';
import 'data/repositories/product_repository.dart';
import 'data/repositories/cart_repository.dart';
import 'data/repositories/user_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit(AuthRepository())),
        BlocProvider(create: (_) => ProductCubit(ProductRepository())),
        BlocProvider(create: (_) => CartCubit(CartRepository())),
        BlocProvider(create: (_) => ProfileCubit(UserRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,


        initialRoute: "/splash",
        theme: AppTheme.light,

        routes: AppRouter.routes,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../products/product_list_screen.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';
import '../../viewmodels/cart_cubit.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;


  static final List<Widget> _screens = [
    ProductListScreen(),
    const CartScreen(),
    ProfileScreen(),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        elevation: 8,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFF4F46E5).withOpacity(0.1),
        height: 64,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.store_outlined),
            selectedIcon: Icon(Icons.store),
            label: "Shop",
            tooltip: "Browse products",
          ),
          NavigationDestination(
            icon: _buildCartBadge(false),
            selectedIcon: _buildCartBadge(true),
            label: "Cart",
            tooltip: "View cart",
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profile",
            tooltip: "View profile",
          ),
        ],
      ),
    );
  }

  Widget _buildCartBadge(bool isSelected) {
    return BlocBuilder<CartCubit, List<dynamic>>(
      builder: (context, cartItems) {
        final itemCount = cartItems.length;

        return Badge(
          isLabelVisible: itemCount > 0,
          label: Text(
            itemCount > 99 ? '99+' : itemCount.toString(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color(0xFFEF4444),
          textColor: Colors.white,
          child: Icon(
            isSelected ? Icons.shopping_cart : Icons.shopping_cart_outlined,
          ),
        );
      },
    );
  }
}
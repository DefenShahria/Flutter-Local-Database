import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../statemanager/main_bottomnav_Controller.dart';
import 'cartScreen/cartScreen.dart';
import 'homeScreen/homeScreen.dart';


class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {



  final List<Widget> _screen = [
    const MyHomePage(),
    const MyCartPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(
        builder: (controller) {
          return Scaffold(
            body: _screen[controller.currentSelectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.currentSelectedIndex,
              onTap: controller.changeScreen,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              elevation: 4,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart'),

              ],),
          );
        }
    );
  }
}
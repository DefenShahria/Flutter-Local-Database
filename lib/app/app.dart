import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaphy/ui/bottomNavBar.dart';
import 'controllerBinding.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialBinding: ControllerBinder(),
      home: const MainBottomNavScreen(),
    );
  }
}
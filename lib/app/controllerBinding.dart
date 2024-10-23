import 'package:get/get.dart';
import '../statemanager/all_Product_Controller.dart';
import '../statemanager/main_bottomnav_Controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(MainBottomNavController());
    Get.put(ProductController());

  }
}
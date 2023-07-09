import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController {
  final imageSliders = [
    "assets/carousel1.jpg",
    "assets/carousel2.jpg",
    "assets/carousel3.jpg"
  ];
  final activeIndex = 0.obs;

}
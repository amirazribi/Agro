import 'package:carousel_slider/carousel_slider.dart';
import 'package:detection/ui/auth/login_view.dart';
import 'package:detection/ui/doctor/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';
import 'main_drawer.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final homeController = Get.put(HomeController());
  final authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(value: 0, child: Text("Settings")),
                const PopupMenuItem<int>(value: 1, child: Text("Logout"))
              ];
            },
            onSelected: (value) {
              switch (value) {
                case 0:
                  {
                    break;
                  }

                case 1:
                  {
                    authController.signOut();
                    Get.offAll(LoginView());
                    break;
                  }
              }
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CarouselSlider(
            items:
                homeController.imageSliders.map((e) => Image.asset(e , fit: BoxFit.fill,)).toList(),
            options: CarouselOptions(
              autoPlay: true,
              height: double.maxFinite,
              enlargeCenterPage: true,
              viewportFraction: 1,
aspectRatio: 1.2,
              onPageChanged: (index, value)
                  {homeController.activeIndex.value = index ;
                  homeController.update();},

              initialPage: 2,
            ),
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: homeController.imageSliders.map((url) {
                int index = homeController.imageSliders.indexOf(url);
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: homeController.activeIndex.value == index
                        ? Colors.teal
                        : Colors.white,
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

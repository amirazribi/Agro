import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';

class MainDrawer extends StatelessWidget {
  final AuthController authController = AuthController.to;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(authController.firestoreUser.value?.name ?? "" ,style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.w500),),
                Text(authController.firestoreUser.value?.email ?? ""),
              ],
            ),
          ),
          ListTile(
            title: Text('Home'),
            tileColor: Get.currentRoute == '/home' ? Colors.grey[300] : null,
            onTap: () {
              print(Get.currentRoute);

              Get.toNamed('/home');
            },
          ),
          ListTile(
            title: Text('Serres'),
            tileColor: Get.currentRoute == '/serres' ? Colors.grey[300] : null,
            onTap: () {

              Get.toNamed('/serres');
            },
          ),
          ListTile(
            title: const Text('Analyse'),
            tileColor: Get.currentRoute == '/analyse' ? Colors.grey[300] : null,
            onTap: () {

              Get.toNamed('/analyse');
            },
          ),
        ],
      ),
    );
  }}
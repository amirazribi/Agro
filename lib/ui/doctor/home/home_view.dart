import 'package:detection/ui/auth/login_view.dart';
import 'package:detection/ui/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';
import 'main_drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller.firestoreUser.value!.uid == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Scaffold(
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
                      controller.signOut();
                      Get.offAll(LoginView());
                      break;
                    }
                }
              },
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Center(
          child: Column(
            children: const [

            ],
          ),
        ),
      ),
    );
  }
}

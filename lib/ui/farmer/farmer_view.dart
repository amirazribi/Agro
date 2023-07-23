import 'package:detection/ui/auth/controllers/auth_controller.dart';
import 'package:detection/ui/auth/login_view.dart';
import 'package:detection/ui/farmer/arrosage/arrosages_view.dart';
import 'package:detection/ui/farmer/farmer_controller.dart';
import 'package:detection/ui/farmer/orders/farm_orders_view.dart';
import 'package:detection/ui/farmer/serre_farmer_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FarmerView extends StatelessWidget {
  FarmerView({Key? key}) : super(key: key);
  final FarmerController controller = Get.put(FarmerController());
  final AuthController authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Partie Agricultaire"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(value: 0, child: Text("Commandes")),
                const PopupMenuItem<int>(
                    value: 1, child: Text("Se déconnecter"))
              ];
            },
            onSelected: (value) {
              switch (value) {
                case 0:
                  {
                    Get.to(() => FarmOrdersView());
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
      body: controller.obx(
          (data) => ListView.builder(
            padding: const EdgeInsets.all(16),
                itemCount: data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return SerreFarmerItem(
                    serre: data![index],
                    onItemClick: () {
                      Get.to(() => ArrosagesView(), arguments: [
                        {"model": data[index].toJson()}
                      ]);
                    },
                  );
                },
              ),
          onLoading: const Center(child: CircularProgressIndicator()),
          onEmpty: const Text("no data found"),
          onError: (error) => Text(error ?? "unknown error")),
    );
  }
}

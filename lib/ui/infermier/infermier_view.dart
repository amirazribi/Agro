import 'package:detection/ui/auth/controllers/auth_controller.dart';
import 'package:detection/ui/auth/login_view.dart';
import 'package:detection/ui/infermier/rendezvous/rendezvouss_view.dart';
import 'package:detection/ui/infermier/infermier_controller.dart';
import 'package:detection/ui/infermier/orders/inferm_orders_view.dart';
import 'consultation_infermier_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfermierView extends StatelessWidget {
  InfermierView({Key? key}) : super(key: key);
  final InfermierController controller = Get.put(InfermierController());
  final AuthController authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Partie Inférmier"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(value: 0, child: Text("Rendez-vous")),
                const PopupMenuItem<int>(
                    value: 1, child: Text("Se déconnecter"))
              ];
            },
            onSelected: (value) {
              switch (value) {
                case 0:
                  {
                    Get.to(() => InfermOrdersView());
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
                  return ConsultationInfermierItem(
                    consultation: data![index],
                    onItemClick: () {
                      Get.to(() => RendezvoussView(), arguments: [
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

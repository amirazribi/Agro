import 'package:detection/ui/components/consultation_item.dart';
import 'package:detection/ui/doctor/Consultation/consultation_controller.dart';
import 'package:detection/ui/doctor/consultation/add/add_consultation_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/main_drawer.dart';

class ConsultationsView extends StatelessWidget {
  ConsultationsView({Key? key}) : super(key: key);
  final ConsultationController controller = Get.put(ConsultationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultations'),
      ),
      drawer: MainDrawer(),
      // ignore: invalid_use_of_protected_member
      body:Obx(()=>  controller.consultations.value.isEmpty ? Text("no data found")  :  ListView.builder(
        padding: EdgeInsets.all(16),
        // ignore: invalid_use_of_protected_member
        itemCount: controller.consultations.value.length,
        itemBuilder: (BuildContext context, int index) {
          return ConsultationItem(
              // ignore: invalid_use_of_protected_member
              consultation: controller.consultations.value[index],
              onRemoveClicked: controller.removeConsultation);
        },
      ))
     ,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(AddConsultationView());
          }),
    );
  }
}

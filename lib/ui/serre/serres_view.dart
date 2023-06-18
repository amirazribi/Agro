import 'package:detection/ui/components/serre_item.dart';
import 'package:detection/ui/serre/add/add_serre_view.dart';
import 'package:detection/ui/serre/serre_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/main_drawer.dart';

class SerresView extends StatelessWidget {
  SerresView({Key? key}) : super(key: key);
  final SerreController controller = Get.put(SerreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serres'),
      ),
      drawer: MainDrawer(),
      body:Obx(()=>  controller.serres.value.length == 0 ? Text("no data found")  :  ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: controller.serres.value.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return SerreItem(
              serre: controller.serres.value[index],
              onRemoveClicked: controller.removeSerre);
        },
      ))
      /*controller.obx(
          (data) => ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return SerreItem(
                      serre: data![index],
                      onRemoveClicked: controller.removeSerre);
                },
              ),
          onLoading: CircularProgressIndicator(),
          onEmpty: Text("no data found"),
          onError: (error) => Text(error ?? "unknown error"))*/,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(AddSerreView());
          }),
    );
  }
}

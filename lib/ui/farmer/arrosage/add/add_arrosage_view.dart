import 'package:detection/ui/farmer/arrosage/add/add_arrosage_controller.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../utlis/utils.dart';
import '../../../components/primary_button.dart';
import '../../../components/utils.dart';

class AddArrosageView extends StatelessWidget {

  AddArrosageView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  final controller = Get.put(AddArrosageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: controller.model !=null ? const Text("Modifier Arrosage") : const Text("Ajouter Arrosage"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'name',
                initialValue: controller.model?.name,
                onChanged: (val) {
                  // Print the text value write into TextField
                  controller.name = val;
                },
                decoration: const InputDecoration(
                  labelText: 'Nom Arrosage',
                ),
              ),
              verticalSpaceMedium,
              FormBuilderDateTimePicker(
                name: "date",
                initialValue: controller.model?.date !=null ? DateTime.tryParse(controller.model!.date!) : DateTime.now(),
                onChanged: (date) {
                  controller.date = date.toString();
                },
                decoration: InputDecoration(
                  labelText: 'Date Arrosage',
                ),
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                inputType: InputType.date,
              ),
              verticalSpaceMedium,
              FormBuilderField(
                name: "duration",
                initialValue: Utils.parseDuration(controller.model?.duration),
                valueTransformer: (d)=>d,
                onChanged: (duration){
                  controller.duration = Utils.printDuration(duration);
                },
                builder: (FormFieldState<dynamic> field) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Durée",
                      contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                      border: InputBorder.none,
                      errorText: field.errorText,
                    ),
                    child: GestureDetector( onTap: ()async{
                      var resultingDuration = await showDurationPicker(
                        context: context,
                        initialTime: Duration(minutes: 30),
                      );
                      field.didChange( resultingDuration);
                    }, child:  SizedBox(width: double.infinity, child: Text("${ Utils.printDuration(field.value) }"))),
                  );
                },
              ),
              verticalSpaceNormal,
              SizedBox(
                  width: double.infinity,
                  child: controller.model !=null ? PrimaryButton(
                  labelText: "Modifier",
                  onPressed: () async {
                    await controller.updateArrosage();
                    Get.back();
                  })  : PrimaryButton(
                      labelText: "Ajouter",
                      onPressed: () async {
                        await controller.addArrosage();
                        Get.back();
                      }))
            ],
          ),
        ),
      ),
    );
  }

}

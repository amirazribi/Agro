import 'package:detection/ui/components/primary_button.dart';
import 'package:detection/ui/components/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../utlis/constants.dart';
import 'add_consultation_controller.dart';

class AddConsultationView extends StatelessWidget {
  AddConsultationView({Key? key}) : super(key: key);
  final AddConsultationController controller = Get.put(AddConsultationController());
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Ajouter consultation"),centerTitle: true,),
      body: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Center(
            child: SizedBox(
              width: width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormBuilderTextField(
                    name: 'name',
                    onChanged: (val) {
                      controller.name.value =
                          val; // Print the text value write into TextField
                    },
                    decoration: const InputDecoration(
                      labelText: 'Nom et prénom patient',
                    ),
                  ),
                  verticalSpaceMedium,
                  FormBuilderDropdown<String>(
                    name: 'nature',
                    decoration: const InputDecoration(
                      labelText: 'Nature de maladie',
                    ),
                    onChanged: (val) {
                      controller.selectedNature.value = val;
                    },
                    items: Constants.natures
                        .map((nature) => DropdownMenuItem(
                              alignment: AlignmentDirectional.center,
                              value: nature,
                              child: Row(

                                children: [
                                  Image.asset("assets/${nature.toLowerCase()}.jpg" , width: 45,
                                  height:40),
                                  horizontalSpaceMedium,
                                  Text(nature),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                  verticalSpaceMedium,
                  FormBuilderDateTimePicker(
                    name: "date",
                    onChanged: (date) {
                      controller.date.value = date.toString() ;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Date de consultation',),
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                    inputType: InputType.date,

                  ),
                  verticalSpaceMedium,
                  FormBuilderRadioGroup(
                    decoration: InputDecoration(
                        labelText: 'Comment les cellules sont cultivées ?'),
                    name: 'cultivation',
                    onChanged: (value) {
                      if (value == "Organique") {
                        controller.isOrganic.value = true;
                      }else{
                        controller.isOrganic.value = false ;
                      }
                    },
                    options: [
                      'Organique',
                      'Non Organique',
                    ]
                        .map((lang) => FormBuilderFieldOption(value: lang))
                        .toList(growable: false),
                  ),
                  verticalSpaceNormal,
                  SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                          labelText: "Ajouter", onPressed:() {
                        controller.addConsultation();
                        Get.back();
                      }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

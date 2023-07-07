import 'package:detection/ui/components/primary_button.dart';
import 'package:detection/ui/components/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../utlis/constants.dart';
import 'add_serre_controller.dart';

class AddSerreView extends StatelessWidget {
  AddSerreView({Key? key}) : super(key: key);
  final AddSerreController controller = Get.put(AddSerreController());
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Ajouter Serre"),centerTitle: true,),
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
                      labelText: 'Nom serre',
                    ),
                  ),
                  verticalSpaceMedium,
                  FormBuilderDropdown<String>(
                    name: 'nature',
                    decoration: const InputDecoration(
                      labelText: 'Nature plante',
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
                                  Image.asset("assets/$nature.jpg"),
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
                        labelText: 'Date de plantation',),
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
                        controller.addSerre();
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

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../home/main_drawer.dart';

class AnalyseView extends StatelessWidget {
  const AnalyseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Analyser les Symptones d\'anomalie'),

      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24 , horizontal: 8),
        child: Column(
          children: [
            FormBuilderImagePicker(
              name: 'photo',
              maxImages: 1,

            ),
            Text("Questionnaire"),
            FormBuilderCheckboxGroup(
              decoration: InputDecoration(
                labelText: 'Comment les cellules sont cultivées ?'),
              name: 'cultivation',
            //  validator: FormBuilderValidators.required(),
              onChanged: (value) {

              },
              options: [
                'Organique',
                'Non Organique',
              ]
                  .map((lang) => FormBuilderFieldOption(value: lang))
                  .toList(growable: false),)
          ],
        ),
      ),);
  }
}


import 'dart:io';

import 'package:detection/ui/components/primary_button.dart';
import 'package:detection/ui/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import '../home/main_drawer.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl ;


class AnalyseView extends StatelessWidget {
   const AnalyseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    XFileImage?  image ;
    return  Scaffold(
      appBar: AppBar(
        title: Text('Analyser les Symptomes d\'anomalie'),

      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24 , horizontal: 8),
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Flexible(
                    child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("assets/1.jpg")),
                  ),
                  CircleAvatar(
                      radius: 40, backgroundImage: AssetImage("assets/2.jpg")),
                  CircleAvatar(
                      radius: 40, backgroundImage: AssetImage("assets/3.jpg")),
                ],
              ),
            ),
            FormBuilderImagePicker(
              name: 'photo',
              cameraIcon: Icon(Icons.camera_alt),
              placeholderWidget: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rapprochez le plus possible la caméra de votre téléphone vers la feuille attaquée"
                        " pour une bonne prise d'image. Votre photo/image ne doit contenir qu'une seule feuille (et pas toute la plante)."
                        "Elle doit être la plus clair possible.",
                        style: TextStyle(
                            color: Colors.green.withGreen(180),
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                      verticalSpaceTiny,
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            horizontalSpaceSmall,
                            Icon(
                              Icons.camera_alt,
                              color: Colors.green,
                            ),
                            horizontalSpaceTiny,
                            Text("Prendre une photo"),
                          ],
                        ),
                      ),
                    ],
                  )),
              maxImages: 1,
              onChanged: (list){
                image = list?.first ;
              },
            ),
            Text("Questionnaire"),
            FormBuilderRadioGroup(
              decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  labelText: 'Ce qui a été pulvérisé dans le dernier mois ?'),
              name: 'cultivation',
              //  validator: FormBuilderValidators.required(),
              onChanged: (value) {},
              orientation: OptionsOrientation.vertical,
              options: [
                "Insecticides",
                "Fongicides",
                "Herbicides",
                "Rien",
              ]
                  .map((lang) => FormBuilderFieldOption(value: lang))
                  .toList(growable: false),
            ),
            verticalSpaceMedium,
            FormBuilderRadioGroup(
              decoration: const InputDecoration(
                labelText: 'Combien de votre cultures souffre du problème ?',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              name: 'cultivation',
              //  validator: FormBuilderValidators.required(),
              onChanged: (value) {},
              orientation: OptionsOrientation.vertical,
              options: [
                "Peu de plante",
                "De nombreuses plantes",
                "Récolte entier"
              ]
                  .map((lang) => FormBuilderFieldOption(value: lang))
                  .toList(growable: false),
            ),
            verticalSpaceMedium,
            FormBuilderRadioGroup(
              decoration: const InputDecoration(
                labelText:
                    ' Quelle sont les plantes des symptômes d\'exposition ?',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              name: 'cultivation',
              //  validator: FormBuilderValidators.required(),
              onChanged: (value) {},
              orientation: OptionsOrientation.vertical,
              options: [
                "Feuille",
                "Tige",
                "Fruits",
                "Les racines",
              ]
                  .map((lang) => FormBuilderFieldOption(value: lang))
                  .toList(growable: false),
            ),
            verticalSpaceNormal,
          PrimaryButton(
            labelText: "Analyser",
            onPressed: () async {
              // Obtenir l'image sélectionnée depuis le FormBuilderImagePicker



              // Charger l'image et effectuer le prétraitement
              final imageBytes = await image?.file.readAsBytes();
              // Effectuer le prétraitement de l'image ici, par exemple, redimensionnement, normalisation des couleurs, etc.

              // Charger le modèle
              final interpreter = await tfl.Interpreter.fromAsset('assets/model_unquant.tflite');

              // Effectuer l'inférence sur l'image
              var output = List.filled(1*2, 0).reshape([1,2]);
              interpreter.run(imageBytes,output);

              // Analyser le résultat de l'inférence pour déterminer si la plante est infectée ou saine
              // ...

              // Afficher le résultat de l'analyse à l'utilisateur, par exemple, à l'aide d'une boîte de dialogue ou d'un message sur l'écran

              // Fermer l'interpréteur du modèle
              interpreter.close();
            },
          ),
        ],
      ),
      ),);
  }
}


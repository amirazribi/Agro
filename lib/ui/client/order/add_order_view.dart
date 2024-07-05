import 'package:detection/models/order_model.dart';
import 'package:detection/ui/client/order/add_order_controller.dart';
import 'package:detection/ui/components/primary_button.dart';
import 'package:detection/ui/components/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../models/user_model.dart';
import '../../../utlis/constants.dart';
import '../../auth/controllers/auth_controller.dart';

class AddOrderView extends StatelessWidget {
  AddOrderView({Key? key}) : super(key: key);
  final AddOrderController controller = Get.put(AddOrderController());
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter Rendez-vous"),
        centerTitle: true,
      ),
      body: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SizedBox(
              width: width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormBuilderDropdown<String>(
                    name: 'nature',
                    decoration: const InputDecoration(
                      labelText: 'Nature du maladie',
                    ),
                    items: Constants.natures
                        .map((nature) => DropdownMenuItem(
                      value: nature,
                      child: Text(nature),
                    ))
                        .toList(),
                    validator: (nature) =>
                    nature == null ? "Choisir une nature" : null,
                  ),
                  verticalSpaceMedium,
                  //Obx(
                       // () => FormBuilderDropdown<UserModel>(
                      //name: 'medcin',
                     // decoration: const InputDecoration(
                        ////labelText: 'Choisir medcin ',
                      //),
                      //items: controller.users
                          //.map((user) => DropdownMenuItem(
                              //  value: user,
                                //child: Text(user.name),
                              //))
                          //.toList(),
                          //validator: (user) =>
                          //user == null ? "choisir un medcin" : null,
                   // ),
                  //),
                  FormBuilderTextField(
                    name: 'address',
                    decoration: const InputDecoration(
                      labelText: 'Adresse de cabinet',
                    ),
                    validator: (address) =>
                    address == null ? "Ajouter une adresse " : null,
                  ),
                  verticalSpaceMedium,
                  FormBuilderTextField(
                    name: 'paiment',
                    decoration: const InputDecoration(
                      labelText: 'Paiment',
                      suffixText: "Dt",
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                    int.tryParse(value ?? "0") == 0 ? "Ajouter paiment" : null,
                  ),
                  verticalSpaceMedium,
                  verticalSpaceNormal,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PrimaryButton(
                          labelText: "Ajouter",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final UserModel? patient =
                                  _formKey.currentState?.fields["patient"]?.value;
                              await controller.addOrder(OrderModel(
                                  nature: _formKey
                                      .currentState?.fields["nature"]?.value,
                                  address: _formKey
                                      .currentState?.fields["address"]?.value,
                                  date: DateTime.now().toString(),
                                  prix: int.parse(
                                    _formKey.currentState?.fields["paiment"]
                                        ?.value as String,
                                  ),
                                  clientId: FirebaseAuth
                                      .instance.currentUser?.uid,
                                  clientName: AuthController
                                      .to.firestoreUser.value?.name,
                                  infermierId: patient?.uid,
                                  infermierName: patient?.name ?? ""
                              ));
                              Get.back();
                            }
                          }),
                      PrimaryButton(
                        labelText: "Annuler",
                        onPressed: Get.back,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

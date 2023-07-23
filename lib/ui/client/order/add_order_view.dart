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
        title: const Text("Ajouter Commande"),
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
                      labelText: 'Nature du produit',
                    ),
                    items: Constants.natures
                        .map((nature) => DropdownMenuItem(
                              value: nature,
                              child: Text(nature),
                            ))
                        .toList(),
                    validator: (nature) =>
                    nature == null ? "choisir un nature" : null,
                  ),
                  verticalSpaceMedium,
                  Obx(
                    () => FormBuilderDropdown<UserModel>(
                      name: 'farmer',
                      decoration: const InputDecoration(
                        labelText: 'Choisir agricultaire',
                      ),
                      items: controller.users
                          .map((user) => DropdownMenuItem(
                                value: user,
                                child: Text(user.name),
                              ))
                          .toList(),
                      validator: (user) =>
                          user == null ? "choisir un agricultaire" : null,
                    ),
                  ),
                  FormBuilderTextField(
                    name: 'address',
                    decoration: const InputDecoration(
                      labelText: 'Adresse de commande',
                    ),
                    validator: (address) =>
                    address == null ? "ajouter une adresse de commande" : null,
                  ),
                  verticalSpaceMedium,
                  FormBuilderTextField(
                    name: 'quantity',
                    decoration: const InputDecoration(
                      labelText: 'Quantité',
                        suffixText: "Kg"
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) => int.parse(value ?? "0" ,onError: (value) =>0) == 0 ? "ajouter quantité" :null,
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
                              final UserModel farmer = _formKey.currentState?.fields["farmer"]?.value;
                              await controller.addOrder(OrderModel(
                                nature: _formKey
                                    .currentState?.fields["nature"]?.value,
                                address: _formKey
                                    .currentState?.fields["address"]?.value,
                                date: DateTime.now().toString(),
                                quantity: int.parse(
                                    _formKey.currentState?.fields["quantity"]
                                        ?.value as String,
                                    onError: (error) => 0),
                                clientId:
                                    FirebaseAuth.instance.currentUser?.uid,
                                clientName: AuthController.to.firestoreUser.value?.name,
                                farmerId: farmer.uid,
                                farmerName: farmer.name
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

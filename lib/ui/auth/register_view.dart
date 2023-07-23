import 'package:detection/models/enum/user_type.dart';
import 'package:detection/ui/auth/login_view.dart';
import 'package:detection/ui/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utlis/constants.dart';
import '../components/form_input_field_with_icon.dart';
import '../components/label_button.dart';
import '../components/primary_button.dart';
import '../components/validator.dart';
import 'controllers/auth_controller.dart';

class RegisterView extends StatelessWidget {
   RegisterView({Key? key}) : super(key: key);

  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                //  LogoGraphicHeader(),
                  verticalSpacingXLarge,
                  FormInputFieldWithIcon(
                    controller: authController.nameController,
                    iconPrefix: Icons.person,
                    labelText: "Nom & Prénom",
                    validator: Validator().name,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.nameController.text = value!,
                  ),
                  verticalSpaceMedium,
                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: Icons.email,
                    labelText: "Adresse email",
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.emailController.text = value!,
                  ),
                  verticalSpaceMedium,
                  FormInputFieldWithIcon(
                    controller: authController.passwordController,
                    iconPrefix: Icons.lock,
                    labelText: "Mot de passe",
                    validator: Validator().password,
                    obscureText: true,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.passwordController.text = value!,
                    maxLines: 1,
                  ),
                  verticalSpaceMedium,
                  DropdownButtonFormField(
                    value: UserType.doctor,
                      icon: const Icon(Icons.settings_applications_rounded),
                      items: UserType.values.map((e) =>
                      DropdownMenuItem(value: e, child: Text(e.name))).toList(),
                      onChanged: (item) {
                        authController.userType = item!;
                      }),
                  verticalSpaceMedium,
                  PrimaryButton(
                      labelText: "S'inscrire",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          SystemChannels.textInput.invokeMethod(
                              'TextInput.hide'); //to hide the keyboard - if any
                          authController.registerWithEmailAndPassword(context);
                        }
                      }),
                  verticalSpaceMedium,
                  LabelButton(
                    labelText: "Se connecter",
                    onPressed: () => Get.to(LoginView()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

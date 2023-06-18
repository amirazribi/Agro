import 'dart:core';

import 'package:detection/ui/auth/register_view.dart';
import 'package:detection/ui/auth/reset_passsword_view.dart';
import 'package:detection/ui/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/form_input_field_with_icon.dart';
import '../components/label_button.dart';
import '../components/primary_button.dart';
import '../components/validator.dart';
import 'controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

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
                  //   LogoGraphicHeader(),
                  verticalSpacingXLarge,
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
                  PrimaryButton(
                      labelText: "Se connecter",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          authController.signInWithEmailAndPassword(context);
                        }
                      }),
                  verticalSpaceMedium,
                  LabelButton(
                    labelText: "Mot de passe oublié?",
                    onPressed: () => Get.to(ResetPasswordView()),
                  ),
                  LabelButton(
                    labelText: "Créer nouveau compte",
                    onPressed: () => Get.to(RegisterView()),
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

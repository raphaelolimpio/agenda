import 'package:agenda/DS/components/input_Text/input_text_view_model.dart';
import 'package:flutter/material.dart';

class LoginPageViewModel {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late InputTextViewModel emailViewModel;
  late InputTextViewModel passwordViewModel;

  LoginPageViewModel() {
    emailViewModel = InputTextViewModel(
      controller: _emailController,
      validator: (value) => value!.isEmpty ? 'Email is required' : null,
      size: InputTextSize.large,
      password: false,
      hintText: 'Email',
      keyboardType: TextInputType.emailAddress,
      obscureText: false,
      isEnabled: true,
    );

    passwordViewModel = InputTextViewModel(
      controller: _passwordController,
      validator: (value) => value!.isEmpty ? 'Password is required' : null,
      size: InputTextSize.large,
      password: true,
      hintText: 'Password',
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      isEnabled: true,
    );
  }

  void login() {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      print('Email ou senha vazios');
      return;
    }
    print('Tentando logar com $email e $password');
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  void OnLinktTap(BuildContext context) {
    print("clicado");
  }
}

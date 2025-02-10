import 'package:agenda/DS/components/Input_Normal_Text/Input_Normal_text_view_model.dart';
import 'package:agenda/DS/components/input_Text/input_text_view_model.dart';
import 'package:flutter/material.dart';

class CadastroPageViewModel {
  final TextEditingController _nameResponsaveController =
      TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late InputNormalTextViewModel nameResponsavelViewModel;
  late InputNormalTextViewModel nomeViewModel;
  late InputNormalTextViewModel telefoneViewModel;
  late InputTextViewModel emailViewModel;
  late InputTextViewModel passwordViewModel;

  CadastroPageViewModel() {
    nameResponsavelViewModel = InputNormalTextViewModel(
      size: InputNormalTextSize.large,
      hintText: 'Nome do Responsável',
      keyboardType: TextInputType.name,
      controller: _nameResponsaveController,
    );

    nomeViewModel = InputNormalTextViewModel(
      size: InputNormalTextSize.large,
      hintText: 'Nome',
      controller: _nomeController,
      keyboardType: TextInputType.name,
    );

    telefoneViewModel = InputNormalTextViewModel(
      size: InputNormalTextSize.large,
      hintText: 'Telefone',
      controller: _telefoneController,
      keyboardType: TextInputType.phone,
      inputType: InputTextType.phone,
    );

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
}

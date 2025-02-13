import 'dart:math';

import 'package:agenda/DB_Config/API/service/adm_service.dart';
import 'package:agenda/DS/components/Input_Normal_Text/Input_Normal_text_view_model.dart';
import 'package:agenda/DS/components/input_Text/input_text_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CadastroAdmPageViewModel {
  final AdmService _admService = AdmService();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late InputNormalTextViewModel nomeViewModel;
  late InputNormalTextViewModel telefoneViewModel;
  late InputTextViewModel emailViewModel;
  late InputTextViewModel passwordViewModel;

  String generateCodAdm() {
    Random random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  Future<void> CadastrarAdm() async {
    try {
      if (_nomeController.text.isEmpty ||
          _telefoneController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _passwordController.text.isEmpty) {
        print("Preencha todos os campos");
        return;
      }

      String codAdm = generateCodAdm();
      Map<String, dynamic> newAdm = {
        'nome': _nomeController.text,
        'telefone': _telefoneController.text,
        'email': _emailController.text,
        'senha': _passwordController.text,
        "cod_adm": codAdm,
      };

      await _admService.addAdm(newAdm);
      if (kDebugMode) {
        print("Adm added successfully");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error adding adm: $e");
      }
    }
  }

  CadastroAdmPageViewModel() {
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

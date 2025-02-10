import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum InputNormalTextSize { small, medium, large }

enum InputTextType { string, phone }

class InputNormalTextViewModel {
  final InputNormalTextSize size;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool isEnabled;
  final InputTextType inputType;

  InputNormalTextViewModel({
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isEnabled = true,
    required this.size,
    required this.hintText,
    required this.controller,
    this.inputType = InputTextType.string,
  });

  static final phoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  List<TextInputFormatter> get inputFormatters {
    return inputType == InputTextType.phone ? [phoneFormatter] : [];
  }

  TextInputType get inputKeyboardType {
    return inputType == InputTextType.phone
        ? TextInputType.phone
        : TextInputType.text;
  }
}

import 'package:agenda/DS/components/input_Text/input_text_view_model.dart';
import 'package:agenda/DS/shared/colors.dart';
import 'package:agenda/DS/shared/style.dart';
import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final InputTextViewModel viewModel;

  const InputText({super.key, required this.viewModel});

  @override
  InputTextState createState() => InputTextState();

  static Widget instantiate(InputTextViewModel viewModel) {
    return InputText(viewModel: viewModel);
  }
}

class InputTextState extends State<InputText> {
  late bool obscureText;
  String? errorMsg;

  @override
  void initState() {
    super.initState();
    obscureText = widget.viewModel.password;
    widget.viewModel.controller.addListener(validateInput);
  }

  void validateInput() {
    final errorText =
        widget.viewModel.validator?.call(widget.viewModel.controller.text);
    setState(() {
      errorMsg = errorText;
    });
  }

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = 20.0;
    double verticalPadding = 15.0;
    BorderRadius borderRadius = BorderRadius.circular(4);
    BorderSide borderSide = const BorderSide(color: grayColor);
    TextStyle textStyle = textFieldStyle;

    switch (widget.viewModel.size) {
      case InputTextSize.small:
        horizontalPadding = 16.0;
        verticalPadding = 8.0;
        borderRadius = BorderRadius.circular(4);
        borderSide = const BorderSide(color: grayColor);
        textStyle = smallStyle;
        break;
      case InputTextSize.medium:
        horizontalPadding = 24.0;
        verticalPadding = 12.0;
        borderRadius = BorderRadius.circular(4);
        borderSide = const BorderSide(color: grayColor);
        textStyle = normalStyle;
        break;
      case InputTextSize.large:
        horizontalPadding = 32.0;
        verticalPadding = 12.0;
        borderRadius = BorderRadius.circular(4);
        borderSide = const BorderSide(color: grayColor);
        textStyle = normalStyle;
    }

    InputDecoration decoration = InputDecoration(
      contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      border: OutlineInputBorder(
          borderRadius: borderRadius, borderSide: borderSide),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: grayColorLight, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius, borderSide: borderSide),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: redColor, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: redColorLight, width: 2.0),
      ),
      errorText: errorMsg,
    );
    return TextField(
      controller: widget.viewModel.controller,
      obscureText: obscureText,
      decoration: decoration,
      style: textStyle,
    );
  }
}

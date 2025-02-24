import 'package:agenda/DS/components/button/button_view_mode.dart';
import 'package:agenda/DS/shared/colors.dart';
import 'package:agenda/DS/shared/style.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final ButtonViewModel viewModel;

  const Button._({required this.viewModel});

  static Widget instantiate(ButtonViewModel viewModel) {
    return Button._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = 32.0;
    double verticalPadding = 12.0;
    Color buttonColor = cyanColor;
    double iconSize = 32.0;
    TextStyle buttonTextStyle = buttonStyle1;
    double buttonWidth = double.infinity;

    switch (viewModel.size) {
      case ButtonSize.small:
        horizontalPadding = 16.0;
        verticalPadding = 8.0;
        iconSize = 16.0;
        buttonWidth = 160;

        break;
      case ButtonSize.medium:
        horizontalPadding = 15;
        verticalPadding = 12.0;
        iconSize = 24.0;
        buttonWidth = 220;

        break;
      case ButtonSize.large:
        horizontalPadding = 32.0;
        verticalPadding = 12.0;
        iconSize = 32.0;
        buttonWidth = double.infinity;

        break;
    }

    switch (viewModel.style) {
      case ButtonStyleColor.redColor:
        buttonColor = redColor;
        break;
      case ButtonStyleColor.greenColor:
        buttonColor = greenColor;
        break;
      case ButtonStyleColor.cyanColor:
        buttonColor = cyanColor;
        break;
      case ButtonStyleColor.orangeColor:
        buttonColor = orangeColor;
        break;
    }

    switch (viewModel.textStyle) {
      case ButtonTextStyle.buttonStyle1:
        buttonTextStyle = buttonStyle1;
        break;
      case ButtonTextStyle.buttonStyle2:
        buttonTextStyle = buttonStyle2;
        break;
    }

    return ElevatedButton(
      onPressed: viewModel.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: buttonTextStyle,
        minimumSize: Size(buttonWidth, verticalPadding * 3),
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
      ),
      child: viewModel.icon != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  viewModel.icon,
                  size: iconSize,
                  color: Colors.white,
                ),
                const SizedBox(width: 8.0),
                Text(
                  viewModel.title,
                  style: buttonTextStyle,
                ),
              ],
            )
          : Text(
              viewModel.title,
              style: buttonTextStyle,
            ),
    );
  }
}

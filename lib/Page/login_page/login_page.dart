import 'package:agenda/DS/components/button/button.dart';
import 'package:agenda/DS/components/button/button_view_mode.dart';
import 'package:agenda/DS/components/input_Text/input_text.dart';
import 'package:agenda/DS/components/linkedLabel/linked_label.dart';
import 'package:agenda/DS/components/linkedLabel/linked_label_view_model.dart';
import 'package:agenda/DS/shared/colors.dart';
import 'package:agenda/Page/login_page/login_page_view_model.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginPageViewModel _viewModel;
  late ButtonViewModel _loginButtonViewModel;
  late LinkedLabelViewModel _linkedLabelViewModel;
  late ButtonViewModel _createButtonViewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = LoginPageViewModel();
    _loginButtonViewModel = ButtonViewModel(
      title: "Login",
      size: ButtonSize.large,
      style: ButtonStyleColor.greenColor,
      textStyle: ButtonTextStyle.buttonStyle1,
      onPressed: () {
        _viewModel.login();
      },
    );
    _createButtonViewModel = ButtonViewModel(
      title: "Create account",
      size: ButtonSize.large,
      style: ButtonStyleColor.orangeColor,
      textStyle: ButtonTextStyle.buttonStyle1,
      onPressed: () {
        _viewModel.login();
      },
    );
    _linkedLabelViewModel = LinkedLabelViewModel(
        fullText: 'Forgot your password?',
        linkedText: 'Click here',
        onLinkTap: () {});
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cyannoramlColor,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                width: constraints.maxWidth * 0.8,
                height: constraints.maxHeight * 0.8,
                constraints:
                    const BoxConstraints(minWidth: 250, minHeight: 100),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: cyanColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: const Icon(
                        Icons.calendar_today,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Agenda App',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          InputText.instantiate(_viewModel.emailViewModel),
                          const SizedBox(height: 16.0),
                          InputText.instantiate(_viewModel.passwordViewModel),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: LinkedLabel.instantiate(
                            viewModel: _linkedLabelViewModel),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Button.instantiate(_loginButtonViewModel),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Button.instantiate(_createButtonViewModel),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

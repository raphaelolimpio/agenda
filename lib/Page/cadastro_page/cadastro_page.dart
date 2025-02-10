import 'package:agenda/DS/components/Input_Normal_Text/input_Normal_text.dart';
import 'package:agenda/DS/components/button/button.dart';
import 'package:agenda/DS/components/button/button_view_mode.dart';
import 'package:agenda/DS/components/input_Text/input_text.dart';
import 'package:agenda/DS/shared/colors.dart';
import 'package:agenda/Page/cadastro_page/cadastro_page_view_model.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});
  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  late CadastroPageViewModel _viewModel;
  late ButtonViewModel _buttonViewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CadastroPageViewModel();
    _buttonViewModel = ButtonViewModel(
      title: "Cadastro",
      size: ButtonSize.large,
      style: ButtonStyleColor.greenColor,
      textStyle: ButtonTextStyle.buttonStyle1,
      onPressed: () {},
    );
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
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Cadastro',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          InputNormalText.instantiate(
                              _viewModel.nameResponsavelViewModel),
                          const SizedBox(height: 16.0),
                          InputNormalText.instantiate(_viewModel.nomeViewModel),
                          const SizedBox(height: 16.0),
                          InputNormalText.instantiate(
                              _viewModel.telefoneViewModel),
                          const SizedBox(height: 16.0),
                          InputText.instantiate(_viewModel.emailViewModel),
                          const SizedBox(height: 16.0),
                          InputText.instantiate(_viewModel.passwordViewModel),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Button.instantiate(_buttonViewModel),
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

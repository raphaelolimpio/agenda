import 'package:agenda/Page/cadastro_page_adm/cadastro_adm_page.dart';
import 'package:agenda/Page/login_page/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => CadastroAdmPage(),
      },
    );
  }
}

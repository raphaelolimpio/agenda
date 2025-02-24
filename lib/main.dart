import 'package:agenda/Page/cadastro_page_User/cadastro__user_page.dart';
import 'package:agenda/Page/cadastro_page_adm/cadastro_adm_page.dart';
import 'package:agenda/Page/calendar_page/calendar_page.dart';
import 'package:agenda/Page/home_page/home_page.dart';
import 'package:agenda/Page/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
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
        '/': (context) => CalendarPage(),
      },
    );
  }
}

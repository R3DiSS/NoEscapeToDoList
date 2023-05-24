import 'package:boescapetodo/pages/home_page.dart';
import 'package:boescapetodo/pages/signin.dart';
import 'package:boescapetodo/pages/signup.dart';
import 'package:boescapetodo/pages/today.dart';
import 'package:boescapetodo/pages/todo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'Service/Auth_Service.dart';
import 'package:boescapetodo/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:boescapetodo/TodoList.dart';


List<Widget> _widgetOptions = <Widget>[
  TodayPage(), // Assuming you have a CalendarPage widget
];

class CalendarPage {
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = SignUpPage();
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = HomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: currentPage,
    );
  }
}


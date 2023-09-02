import 'package:flutter/material.dart';
import 'package:noteappphp/app/addnote.dart';
import 'package:noteappphp/app/auth/signup.dart';
import 'package:noteappphp/app/editnotes.dart';
import 'package:noteappphp/app/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/auth/login.dart';

late SharedPreferences shardPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  shardPref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App Php Database',
      initialRoute: shardPref.getString('id') == null ? 'login' : 'Home',
      routes: {
        "login": (context) => login(),
        "signup": (context) => signup(),
        "Home": (context) => Home(),
        "AddNotes": (context) => AddNotes(),
        "EditNotes": (context) => EditNotes(),
      },
    );
  }
}

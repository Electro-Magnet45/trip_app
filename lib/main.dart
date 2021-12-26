import 'package:flutter/material.dart';
import 'package:why_book/screens/login_screen.dart';
import 'package:why_book/screens/register_screen.dart';
import './constrains.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ThemeData().colorScheme.copyWith(primary: primaryColor)),
      home: const Register(),
    );
  }
}

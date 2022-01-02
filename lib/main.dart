import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:why_book/routes.dart';
import './constrains.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  GetMaterialApp build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.downToUp,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: primaryColor, surface: Colors.black),
          textTheme: ThemeData().textTheme.apply(
                displayColor: Colors.black,
              ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Color(0xFFF8F8F8),
            foregroundColor: Colors.black,
            toolbarHeight: 100,
          )),
      initialRoute: isLoggedIn ? '/home' : '/login',
      routes: routes,
    );
  }
}

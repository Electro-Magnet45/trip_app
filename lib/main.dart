import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:travel_app/routes.dart';
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
      title: 'Travel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(primary: primaryColor),
          textTheme: ThemeData().textTheme.apply(displayColor: Colors.black)),
      initialRoute: '/home',
      routes: routes,
    );
  }
}

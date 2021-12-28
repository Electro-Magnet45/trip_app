import 'package:flutter/material.dart';
import 'package:why_book/screens/loggedIn/home_page.dart';
import 'package:why_book/screens/loggedOut/login_screen.dart';
import 'package:why_book/screens/loggedOut/register_screen.dart';

final Map<String, Widget Function(BuildContext)> loggedOutRoutes = {
  '/login': (context) => const Login(),
  '/register': (context) => const Register(),
};

final Map<String, Widget Function(BuildContext)> loggedInRoutes = {
  '/home': (context) => const Home(),
};

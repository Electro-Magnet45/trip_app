import 'package:flutter/material.dart';
import './screens/loggedin/home_page.dart';
import './screens/loggedout/login_screen.dart';
import './screens/loggedout/register_screen.dart';

final Map<String, Widget Function(BuildContext)> loggedOutRoutes = {
  '/login': (context) => const Login(),
  '/register': (context) => const Register(),
};

final Map<String, Widget Function(BuildContext)> loggedInRoutes = {
  '/home': (context) => const Home(),
};

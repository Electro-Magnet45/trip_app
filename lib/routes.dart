import 'package:flutter/material.dart';
import './screens/userpages/trip_plan.dart';
import './screens/userpages/home_page.dart';
import './screens/loggedout/login_screen.dart';
import './screens/loggedout/register_screen.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/login': (context) => const Login(),
  '/register': (context) => const Register(),
  '/home': (context) => const Home(),
  '/trip-plan': (context) => const TripPlan(),
};

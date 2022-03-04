import 'package:flutter/material.dart';
import './screens/userpages/trip_plan.dart';
import './screens/userpages/home_page.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/home': (BuildContext context) => const Home(),
  '/trip-plan': (BuildContext context) => const TripPlan(),
};

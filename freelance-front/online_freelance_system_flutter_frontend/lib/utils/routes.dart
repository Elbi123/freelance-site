import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/screens/homepage/homePage.dart';
import 'package:online_freelance_system_flutter_frontend/screens/landing_page/landingPage.dart';

class AppRoute {
  static String homepageroute = '/';

  static Route generateRoute(RouteSettings settings) {
    if (settings.name == homepageroute) {
      return MaterialPageRoute(builder: (context) => LandingPage());
    }
    return MaterialPageRoute(builder: (context) => LandingPage());
  }
}

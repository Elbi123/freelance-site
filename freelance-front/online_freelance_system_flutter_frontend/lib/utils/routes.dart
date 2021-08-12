import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/models/Feeds.dart';
import 'package:online_freelance_system_flutter_frontend/screens/auth/loginPage.dart';
import 'package:online_freelance_system_flutter_frontend/screens/auth/signUpPage.dart';
import 'package:online_freelance_system_flutter_frontend/screens/homepage/homePage.dart';
import 'package:online_freelance_system_flutter_frontend/screens/my_jobs/my_jobs_page.dart';
import 'package:online_freelance_system_flutter_frontend/screens/profile/profilePage.dart';
import 'package:online_freelance_system_flutter_frontend/screens/proposal/submitProposal.dart';
import 'package:online_freelance_system_flutter_frontend/utils/routeNames.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == homepageroute) {
      return MaterialPageRoute(builder: (context) => HomePage());
    }
    if (settings.name == loginpageroute) {
      return MaterialPageRoute(builder: (context) => LoginPage());
    }
    if (settings.name == signuppageroute) {
      return MaterialPageRoute(builder: (context) => SignUpPage());
    }
    if (settings.name == submitproposalroute) {
      final args = settings.arguments as FeedsDetailArgument;
      return MaterialPageRoute(
        builder: (context) => SubmitProposalPage(feedsDetail: args.feeds),
      );
    }
    if (settings.name == myjobsroute) {
      return MaterialPageRoute(builder: (context) => MyJobsPage());
    }
    if (settings.name == profileroute) {
      return MaterialPageRoute(builder: (context) => ProfilePage());
    }
    return MaterialPageRoute(builder: (context) => HomePage());
  }
}

class FeedsDetailArgument {
  final Feeds feeds;

  FeedsDetailArgument(this.feeds);
}

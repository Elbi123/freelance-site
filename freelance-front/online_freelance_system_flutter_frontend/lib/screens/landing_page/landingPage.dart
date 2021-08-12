import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/landingNavBar.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/navbar.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

import 'body.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(colors: [kPrimaryColor, kPrimaryLight])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              LandingNavBar(),
              Body(),
              // Footer()
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/navbar.dart';

import 'body.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              NavBar(),
              Body(),
              // Footer()
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/screens/feeds/feedsBody.dart';
import 'package:online_freelance_system_flutter_frontend/screens/feeds/signedNavBar.dart';

class FeedsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(children: [FeedsNavBar(), FeedsBody()]),
        ),
      ),
    );
  }
}

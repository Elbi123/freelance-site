import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/navbar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          NavBar(),
          Center(
            child: Text("Home Page"),
          )
        ],
      ),
    ));
  }
}

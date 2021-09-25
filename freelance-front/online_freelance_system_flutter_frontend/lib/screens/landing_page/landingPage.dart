import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/footer.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/landingNavBar.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/navbar.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

import 'body.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        // image: DecorationImage(image: AssetImage('/freelancebanner3.png')),
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment(0.01, 0),
        //   tileMode: TileMode.repeated,
        //   colors: [kPrimaryColor, Colors.white],
        // )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              LandingNavBar(),
              Body(),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 2,
                child: Center(
                    child: Text(
                  "Adds Part",
                  style: blacksemiboldMediumTextStyle.copyWith(fontSize: 30),
                )),
              ),
              Footer()
            ],
          ),
        ),
      ),
    );
  }
}

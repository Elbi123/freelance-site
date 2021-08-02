import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';
import 'package:online_freelance_system_flutter_frontend/utils/responsivelayout.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      largeScreen: LargeChild(),
    );
  }
}

class LargeChild extends StatefulWidget {
  @override
  _LargeChildState createState() => _LargeChildState();
}

class _LargeChildState extends State<LargeChild> {
  double buttonSize = 130;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: Stack(
        fit: StackFit.expand,
        children: [
          FractionallySizedBox(
            alignment: Alignment.centerRight,
            widthFactor: 0.5,
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Image.asset('/freelancebanner4.png'),
            ),
          ),
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Join the world's",
                    style: bannerHeading1TextStyle,
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Work MarketPlace",
                        style: bannerHeading1TextStyle),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12, top: 20),
                    child: Text(
                      "Find Great Talent , Build Your Business.",
                      style: bannerHeading2TextStyle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12, top: 20),
                    child: Text(
                      "Take your career to the next level.",
                      style: bannerHeading2TextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            width: 130,
                            height: 40,
                            decoration: BoxDecoration(
                              color: lightGreen,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Find Talent",
                                style: whitenavButtonTextStyle,
                              ),
                            ),
                          )),
                      InkWell(
                          onTap: () {},
                          onHover: (value) {
                            setState(() {
                              buttonSize = value ? 150 : 130;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(seconds: 0),
                            curve: Curves.easeIn,
                            margin: EdgeInsets.only(left: 45),
                            width: buttonSize,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: lightGreen, width: 1),
                              color: white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Find Work",
                                style: greenNavButtonTextStyle,
                              ),
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

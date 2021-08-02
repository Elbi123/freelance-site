import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';
import 'package:online_freelance_system_flutter_frontend/utils/responsivelayout.dart';

class FeedsBody extends StatelessWidget {
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
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(30),
              border: Border.all(color: lightGreen, width: 1)),
          width: MediaQuery.of(context).size.width / 2,
          height: 100,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    color: lightGreen, borderRadius: BorderRadius.circular(30)),
                child: Center(
                    child: Icon(
                  Icons.laptop,
                  size: 60,
                  color: white,
                )),
              ),
              SizedBox(
                width: 30,
              ),
              Center(
                child: Text(
                  "Congratulation , Your Account Is Verified.",
                  style:
                      bannerHeading2TextStyle.copyWith(fontFamily: "Simonetta"),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
          child: SizedBox(
            height: 700,
            child: Stack(
              fit: StackFit.expand,
              children: [
                FractionallySizedBox(
                  alignment: Alignment.topLeft,
                  widthFactor: 0.2,
                  child: Container(
                    // decoration: BoxDecoration(
                    //     color: white,
                    //     boxShadow: [
                    //       BoxShadow(
                    //           color: lightGrey,
                    //           offset: Offset(0, 8),
                    //           blurRadius: 15)
                    //     ]),
                    margin: EdgeInsets.only(
                      right: 20,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Best Matches",
                          style: feedLinksTextStyle.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Recommended",
                          style: feedLinksTextStyle.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "My Categories",
                          style: feedLinksTextStyle.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: FractionallySizedBox(
                      widthFactor: 0.6,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                        decoration: BoxDecoration(color: white, boxShadow: [
                          BoxShadow(
                              color: lightGrey,
                              offset: Offset(0, 8),
                              blurRadius: 15)
                        ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Feeds",
                              style: bannerHeading2TextStyle.copyWith(
                                  color: lightGreen),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 250,
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  border: Border.symmetric(
                                      horizontal: BorderSide(
                                          width: 0.5,
                                          color: customGrey,
                                          style: BorderStyle.solid))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Full Stack Developer & IOS Developer.",
                                    style: feedLinksTextStyle.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Job Type : Houry"),
                                  RichText(
                                      text: TextSpan(
                                          text:
                                              "We are a growing IT company and we are looking for a Full Stack Developer for our company. This is full time role and we are looking for a suitable candidates who can grow with our company. Kindly submit your proposal with your rates. Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book it has? Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book it has?")),
                                  Row(
                                    children: [
                                      Text("Proposals  : 5"),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("Number Of Freelace Needed : 1")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          "Location  : Ethiopia , Addis Ababa"),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("Proffesionality : Entry Level")
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 250,
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  border: Border.symmetric(
                                      horizontal: BorderSide(
                                          width: 0.5,
                                          color: customGrey,
                                          style: BorderStyle.solid))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Full Stack Developer & IOS Developer.",
                                    style: feedLinksTextStyle.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Job Type : Houry"),
                                  RichText(
                                      text: TextSpan(
                                          text:
                                              "We are a growing IT company and we are looking for a Full Stack Developer for our company. This is full time role and we are looking for a suitable candidates who can grow with our company. Kindly submit your proposal with your rates. Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book it has? Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book it has?")),
                                  Row(
                                    children: [
                                      Text("Proposals  : 5"),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("Number Of Freelace Needed : 1")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          "Location  : Ethiopia , Addis Ababa"),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("Proffesionality : Entry Level")
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 250,
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  border: Border.symmetric(
                                      horizontal: BorderSide(
                                          width: 0.5,
                                          color: customGrey,
                                          style: BorderStyle.solid))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Full Stack Developer & IOS Developer.",
                                    style: feedLinksTextStyle.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Job Type : Houry"),
                                  RichText(
                                      text: TextSpan(
                                          text:
                                              "We are a growing IT company and we are looking for a Full Stack Developer for our company. This is full time role and we are looking for a suitable candidates who can grow with our company. Kindly submit your proposal with your rates. Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book it has? Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book it has?")),
                                  Row(
                                    children: [
                                      Text("Proposals  : 5"),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("Number Of Freelace Needed : 1")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          "Location  : Ethiopia , Addis Ababa"),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("Proffesionality : Entry Level")
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                FractionallySizedBox(
                  alignment: Alignment.topRight,
                  widthFactor: 0.2,
                  child: Container(
                    // decoration: BoxDecoration(
                    //     color: white,
                    //     boxShadow: [
                    //       BoxShadow(
                    //           color: lightGrey,
                    //           offset: Offset(0, 8),
                    //           blurRadius: 15)
                    //     ]),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "My Resume",
                          style: feedLinksTextStyle.copyWith(
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Text(
                            "Proffessional Detail",
                            style: greenNavButtonTextStyle,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Image.asset("/profiledemo1.jpg")),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Name : ",
                                    style: greenNavButtonTextStyle,
                                  ),
                                  Text(
                                    "Jhon Doe",
                                    style: greenNavButtonTextStyle,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

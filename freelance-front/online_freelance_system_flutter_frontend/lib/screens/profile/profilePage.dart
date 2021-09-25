import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/footer.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/navbar.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [NavBar(), _body(context), Footer()],
        ),
      ),
    );
  }

  Widget _sideNavLink(String title, String route) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            title,
            style: blacksemiboldMediumTextStyle,
          )),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1.5 / 5,
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70)),
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                AssetImage('/images/profile1.jfif'),
                          ),
                        ),
                        Text(
                          "@kirubelayehu",
                          style: blacksemiboldMediumTextStyle.copyWith(
                              fontSize: 22),
                        ),
                        Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kirubel Ayehu",
                              style: blacksemiboldMediumTextStyle.copyWith(
                                  fontSize: 18),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                    ),
                                    Text(
                                      "From",
                                      style: blacksemiboldMediumTextStyle
                                          .copyWith(),
                                    )
                                  ],
                                ),
                                Text(
                                  "Ethiopia",
                                  style:
                                      blacksemiboldMediumTextStyle.copyWith(),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.person),
                                    Text(
                                      "Member Since",
                                      style: blacksemiboldMediumTextStyle
                                          .copyWith(),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Feb 2021",
                                  style:
                                      blacksemiboldMediumTextStyle.copyWith(),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Languages',
                              style: blacksemiboldMediumTextStyle.copyWith(
                                  fontSize: 20)),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(text: "English"),
                            TextSpan(text: "-"),
                            TextSpan(text: "Basic")
                          ])),
                          Divider(),
                          Text("Linked Accounts",
                              style: blacksemiboldMediumTextStyle.copyWith(
                                  fontSize: 20)),
                          Column(
                            children: [
                              _socialAccountItem(AntIcons.facebook, "Facebook"),
                              _socialAccountItem(
                                  AntIcons.twitter_outline, "Twitter"),
                              _socialAccountItem(AntIcons.linkedin, "Linkedin")
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Skills",
                                  style: blacksemiboldMediumTextStyle.copyWith(
                                      fontSize: 20)),
                              InkWell(
                                onTap: () {},
                                child: Text("Add New",
                                    style:
                                        blacksemiboldMediumTextStyle.copyWith(
                                            fontSize: 18,
                                            color: kPrimaryColor)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              _singleSkillItems("AndroidDeveloper"),
                              _singleSkillItems("Flutter Developer"),
                              _singleSkillItems("Ios Developer"),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Education",
                                  style: blacksemiboldMediumTextStyle.copyWith(
                                      fontSize: 20)),
                              InkWell(
                                onTap: () {},
                                child: Text("Add New",
                                    style:
                                        blacksemiboldMediumTextStyle.copyWith(
                                            fontSize: 18,
                                            color: kPrimaryColor)),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "B.Sc",
                                    style: blacksemiboldMediumTextStyle),
                                TextSpan(
                                    text: " - ",
                                    style: blacksemiboldMediumTextStyle),
                                TextSpan(
                                    text: "Software Engineering",
                                    style: blacksemiboldMediumTextStyle)
                              ])),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Addis Ababa ",
                                    style: blacksemiboldMediumTextStyle),
                                TextSpan(
                                    text: "Ethiopia",
                                    style: blacksemiboldMediumTextStyle)
                              ])),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Graduated  ",
                                    style: blacksemiboldMediumTextStyle),
                                TextSpan(
                                    text: "2021",
                                    style: blacksemiboldMediumTextStyle)
                              ]))
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Certification",
                                  style: blacksemiboldMediumTextStyle.copyWith(
                                      fontSize: 20)),
                              InkWell(
                                onTap: () {},
                                child: Text("Add New",
                                    style:
                                        blacksemiboldMediumTextStyle.copyWith(
                                            fontSize: 18,
                                            color: kPrimaryColor)),
                              )
                            ],
                          ),
                          Text(
                            "Add Your Certification",
                            style: blacksemiboldMediumTextStyle,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 3 / 5,
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
          )
        ],
      ),
    );
  }

  Widget _socialAccountItem(IconData iconData, String title) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          Icon(iconData, color: Colors.indigo, size: 20.0),
          Padding(
            padding: EdgeInsets.only(left: 05.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _singleSkillItems(String s) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                border: Border.all(color: customGrey),
                borderRadius: BorderRadius.circular(25)),
            child: Text(
              s,
              style: blacksemiboldMediumTextStyle,
            ),
          )
        ],
      ),
    );
  }
}

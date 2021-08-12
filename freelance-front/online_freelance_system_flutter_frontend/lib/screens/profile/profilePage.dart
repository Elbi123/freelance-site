import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/footer.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/navbar.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/circularProfilePic.dart';
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

  Widget _body(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 100, horizontal: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(children: [
            _sideNavLink("Profile Settings ", "route"),
            _sideNavLink("Password And Security", "route"),
            _sideNavLink("Notification Setting", "route"),
            _sideNavLink("Get Paid", "route"),
            _sideNavLink("Tax Information", "route"),
            _sideNavLink("About", "route")
          ]),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 3 / 4,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                decoration: BoxDecoration(
                    color: Colors.white, border: Border.all(color: lightGrey)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "Profile",
                    //       style: blacksemiboldMediumTextStyle.copyWith(
                    //           fontSize: 25),
                    //     ),
                    //     Container(
                    //       decoration: BoxDecoration(
                    //         border: Border.all(color: lightGrey),
                    //         borderRadius: BorderRadius.circular(50),
                    //       ),
                    //       child: Icon(
                    //         Icons.edit,
                    //         color: lightGrey,
                    //         size: 25,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    Center(
                        child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: kSecondaryColor, width: 3),
                          borderRadius: BorderRadius.circular(75)),
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage: AssetImage("/images/profile1.jfif"),
                      ),
                    )),

                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "User Name \n",
                                style: blacksemiboldMediumTextStyle.copyWith(
                                    fontSize: 18)),
                            TextSpan(
                                text: "kirubelayehu17",
                                style: blacksemiboldMediumTextStyle.copyWith(
                                    fontSize: 18))
                          ])),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Name \n",
                                style: blacksemiboldMediumTextStyle.copyWith(
                                    fontSize: 18)),
                            TextSpan(
                                text: "kirubel ayehu",
                                style: blacksemiboldMediumTextStyle.copyWith(
                                    fontSize: 18))
                          ])),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Email \n",
                                style: blacksemiboldMediumTextStyle.copyWith(
                                    fontSize: 18)),
                            TextSpan(
                                text: "kirubelayehu1715@gmail.com",
                                style: blacksemiboldMediumTextStyle.copyWith(
                                    fontSize: 18))
                          ]))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 3 / 4,
                decoration: BoxDecoration(
                    color: Colors.white, border: Border.all(color: lightGrey)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Contact Info",
                              style: blacksemiboldMediumTextStyle.copyWith(
                                  fontSize: 25)),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: lightGrey),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.edit,
                              color: lightGrey,
                              size: 25,
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Text("Address ",
                          style: blacksemiboldMediumTextStyle.copyWith(
                              fontSize: 18)),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "4 Kilo \n",
                            style: blacksemiboldMediumTextStyle.copyWith(
                                fontSize: 18)),
                        TextSpan(
                            text: "Addis Ababa \n",
                            style: blacksemiboldMediumTextStyle.copyWith(
                                fontSize: 18)),
                        TextSpan(
                            text: "Ethiopia",
                            style: blacksemiboldMediumTextStyle.copyWith(
                                fontSize: 18))
                      ]))
                    ]),
              )
            ],
          )
        ],
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
}

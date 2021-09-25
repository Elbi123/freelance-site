import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/circularProfilePic.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';
import 'package:online_freelance_system_flutter_frontend/utils/menuController.dart';
import 'package:online_freelance_system_flutter_frontend/utils/responsivelayout.dart';
import 'package:online_freelance_system_flutter_frontend/utils/routeNames.dart';

class NavBar extends StatefulWidget {
  static bool isLoggedIn = true;

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _dropdownShown = false;
  void _toggleDropdown() {
    setState(() {
      _dropdownShown = !_dropdownShown;
    });
  }

  final navLinks = [
    ["Find Work", homepageroute],
    ["My Jobs", myjobsroute],
    ["Reports", ""],
  ];

  List<Widget> navItem() {
    return navLinks.map((e) {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, e.last);
        },
        child: Padding(
            padding: EdgeInsets.only(left: 12),
            child: Row(children: [
              Text(e.first, style: boldNavLinkTextStyle),
            ])),
      );
    }).toList();
  }

  final MenuController _controller = Get.put(MenuController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 65,
      decoration: BoxDecoration(
          color: kPrimaryColor,
          border: Border.symmetric(
              horizontal: BorderSide(width: 0.5, color: lightGrey))),
      padding: EdgeInsets.symmetric(
          horizontal: !Responsive.isMobileScreen(context) &&
                  !Responsive.isMediumScreen(context)
              ? 45
              : 5,
          vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (Responsive.isMobileScreen(context) ||
              Responsive.isMediumScreen(context))
            IconButton(
              icon: Icon(
                Icons.menu,
                color: white,
              ),
              onPressed: () {
                _controller.openOrCloseDrawer();
              },
            ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(18)),
                  child: Center(
                      child: Text(
                    "E",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: kPrimaryColor),
                  )),
                ),
                SizedBox(width: 16),
                Text(
                  "Elance",
                  style: TextStyle(
                      color: white, fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Responsive.isMobileScreen(context) ||
                  Responsive.isMediumScreen(context)
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: white,
                  ),
                )
              : Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 0.5,
                            color: kPrimaryLight,
                          )),
                      child: TextField(
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                            suffixIcon: Container(
                              width: 50,
                              decoration: BoxDecoration(
                                  color: kSecondaryColor,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      bottomRight: Radius.circular(50))),
                              child: IconButton(
                                  onPressed: () {},
                                  iconSize: 18,
                                  icon: Icon(
                                    Icons.search,
                                    color: white,
                                  )),
                            ),
                            hintText: "Search Keyword  ",
                            hintStyle: whiteTextStyle.copyWith(
                                fontSize: 15, color: white),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Row(
                      children: <Widget>[...navItem()]..add(
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    AntIcons.question,
                                    color: Colors.white,
                                  )),
                              NavBar.isLoggedIn
                                  ? Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, notificationsroute);
                                          },
                                          icon: Icon(AntIcons.notification),
                                          color: Colors.white,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, messageroute);
                                          },
                                          icon: Icon(AntIcons.message),
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, profileroute);
                                            },
                                            child: CustomCircularPicture(
                                                imageaddres:
                                                    "/images/profile1.jfif"),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  loginpageroute,
                                                  (route) => false);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(left: 2),
                                              width: 110,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: kPrimaryColor)),
                                              child: Center(
                                                child: Text(
                                                  "Login",
                                                  style: greenNavButtonTextStyle
                                                      .copyWith(
                                                          color: kPrimaryColor),
                                                ),
                                              ),
                                            )),
                                        InkWell(
                                            onTap: () {},
                                            child: Container(
                                              margin: EdgeInsets.only(left: 5),
                                              width: 110,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: kPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "SignUp",
                                                  style: whitenavButtonTextStyle
                                                      .copyWith(color: white),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}

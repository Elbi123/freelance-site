import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/circularProfilePic.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';
import 'package:online_freelance_system_flutter_frontend/utils/menuController.dart';
import 'package:online_freelance_system_flutter_frontend/utils/responsivelayout.dart';
import 'package:online_freelance_system_flutter_frontend/utils/routeNames.dart';

class LandingNavBar extends StatelessWidget {
  final navLinks = ["Find Talent", "Find Work", "Why Upwork", "Enterprise"];
  List<Widget> navItem() {
    return navLinks.map((e) {
      return Padding(
        padding: EdgeInsets.only(left: 12),
        child: Row(
          children: [
            Text(e, style: boldNavLinkTextStyle),
          ],
        ),
      );
    }).toList();
  }

  static bool isLoggedIn = false;
  final MenuController _controller = Get.put(MenuController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 65,
      decoration: BoxDecoration(
          color: Colors.transparent,
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
          Row(
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
                          color: white,
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
                                fontSize: 15, color: kPrimaryColor),
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
                              isLoggedIn
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: CustomCircularPicture(
                                          imageaddres: "/images/profile1.jfif"),
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
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: kSecondaryColor,
                                                      width: 2)),
                                              child: Center(
                                                child: Text(
                                                  "Login",
                                                  style: greenNavButtonTextStyle
                                                      .copyWith(
                                                          color:
                                                              kSecondaryColor),
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
                                                color: kSecondaryColor,
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

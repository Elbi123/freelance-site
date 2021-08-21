import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/screens/feeds/feedsHomePage.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';
import 'package:online_freelance_system_flutter_frontend/utils/responsivelayout.dart';

class NavBar extends StatelessWidget {
  final navLinks = ["Find Talent", "Find Work", "Why Upwork", "Enterprise"];
  List<Widget> navItem() {
    return navLinks.map((e) {
      return Padding(
        padding: EdgeInsets.only(left: 8),
        child: Row(
          children: [
            Text(
              e,
              style: TextStyle(),
            ),
            e != "Enterprise"
                ? IconButton(
                    icon: Icon(Icons.arrow_drop_down), onPressed: () {})
                : Text(""),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(width: 0.5, color: lightGrey))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: lightGreen,
                      borderRadius: BorderRadius.circular(18)),
                  child: Center(
                      child: Text(
                    "E",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white),
                  )),
                ),
                SizedBox(width: 16),
                Text(
                  "Elance",
                  style: TextStyle(
                      color: lightGreen,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Responsive.isXS(context)
                ? IconButton(icon: Icon(Icons.menu), onPressed: () {})
                : Responsive.isSM(context)
                    ? Row(
                        children: <Widget>[...navItem()]..add(
                            Row(
                              children: [
                                SizedBox(
                                  width: 25,
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: lightGreen,
                                      size: 18,
                                    ),
                                    onPressed: () {}),
                                IconButton(
                                    icon: Icon(Icons.menu), onPressed: () {})
                              ],
                            ),
                          ),
                      )
                    : Responsive.isLG(context)
                        ? Row(
                            children: <Widget>[...navItem()]..add(
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Container(
                                      width: 260,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            width: 0.5,
                                            color: customGrey,
                                          )),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            prefixIcon: IconButton(
                                                onPressed: () {},
                                                iconSize: 18,
                                                icon: Icon(
                                                  Icons.search,
                                                  color: lightGreen,
                                                )),
                                            hintText: "Search",
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FeedsHomePage()));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(left: 5),
                                          width: 110,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: white,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Login",
                                              style: greenNavButtonTextStyle,
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
                                            color: lightGreen,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "SignUp",
                                              style: whitenavButtonTextStyle,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                          )
                        : IconButton(icon: Icon(Icons.menu), onPressed: () {})
          ],
        ),
      ),
    );
  }
}

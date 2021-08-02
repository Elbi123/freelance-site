import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';
import 'package:online_freelance_system_flutter_frontend/utils/responsivelayout.dart';

class FeedsNavBar extends StatefulWidget {
  @override
  _FeedNavBarState createState() => _FeedNavBarState();
}

class _FeedNavBarState extends State<FeedsNavBar> {
  String dropdownvalue = 'Flutter';
  final navLinks = [
    "Find Work",
    "My Jobs",
    "Notifications",
    "Reports",
  ];
  List<Widget> navItem() {
    return navLinks.map((e) {
      return Padding(
        padding: EdgeInsets.only(left: 15),
        child: Row(
          children: [
            e != "Notifications"
                ? DropdownButton<String>(
                    hint: Text(
                      e,
                      style: TextStyle(color: lightGrey),
                    ),
                    value: null,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    iconSize: 25,
                    elevation: 16,
                    style: TextStyle(color: Colors.blue),
                    underline: Text(""),
                    // onChanged: (String newValue) {

                    // },
                    items: e == "Find Work"
                        ? <String>[
                            "Saved Jobs",
                            "Proposals",
                            "Profile",
                          ].map<DropdownMenuItem<String>>((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          }).toList()
                        : e == "My Jobs"
                            ? <String>[
                                "All Contracts",
                                "Work Diary",
                              ].map<DropdownMenuItem<String>>((String val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              }).toList()
                            : <String>["My Reports", "Customer Service"]
                                .map<DropdownMenuItem<String>>((String val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              }).toList(),
                  )
                : Text(
                    e,
                    style: TextStyle(color: lightGrey),
                  ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: lightGreen,
          border: Border.symmetric(
              horizontal: BorderSide(width: 0.5, color: lightGreen))),
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
                      color: white, borderRadius: BorderRadius.circular(18)),
                  child: Center(
                      child: Text(
                    "E",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: lightGreen),
                  )),
                ),
                SizedBox(width: 16),
                Text(
                  "Elance",
                  style: TextStyle(
                      color: lightGrey,
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
                                      color: lightGrey,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: 400,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 0.5,
                                      color: lightGrey,
                                    )),
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(color: lightGrey),
                                      prefixIcon: IconButton(
                                          onPressed: () {},
                                          iconSize: 18,
                                          icon: Icon(
                                            Icons.search,
                                            color: lightGrey,
                                          )),
                                      hintText: "Search",
                                      border: InputBorder.none),
                                ),
                              ),
                              ...navItem()
                            ]..add(
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 25,
                                    ),
                                    InkWell(
                                        onTap: () {},
                                        child: Container(
                                          margin: EdgeInsets.only(left: 5),
                                          height: 40,
                                          child: Center(
                                            child: IconButton(
                                              onPressed: () {},
                                              iconSize: 25,
                                              color: lightGrey,
                                              icon: Icon(Icons.message),
                                            ),
                                          ),
                                        )),
                                    InkWell(
                                        onTap: () {},
                                        child: Container(
                                          margin: EdgeInsets.only(left: 5),
                                          height: 40,
                                          child: Center(
                                            child: IconButton(
                                              onPressed: () {},
                                              iconSize: 25,
                                              color: lightGrey,
                                              icon: Icon(Icons.more_horiz),
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

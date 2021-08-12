import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/footer.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/navbar.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/customDrawer.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';
import 'package:online_freelance_system_flutter_frontend/utils/menuController.dart';

class MyJobsPage extends StatefulWidget {
  const MyJobsPage({Key? key}) : super(key: key);

  @override
  _MyJobsPageState createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> {
  // MenuController _controller = Get.put(MenuController());
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: shiroColor,
        // key: _controller.scaffoldkey,
        drawer: SideMenu(),
        body: SingleChildScrollView(
          child: Column(
            children: [NavBar(), _body(context), Footer()],
          ),
        ));
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 150),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Jobs",
                    style: blacksemiboldMediumTextStyle.copyWith(fontSize: 30),
                  ),
                  Row(
                    children: [
                      Text("Earning Availaible Now : 0.00 Birr"),
                      Container(
                        child: Icon(Icons.menu),
                      )
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: shiroColor, width: 1),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(" Active Contracts",
                          style: blacksemiboldMediumTextStyle.copyWith(
                              fontSize: 25)),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text:
                                "Contracts you're actively working on will appear here.",
                            style: blacksemiboldMediumTextStyle),
                        TextSpan(
                            text: " Start searching for new projects now!",
                            style: blacksemiboldMediumTextStyle)
                      ])),
                    )
                  ],
                ),
              )
            ])));
  }
}

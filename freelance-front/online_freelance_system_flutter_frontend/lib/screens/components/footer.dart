// ignore: import_of_legacy_library_into_null_safe
import 'package:ant_icons/ant_icons.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';
import 'package:online_freelance_system_flutter_frontend/utils/responsivelayout.dart';

class Footer extends StatefulWidget {
  Footer({Key? key}) : super(key: key);

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Responsive.isLargeScreen(context) ? 40.0 : 10.0,
          top: 50.0,
          right: Responsive.isLargeScreen(context) ? 40 : 10.0,
          bottom: 20.0),
      color: Colors.white,
      child: Column(
        children: [
          GridView.count(
            crossAxisCount: Responsive.isLargeScreen(context) ? 4 : 1,
            childAspectRatio: Responsive.isLargeScreen(context) ? 1.0 : 1.6,
            mainAxisSpacing: Responsive.isLargeScreen(context) ? 30.0 : 10.0,
            crossAxisSpacing: Responsive.isLargeScreen(context) ? 30.0 : 10.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
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
                      Container(
                        padding: EdgeInsets.only(left: 05.0, top: 08.0),
                        child: Text(
                          'Elance',
                          style: TextStyle(
                              fontSize: 25.0,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 08.0, top: 30.0),
                    child: Row(
                      children: [
                        Icon(AntIcons.mail_outline,
                            color: Colors.grey, size: 20.0),
                        Padding(
                          padding: EdgeInsets.only(left: 05.0),
                          child: Text(
                            'support@elance.com',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 08.0, top: 20.0),
                    child: Row(
                      children: [
                        Icon(FeatherIcons.phone,
                            color: Colors.grey, size: 20.0),
                        Padding(
                          padding: EdgeInsets.only(left: 05.0),
                          child: Text(
                            '+251973393873',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 08.0, top: 20.0),
                    child: Row(
                      children: [
                        Icon(Ionicons.logo_whatsapp,
                            color: Colors.grey, size: 20.0),
                        Padding(
                          padding: EdgeInsets.only(left: 05.0),
                          child: Text(
                            '+251973393873',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 08.0, top: 22.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Help & Support',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 08.0, top: 22.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Upwork Foundation',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 08.0, top: 22.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 08.0, top: 22.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Terms of Service',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 08.0, top: 42.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 08.0, top: 22.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Feed Back',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 08.0, top: 15.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Community',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 08.0, top: 15.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Join us',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 08.0, top: 42.0),
                    child: Row(
                      children: [
                        Icon(AntIcons.facebook,
                            color: Colors.indigo, size: 20.0),
                        Padding(
                          padding: EdgeInsets.only(left: 05.0),
                          child: Text(
                            'Facebook',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 08.0, top: 20.0),
                    child: Row(
                      children: [
                        Icon(AntIcons.twitter_outline,
                            color: Colors.blue, size: 20.0),
                        Padding(
                          padding: EdgeInsets.only(left: 05.0),
                          child: Text(
                            'Twitter',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 08.0, top: 20.0),
                    child: Row(
                      children: [
                        Icon(AntIcons.linkedin,
                            color: Colors.indigo, size: 20.0),
                        Padding(
                          padding: EdgeInsets.only(left: 05.0),
                          child: Text(
                            'Linkedin',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(),
          Text("© 2021 - 2022 Elance® Global Inc.")
        ],
      ),
    );
  }
}

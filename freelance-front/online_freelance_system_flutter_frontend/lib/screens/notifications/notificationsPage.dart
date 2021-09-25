import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/footer.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/navbar.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [NavBar(), _body(context), Footer()],
      ),
    ));
  }

  Widget _body(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 2,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Notifications",
            style: blacksemiboldMediumTextStyle.copyWith(fontSize: 30),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: lightGrey, borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(text: TextSpan(text: "Notification 1")),
                      IconButton(onPressed: () {}, icon: Icon(Icons.close))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: lightGrey, borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(text: TextSpan(text: "Notification 1")),
                      IconButton(onPressed: () {}, icon: Icon(Icons.close))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: lightGrey, borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(text: TextSpan(text: "Notification 1")),
                      IconButton(onPressed: () {}, icon: Icon(Icons.close))
                    ],
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}

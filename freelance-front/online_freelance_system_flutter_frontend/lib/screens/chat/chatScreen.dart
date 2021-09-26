import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/footer.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/navbar.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/customRectFormField.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';
import 'package:online_freelance_system_flutter_frontend/utils/responsivelayout.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScrenState createState() => _ChatScrenState();
}

class _ChatScrenState extends State<ChatScreen> {
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
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Responsive.isLargeScreen(context)
          ? Row(
              children: [
                Container(
                    height: double.infinity,
                    color: Colors.grey.shade100,
                    width: Responsive.isMediumScreen(context)
                        ? MediaQuery.of(context).size.width * 0.2
                        : MediaQuery.of(context).size.width * 0.25,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomRectFormField(
                              hintText: "Search People Here .."),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(child: Text("Active")),
                              InkWell(child: Text("Unread(0)")),
                              InkWell(child: Text("Support")),
                              InkWell(child: Text("Archived")),
                            ],
                          ),
                        ),
                        Divider(),
                        _singleChat(),
                        _singleChat(),
                        _singleChat(),
                        _singleChat(),
                        _singleChat(),
                      ],
                    )),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat,
                          color: kPrimaryColor,
                          size: 28,
                        ),
                        Text(
                          "Welcome to your messages",
                          style:
                              blackboldMediumTextStyle.copyWith(fontSize: 25),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          : Container(
              height: double.infinity,
              color: Colors.grey.shade100,
              width: MediaQuery.of(context).size.width * 0.25,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        CustomRectFormField(hintText: "Search People Here .."),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(child: Text("Active")),
                        InkWell(child: Text("Unread(0)")),
                        InkWell(child: Text("Support")),
                        InkWell(child: Text("Archived")),
                      ],
                    ),
                  ),
                  Divider(),
                  _singleChat(),
                  _singleChat(),
                  _singleChat(),
                  _singleChat(),
                  _singleChat(),
                ],
              )),
    );
  }

  Widget _singleChat() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        padding: EdgeInsets.all(8),
        child: Row(children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage('/images/profile1.jfif'),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Asche Dorm Mate",
                    style: blackboldMediumTextStyle,
                  ),
                  Text(
                    "5:30 Am",
                  )
                ],
              ),
              RichText(
                text: TextSpan(text: "Hey , I am from aait how are you"),
              ),
            ],
          )
        ]));
  }
}

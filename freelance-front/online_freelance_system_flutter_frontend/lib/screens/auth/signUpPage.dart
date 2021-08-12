import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/customRoundButton.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/customRoundFormField.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_navBar(context), _formBody(context), _footer(context)],
          ),
        ),
      ),
    );
  }

  Widget _navBar(BuildContext context) {
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
                      SizedBox(width: 16),
                      Text(
                        "Elance",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ])));
  }

  Widget _footer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width,
      color: endodGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "© 2015 - 2021 ETWork Global Inc.",
            style: whitenavButtonTextStyle,
          ),
          Text(
            "Terms of Service",
            style: whitenavButtonTextStyle,
          ),
          Text(
            "Privacy And Policy",
            style: whitenavButtonTextStyle,
          ),
          Text(
            "Accesseblity",
            style: whitenavButtonTextStyle,
          )
        ],
      ),
    );
  }

  Widget _formBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      margin: EdgeInsets.all(60),
      padding: EdgeInsets.all(80),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: lightGrey, width: 2.0),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Container(
            child: Text("SignUp In Etwork"),
          ),
          CustomRoundFormField(
              hintText: "Username or Email", prefixIconData: Icons.person),
          CustomRoundFormField(
            hintText: "Password",
            prefixIconData: Icons.lock,
            suffixIconData: Icons.remove_red_eye,
          ),
          CustomRoundButton(
            title: "SignUp",
            checktitle: "signup",
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text('or',
                style: TextStyle(decoration: TextDecoration.overline)),
          ),
          CustomRoundButton(
            title: "Continue With Google",
            iconData: AntIcons.google,
            checktitle: "blue",
          ),
          CustomRoundButton(
            checktitle: "black",
            title: "Continue With Apple",
            iconData: AntIcons.apple,
          ),
          Divider(),
          Text(
            "Already Have An Account?",
            style: greenNavButtonTextStyle,
          ),
          CustomRoundButton(title: "LogIn", checktitle: "white")
        ],
      ),
    );
  }
}

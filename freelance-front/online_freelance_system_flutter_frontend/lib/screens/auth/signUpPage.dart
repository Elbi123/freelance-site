import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/auth_bloc/authBloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/auth_bloc/authEvent.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/auth_bloc/authState.dart';
import 'package:online_freelance_system_flutter_frontend/models/User.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/customRoundButton.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/customRoundFormField.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';
import 'package:online_freelance_system_flutter_frontend/utils/routeNames.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _user = {};

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
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: Row(
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
                    ),
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
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state.isAuthenticated) {
        Navigator.pushNamed(context, loginpageroute);
      } else {
        print("No Men");
      }
      return Container(
          width: MediaQuery.of(context).size.width / 3,
          margin: EdgeInsets.all(60),
          padding: EdgeInsets.all(80),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: lightGrey, width: 2.0),
              borderRadius: BorderRadius.circular(5)),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  child: Text("SignUp In Etwork"),
                ),
                CustomRoundFormField(
                  onSaved: (value) {
                    this._user['firstname'] = value;
                  },
                  hintText: "First Name",
                  prefixIconData: Icons.person,
                ),
                CustomRoundFormField(
                  onSaved: (value) {
                    this._user['lastname'] = value;
                  },
                  hintText: "Last Name",
                  prefixIconData: Icons.person,
                ),
                CustomRoundFormField(
                    onSaved: (value) {
                      this._user['username'] = value;
                    },
                    hintText: "Username",
                    prefixIconData: Icons.person),
                CustomRoundFormField(
                    onSaved: (value) {
                      this._user['email'] = value;
                    },
                    hintText: "@example.com",
                    prefixIconData: Icons.email),
                CustomRoundFormField(
                    onSaved: (value) {
                      this._user['phonenumber'] = value;
                    },
                    hintText: "Phone Number",
                    prefixIconData: Icons.phone),
                CustomRoundFormField(
                  onSaved: (value) {
                    this._user['password'] = value;
                  },
                  hintText: "Password",
                  prefixIconData: Icons.lock,
                  suffixIconData: Icons.remove_red_eye,
                ),
                CustomRoundButton(
                  onPressed: () {
                    final form = _formKey.currentState;

                    if (form!.validate()) {
                      form.save();
                      // print(this._user);
                      final AuthEvent event = AuthRegister(User(
                          userName: this._user["username"],
                          firstname: this._user["firstname"],
                          lastname: this._user["lastname"],
                          email: this._user["email"],
                          userType: "freelancer",
                          phonenumber: this._user["phonenumber"],
                          password: this._user["password"]));
                      BlocProvider.of<AuthBloc>(context).add(event);
                    }
                  },
                  title: "SignUp",
                  checktitle: "signup",
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text('or',
                      style: TextStyle(decoration: TextDecoration.overline)),
                ),
                CustomRoundButton(
                  onPressed: () {},
                  title: "Continue With Google",
                  iconData: AntIcons.google,
                  checktitle: "blue",
                ),
                CustomRoundButton(
                  onPressed: () {},
                  checktitle: "black",
                  title: "Continue With Apple",
                  iconData: AntIcons.apple,
                ),
                Divider(),
                Text(
                  "Already Have An Account?",
                  style: greenNavButtonTextStyle,
                ),
                CustomRoundButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    title: "LogIn",
                    checktitle: "secondary")
              ],
            ),
          ));
    });
  }
}

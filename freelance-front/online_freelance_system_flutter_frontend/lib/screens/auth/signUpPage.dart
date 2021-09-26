import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/auth_bloc/authBloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/auth_bloc/authEvent.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/auth_bloc/authState.dart';
import 'package:online_freelance_system_flutter_frontend/models/User.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/customRoundButton.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/customRoundFormField.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/dropDownList.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';
import 'package:online_freelance_system_flutter_frontend/utils/routeNames.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  static bool isLoading = false;
  static bool isFailed = false;
  final Map<String, dynamic> _user = {};
  FocusNode? fname, lname, username, email, phonenumber, password;
  @override
  void initState() {
    super.initState();
    isLoading = false;
    isFailed = false;
    fname = FocusNode();
    lname = FocusNode();
    username = FocusNode();
    email = FocusNode();
    phonenumber = FocusNode();
    password = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    fname!.dispose();
    lname!.dispose();
    username!.dispose();
    email!.dispose();
    phonenumber!.dispose();
    password!.dispose();
  }

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
      if (state.isRegistered) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, loginpageroute);
        });
      } else if (state.isRegisterFailed) {
        isFailed = true;
      } else if (state.isRegistering) {
        isLoading = true;
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
                Container(
                  child: isLoading
                      ? Text("Loading ....")
                      : isFailed
                          ? Text("SIgnup Failed !")
                          : Text(""),
                ),
                CustomRoundFormField(
                  isObscure: false,
                  fnode: fname,
                  nextFocus: lname,
                  onSaved: (value) {
                    setState(() {
                      this._user['firstname'] = value.toString();
                    });
                  },
                  hintText: "First Name",
                  prefixIconData: Icons.person,
                ),
                CustomRoundFormField(
                  isObscure: false,
                  fnode: lname,
                  nextFocus: username,
                  onSaved: (value) {
                    setState(() {
                      this._user['lastname'] = value.toString();
                    });
                  },
                  hintText: "Last Name",
                  prefixIconData: Icons.person,
                ),
                CustomRoundFormField(
                    isObscure: false,
                    nextFocus: email,
                    fnode: username,
                    onSaved: (value) {
                      setState(() {
                        this._user['username'] = value.toString();
                      });
                    },
                    hintText: "Username",
                    prefixIconData: Icons.person),
                CustomRoundFormField(
                    isObscure: false,
                    nextFocus: phonenumber,
                    fnode: email,
                    onSaved: (value) {
                      setState(() {
                        this._user['email'] = value.toString();
                      });
                    },
                    hintText: "example@example.com",
                    prefixIconData: Icons.email),
                CustomRoundFormField(
                    isObscure: false,
                    nextFocus: password,
                    fnode: phonenumber,
                    onSaved: (value) {
                      setState(() {
                        this._user['phonenumber'] = value.toString();
                      });
                    },
                    hintText: "Phone Number",
                    prefixIconData: Icons.phone),
                CustomDropDownList(
                  onChanged: (value) {
                    setState(() {
                      if (value.toString() == "Freelancer") {
                        this._user['userType'] = "freelancer";
                      } else if (value.toString() == "Customer") {
                        this._user['userType'] = 'customer';
                      } else {
                        this._user['userType'] = 'company';
                      }
                    });
                  },
                ),
                CustomRoundFormField(
                  isObscure: false,
                  nextFocus: null,
                  fnode: password,
                  onSaved: (value) {
                    setState(() {
                      this._user['password'] = value;
                    });
                  },
                  hintText: "Password",
                  prefixIconData: Icons.lock,
                  suffixIconData: Icons.remove_red_eye,
                ),
                CustomRoundButton(
                  onPressed: () {
                    print("Am Pressed");
                    final form = _formKey.currentState;
                    if (form!.validate()) {
                      form.save();
                      final AuthEvent event = AuthRegister(User(
                          userName: this._user["username"],
                          firstname: this._user["firstname"],
                          lastname: this._user["lastname"],
                          email: this._user["email"],
                          userType: this._user["userType"],
                          phonenumber: this._user["phonenumber"],
                          password: this._user["password"]));
                      print(this._user);
                      BlocProvider.of<AuthBloc>(context).add(event);
                    }
                    print(this._user);
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
                      Navigator.pushNamed(context, loginpageroute);
                    },
                    title: "LogIn",
                    checktitle: "secondary")
              ],
            ),
          ));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

class CustomRoundFormField extends StatefulWidget {
  final IconData? prefixIconData, suffixIconData;
  final String hintText;
  final bool isObscure;
  final double? width;
  final String? checkTitle;
  final FocusNode? fnode;
  final FocusNode? nextFocus;
  final TextEditingController? textEditingController;
  final void Function(String? value)? onSaved;
  const CustomRoundFormField(
      {Key? key,
      this.prefixIconData,
      this.suffixIconData,
      required this.hintText,
      this.width,
      this.textEditingController,
      this.fnode,
      required this.isObscure,
      this.nextFocus,
      this.checkTitle,
      this.onSaved})
      : super(key: key);

  @override
  _CustomRoundFormFieldState createState() => _CustomRoundFormFieldState();
}

class _CustomRoundFormFieldState extends State<CustomRoundFormField> {
  bool validate = false;

  @override
  void dispose() {
    // TODO: implement dispose
    this.widget.textEditingController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.widget.width,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            width: 0.5,
            color: customGrey,
          )),
      child: TextFormField(
        obscureText: this.widget.isObscure,
        focusNode: this.widget.fnode,
        onSaved: this.widget.onSaved,
        onFieldSubmitted: (term) {
          this.widget.fnode!.unfocus();
          FocusScope.of(context).requestFocus(this.widget.nextFocus);
        },
        decoration: InputDecoration(
            labelText: "${this.widget.hintText}",
            errorText: validate ? "Value Can't Be Empty" : null,
            prefixIcon: IconButton(
                onPressed: () {},
                iconSize: 18,
                icon: Icon(
                  this.widget.prefixIconData,
                  color: kPrimaryColor,
                )),
            suffixIcon: this.widget.suffixIconData != null
                ? IconButton(
                    onPressed: () {},
                    iconSize: 18,
                    icon: Icon(
                      this.widget.suffixIconData,
                      color: this.widget.checkTitle == "secondary"
                          ? kSecondaryColor
                          : kPrimaryColor,
                    ))
                : null,
            // hintText: "${this.widget.hintText}",
            border: InputBorder.none),
      ),
    );
  }

  String validatePassword(String value, String hintText) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "$hintText Can";
    }
    return "";
  }
}

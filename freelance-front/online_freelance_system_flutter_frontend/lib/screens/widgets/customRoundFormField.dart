import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

class CustomRoundFormField extends StatefulWidget {
  final IconData? prefixIconData, suffixIconData;
  final String hintText;
  final double? width;
  final String? checkTitle;
  final void Function(String? value)? onSaved;
  const CustomRoundFormField(
      {Key? key,
      this.prefixIconData,
      this.suffixIconData,
      required this.hintText,
      this.width,
      this.checkTitle,
      this.onSaved})
      : super(key: key);

  @override
  _CustomRoundFormFieldState createState() => _CustomRoundFormFieldState();
}

class _CustomRoundFormFieldState extends State<CustomRoundFormField> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        this.widget.hintText == "";
      } else {
        this.widget.hintText == this.widget.hintText;
      }
      // setState(() {});
    });
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
        focusNode: focusNode,
        onSaved: this.widget.onSaved,
        decoration: InputDecoration(
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
            hintText: "${this.widget.hintText}",
            border: InputBorder.none),
      ),
    );
  }
}

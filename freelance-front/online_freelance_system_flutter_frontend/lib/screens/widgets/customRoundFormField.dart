import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

class CustomRoundFormField extends StatelessWidget {
  final IconData? prefixIconData, suffixIconData;
  final String hintText;
  final double? width;
  final String? checkTitle;
  const CustomRoundFormField(
      {Key? key,
      this.prefixIconData,
      this.suffixIconData,
      required this.hintText,
      this.width,
      this.checkTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            width: 0.5,
            color: customGrey,
          )),
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: IconButton(
                onPressed: () {},
                iconSize: 18,
                icon: Icon(
                  prefixIconData,
                  color: kPrimaryColor,
                )),
            suffixIcon: suffixIconData != null
                ? IconButton(
                    onPressed: () {},
                    iconSize: 18,
                    icon: Icon(
                      suffixIconData,
                      color: checkTitle == "secondary"
                          ? kSecondaryColor
                          : kPrimaryColor,
                    ))
                : null,
            hintText: "$hintText",
            border: InputBorder.none),
      ),
    );
  }
}

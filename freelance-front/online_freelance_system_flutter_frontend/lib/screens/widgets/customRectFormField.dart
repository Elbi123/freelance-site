import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

class CustomRectFormField extends StatelessWidget {
  final IconData? prefixIconData, suffixIconData;
  final String hintText;
  final double? width;
  const CustomRectFormField(
      {Key? key,
      this.prefixIconData,
      this.suffixIconData,
      required this.hintText,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            width: 0.5,
            color: lightGrey,
          )),
      child: Center(
        child: TextField(
          decoration: InputDecoration(
              suffixIcon: suffixIconData != null
                  ? Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5))),
                      child: IconButton(
                          onPressed: () {},
                          iconSize: 18,
                          icon: Icon(
                            suffixIconData,
                            color: Colors.white,
                          )),
                    )
                  : null,
              hintText: "$hintText",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none),
        ),
      ),
    );
  }
}

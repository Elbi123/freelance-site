import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

class CustomAddLink extends StatelessWidget {
  const CustomAddLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        children: [
          Icon(
            AntIcons.plus_circle,
            color: kPrimaryColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                "Add Linked Social \n  Account +10% ",
                style: blackboldMediumTextStyle.copyWith(
                    color: kPrimaryColor, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

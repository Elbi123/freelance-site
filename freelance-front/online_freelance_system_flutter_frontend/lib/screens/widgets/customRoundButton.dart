import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

class CustomRoundButton extends StatelessWidget {
  final String title;
  final String checktitle;
  final IconData? iconData;
  const CustomRoundButton(
      {Key? key, required this.title, this.iconData, required this.checktitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (value) {},
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: checktitle == "blue"
                ? blueBg
                : checktitle == "secondary"
                    ? kSecondaryColor
                    : checktitle == "black"
                        ? whiteBg
                        : checktitle == "white"
                            ? Colors.white
                            : kPrimaryColor,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              width: 0.5,
              color: checktitle == "secondary"
                  ? kSecondaryColor
                  : checktitle == "white"
                      ? kPrimaryColor
                      : customGrey,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconData != null
                ? Icon(iconData,
                    color: checktitle == "black" ? Colors.black : Colors.white)
                : Container(),
            SizedBox(
              width: 20,
            ),
            Text(
              "$title",
              style: TextStyle(
                  color: checktitle == "black"
                      ? Colors.black
                      : checktitle == "white"
                          ? kPrimaryColor
                          : Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

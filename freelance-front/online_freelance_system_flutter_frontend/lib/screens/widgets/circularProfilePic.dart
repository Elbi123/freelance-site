import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

class CustomCircularPicture extends StatelessWidget {
  final String imageaddres;

  const CustomCircularPicture({Key? key, required this.imageaddres})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: kSecondaryColor, width: 3),
          borderRadius: BorderRadius.circular(30)),
      child: CircleAvatar(
        radius: 23,
        backgroundImage: AssetImage(imageaddres),
      ),
    );
  }
}

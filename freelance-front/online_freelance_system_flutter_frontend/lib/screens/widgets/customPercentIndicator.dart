import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CustomPercentIndicator extends StatefulWidget {
  final double percentAmount;
  const CustomPercentIndicator({Key? key, required this.percentAmount})
      : super(key: key);

  @override
  _CustomPercentIndicatorState createState() => _CustomPercentIndicatorState();
}

class _CustomPercentIndicatorState extends State<CustomPercentIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: LinearPercentIndicator(
        animation: true,
        animationDuration: 3000,
        lineHeight: 5,
        percent: widget.percentAmount / 100,
        progressColor: kPrimaryColor,
        linearStrokeCap: LinearStrokeCap.roundAll,
        trailing: Text(
          "${widget.percentAmount}%",
          style: TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
    );
  }
}

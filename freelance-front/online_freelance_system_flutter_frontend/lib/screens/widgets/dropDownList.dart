import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

class CustomDropDownList extends StatefulWidget {
  final void Function(String? value) onChanged;
  final double? width;

  const CustomDropDownList({Key? key, required this.onChanged, this.width})
      : super(key: key);

  @override
  _CustomDropDownListState createState() => _CustomDropDownListState();
}

class _CustomDropDownListState extends State<CustomDropDownList> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: kPrimaryColor,
      underline: Text(""),
      hint: Text("User Type"),
      items: <String>['Freelancer', 'Customer', 'User'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: this.widget.onChanged,
    );
  }
}

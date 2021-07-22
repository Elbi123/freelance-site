import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Constants.endodGreen,
      // width: MediaQuery.of(context).size.width,
      height: 300,
      child: Column(
        children: [
          Stack(
            fit: StackFit.expand,
            children: [
              FractionallySizedBox(
                  widthFactor: 3,
                  child: Column(
                    children: [
                      Center(
                        child: Text("For Clients"),
                      ),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                    ],
                  )),
              FractionallySizedBox(
                  widthFactor: 3,
                  child: Column(
                    children: [
                      Center(
                        child: Text("For Clients"),
                      ),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                    ],
                  )),
              FractionallySizedBox(
                  widthFactor: 3,
                  child: Column(
                    children: [
                      Center(
                        child: Text("For Clients"),
                      ),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                    ],
                  )),
              FractionallySizedBox(
                  widthFactor: 3,
                  child: Column(
                    children: [
                      Center(
                        child: Text("For Clients"),
                      ),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                      Text("How To Hire"),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

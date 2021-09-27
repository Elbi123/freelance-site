import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/models/jobs/Job.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';
import 'package:online_freelance_system_flutter_frontend/utils/responsivelayout.dart';
import 'package:online_freelance_system_flutter_frontend/utils/routeNames.dart';
import 'package:online_freelance_system_flutter_frontend/utils/routes.dart';

class FeedsItemDetail extends StatefulWidget {
  final Job jobs;
  // final String title, jobType, description, proposal;

  const FeedsItemDetail({Key? key, required this.jobs}) : super(key: key);

  @override
  _FeedsItemDetailState createState() => _FeedsItemDetailState();
}

class _FeedsItemDetailState extends State<FeedsItemDetail> {
  @override
  Widget build(BuildContext context) {
    print(widget.jobs.status);
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: MediaQuery.of(context).size.height,
        margin: Responsive.isLargeScreen(context)
            ? EdgeInsets.only(top: 50, left: 200, right: 150)
            : EdgeInsets.all(0),
        decoration: BoxDecoration(
            border: Border.all(color: lightGrey),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 80,
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(color: lightGrey))),
                    child: Text(
                      "${widget.jobs.title}",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(color: lightGrey))),
                    child: Row(
                      children: [
                        Text(
                          "Job Type :",
                          style: TextStyle(
                              fontSize: 15,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          widget.jobs.type,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ],
                    )),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(color: lightGrey))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " Description : ",
                        style: feedDetailTextStyle.copyWith(
                            // fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: kPrimaryColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8),
                        child: RichText(
                            text: TextSpan(
                          text: widget.jobs.description,
                          style: feedDetailTextStyle.copyWith(
                              // fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: Colors.black),
                        )),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(color: lightGrey))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        " Proposals : ",
                        style: feedDetailTextStyle.copyWith(
                            // fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: kPrimaryColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                            text: TextSpan(
                          text: widget.jobs.status,
                          style: feedDetailTextStyle.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: Colors.black),
                        )),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(color: lightGrey))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " Location : ",
                        style: feedDetailTextStyle.copyWith(
                            // fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: kPrimaryColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                            text: TextSpan(
                          text: widget.jobs.customer.address.country +
                              widget.jobs.customer.address.city,
                          style: feedDetailTextStyle.copyWith(
                              // fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: Colors.black),
                        )),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(color: lightGrey))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Language: ",
                        style: feedDetailTextStyle.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: kPrimaryColor),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(widget.jobs.languages.toString()),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(submitproposalroute,
                        arguments: FeedsDetailArgument(widget.jobs));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 5,
                    height: 50,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 0.5, color: kSecondaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Submit Proposal",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 5,
                  height: 50,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 1, color: kPrimaryColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 20),
                      Icon(
                        AntIcons.heart,
                        color: kPrimaryColor,
                      ),
                      Text(
                        "Save Job",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}

import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/models/jobs/Job.dart';
import 'package:online_freelance_system_flutter_frontend/screens/feeds/feedsItemDetail.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

class FeedsItemCard extends StatefulWidget {
  final dynamic jobs;
  final double? width;

  const FeedsItemCard({
    Key? key,
    required this.jobs,
    this.width,
  }) : super(key: key);

  @override
  _FeedsItemCardState createState() => _FeedsItemCardState();
}

class _FeedsItemCardState extends State<FeedsItemCard> {
  final String submittedProposals = " Less Than 5";
  final String numberOfFreelancer = "2";
  final String professionality = " Entry Level";
  String? firstHalf;
  String? secondHalf;
  bool flag = true;
  bool? favorite, like;

  @override
  void initState() {
    super.initState();
    favorite = false;
    like = false;
    if (widget.jobs.description.length > 300) {
      firstHalf = widget.jobs.description.substring(0, 300);
      secondHalf = widget.jobs.description
          .substring(300, widget.jobs.description.length);
    } else {
      firstHalf = widget.jobs.description;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      // height: 270,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return FeedsItemDetail(
                            jobs: widget.jobs,
                          );
                        });
                  },
                  child: RichText(
                      text: TextSpan(
                    text: widget.jobs.title,
                    style: feedLinksTextStyle.copyWith(
                        fontWeight: FontWeight.w900, fontSize: 18),
                  )),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (like == true) {
                              like = false;
                            } else {
                              like = true;
                            }
                          });
                        },
                        icon: Icon(
                          like == true ? AntIcons.like : AntIcons.like_outline,
                          color: kPrimaryColor,
                        )),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (favorite == true) {
                              favorite = false;
                            } else {
                              favorite = true;
                            }
                          });
                        },
                        icon: Icon(
                          favorite == true
                              ? AntIcons.heart
                              : AntIcons.heart_outline,
                          color: kPrimaryColor,
                        ))
                  ],
                )
              ],
            ),
          ),
          Text(
            "Job Type :${widget.jobs.type}",
            style: blackboldMediumTextStyle,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: RichText(
                text: TextSpan(
                    style: blacksemiboldMediumTextStyle,
                    text: flag
                        ? ("$firstHalf ...")
                        : ("$firstHalf  $secondHalf"))),
          ),
          InkWell(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(
                  flag ? "show more" : "show less",
                  style: new TextStyle(color: Colors.blue),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
          ),
          Row(
            children: [
              Text(
                "Proposals  :$submittedProposals",
                style: boldbluredMediumTextStyle,
              ),
              SizedBox(
                width: 20,
              ),
              Text("Number Of Freelace Needed :$numberOfFreelancer")
            ],
          ),
          Row(
            children: [
              Text("Location  :${widget.jobs.address}"),
              SizedBox(
                width: 20,
              ),
              Text("Proffesionality :$professionality")
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}

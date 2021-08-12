import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:online_freelance_system_flutter_frontend/screens/feeds/feedsItemDetail.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

class FeedsItemCard extends StatefulWidget {
  final double? width;
  const FeedsItemCard({Key? key, this.width}) : super(key: key);

  @override
  _FeedsItemCardState createState() => _FeedsItemCardState();
}

class _FeedsItemCardState extends State<FeedsItemCard> {
  String description =
      "We are a growing IT company and we are looking for a Full Stack Developer for our company. This is full time role and we are looking for a suitable candidates who can grow with our company. Kindly submit your proposal with your rates. Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book it has? Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book it has?";
  String title = "Full Stack Developer & IOS Developer.";
  String jobType = "Houry";
  String submittedProposals = " Less Than 5";
  String numberOfFreelancer = "2";
  String location = " Ethiopia , Addis Ababa";
  String professionality = " Entry Level";
  String? firstHalf;
  String? secondHalf;
  bool flag = true;
  bool? favorite, like;

  @override
  void initState() {
    super.initState();
    favorite = false;
    like = false;
    if (description.length > 300) {
      firstHalf = description.substring(0, 300);
      secondHalf = description.substring(300, description.length);
    } else {
      firstHalf = description;
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
                            title: title,
                            description: description,
                            jobType: jobType,
                            proposals: submittedProposals,
                            numOfFreelanceNeeded: numberOfFreelancer,
                            location: location,
                            professionality: professionality,
                          );
                        });
                  },
                  child: RichText(
                      text: TextSpan(
                    text: title,
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
            "Job Type :$jobType",
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
              Text("Location  :$location"),
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

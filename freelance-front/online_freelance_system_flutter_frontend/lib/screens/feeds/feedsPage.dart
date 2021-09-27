import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/jobs_bloc/jobBloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/jobs_bloc/jobState.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/circularProfilePic.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/customAddLink.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/customPercentIndicator.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/customRectFormField.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/feedsItemCard.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';
import 'package:online_freelance_system_flutter_frontend/utils/responsivelayout.dart';

class FeedsPage extends StatefulWidget {
  const FeedsPage({Key? key}) : super(key: key);

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<FeedsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 50),
      child: SingleChildScrollView(
          child: Responsive.isLargeScreen(context)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [leftContent(), centerContent(), rightContent()],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [centerContent()],
                )),
    );
  }

  Widget leftContent() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 60),
          child: Text(
            "Find Work ",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            "Best Matches",
            style: blackboldMediumTextStyle.copyWith(fontSize: 16),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            "Most Recent ",
            style: blackboldMediumTextStyle.copyWith(fontSize: 16),
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            // alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 25, bottom: 15),
            child: Text(
              "My Categories",
              style: feedLinksTextStyle.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: Colors.black),
            ),
          ),
          Text(
            "Category 1",
            style: primarysemiboldMediumTextStyle,
          ),
          Text(
            "Category 2",
            style: primarysemiboldMediumTextStyle,
          ),
          Text(
            "Category 3",
            style: primarysemiboldMediumTextStyle,
          ),
          Text(
            "Category 4",
            style: primarysemiboldMediumTextStyle,
          ),
          Text(
            "Category 5",
            style: primarysemiboldMediumTextStyle,
          ),
          Text(
            "Category 6",
            style: primarysemiboldMediumTextStyle,
          ),
        ])
      ],
    );
  }

  Widget centerContent() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Responsive.isLargeScreen(context)
              ? CustomRectFormField(
                  hintText: "Search Here .....",
                  width: Responsive.isMobileScreen(context)
                      ? MediaQuery.of(context).size.width / 1.05
                      : MediaQuery.of(context).size.width / 2,
                  suffixIconData: Icons.search,
                )
              : Container(),
          Responsive.isLargeScreen(context)
              ? GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Advanced Search",
                      style: greenNavButtonTextStyle.copyWith(
                          color: kSecondaryColor),
                    ),
                  ),
                )
              : Container(),
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Responsive.isMediumScreen(context) ? 20 : 0),
              padding: EdgeInsets.symmetric(
                  vertical: !Responsive.isLargeScreen(context) ? 10 : 20,
                  horizontal: Responsive.isMediumScreen(context) ? 10 : 0),
              width: Responsive.isMobileScreen(context)
                  ? MediaQuery.of(context).size.width
                  : Responsive.isMediumScreen(context)
                      ? MediaQuery.of(context).size.width / 1.1
                      : MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: lightGrey),
                  borderRadius: BorderRadius.circular(2)),
              child: BlocBuilder<JobsBloc, JobsState>(builder: (_, state) {
                if (state is JobsOperationFailed) {
                  return Center(
                    child: Container(
                      child: Text("Can't Load Job Feeds Try Again Later."),
                    ),
                  );
                } else if (state is JobsLoadSuccess) {
                  final jobs = state.job;
                  if (jobs.length == 0) {
                    return Center(
                        child: Text(
                      "Sorry Their Is No Any Job Post For Now.",
                      style: boldbluredMediumTextStyle.copyWith(fontSize: 15),
                    ));
                  } else {
                    // print(jobs.length);
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: jobs.length,
                        itemBuilder: (context, index) {
                          return FeedsItemCard(jobs: jobs[index], index: index);
                        });
                  }
                }
                return Container(
                    child: Center(
                        child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 30.0,
                  width: 30.0,
                )));
              })),
          BlocBuilder<JobsBloc, JobsState>(builder: (_, state) {
            if (state is JobsLoadSuccess) {
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Load More ... ",
                    style:
                        blackboldMediumTextStyle.copyWith(color: kPrimaryColor),
                  ),
                ),
              );
            }
            return Text("");
          })
        ],
      ),
    );
  }

  Widget rightContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 90,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomCircularPicture(imageaddres: "/images/profile1.jfif"),
            SizedBox(
              width: 10,
            ),
            Text("My Profile",
                style: blackboldMediumTextStyle.copyWith(fontSize: 18))
          ],
        ),
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              Icon(
                Icons.remove_red_eye,
                color: kPrimaryColor,
              ),
              Text(
                "View Profile ",
                style: blackboldMediumTextStyle.copyWith(color: kPrimaryColor),
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hours ",
                  style: blackboldMediumTextStyle.copyWith(fontSize: 17),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        AntIcons.clock_circle_outline,
                      ),
                    ),
                    Text("More than  \n 30hrs/week"),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CircleAvatar(
                          backgroundColor: white,
                          child: Icon(
                            Icons.edit_outlined,
                            color: Colors.black,
                          )),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Profile Completion ",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                CustomPercentIndicator(percentAmount: 80),
                CustomAddLink(),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                      child: Text(
                        "Project Catalog",
                        style: blackboldMediumTextStyle,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.book,
                          color: kPrimaryColor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "My Project \n Dashboard",
                            style: blacksemiboldMediumTextStyle.copyWith(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 10),
                    child: Text(
                      "Proposals",
                      style: blackboldMediumTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "No Proposals For Now",
                      style: blacksemiboldMediumTextStyle.copyWith(
                          color: kPrimaryColor),
                    ),
                  ),
                ])
              ],
            ))
      ],
    );
  }
}

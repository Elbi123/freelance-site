import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_freelance_system_flutter_frontend/models/jobs/Job.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/footer.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/navbar.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/customDrawer.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/customRoundButton.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';
import 'package:online_freelance_system_flutter_frontend/utils/menuController.dart';

class SubmitProposalPage extends StatefulWidget {
  final Job feedsDetail;
  const SubmitProposalPage({
    Key? key,
    required this.feedsDetail,
  }) : super(key: key);

  @override
  _SubmitProposalState createState() => _SubmitProposalState();
}

class _SubmitProposalState extends State<SubmitProposalPage> {
  MenuController _controller = Get.put(MenuController());
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: shiroColor,
        key: _controller.scaffoldkey,
        drawer: SideMenu(),
        body: SingleChildScrollView(
          child: Column(
            children: [NavBar(), _body(context), Footer()],
          ),
        ));
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
      child: Column(
        children: [
          Container(
            child: Text(
              "Submit Proposal",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                border: Border.all(color: shiroColor, width: 1),
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text("Job Detail",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),
                Divider(),
                Container(
                  decoration: BoxDecoration(),
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "${widget.feedsDetail.title}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "${widget.feedsDetail.description}",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "${widget.feedsDetail.type}",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "${widget.feedsDetail.customer.address.country} , ${widget.feedsDetail.customer.address.city}",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "${widget.feedsDetail.languages}",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "${widget.feedsDetail.createdAt}",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: shiroColor, width: 1),
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("How Long Does It Take",
                    style: blacksemiboldMediumTextStyle.copyWith(fontSize: 20)),
                Divider(),
                DropdownButton<String>(
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    value: dropdownValue,
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: lightGrey,
                    ),
                    items: <String>['One', 'Two', 'Three']
                        .map<DropdownMenuItem<String>>((e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)))
                        .toList())
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: shiroColor, width: 1),
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Additional Detail",
                    style: blacksemiboldMediumTextStyle.copyWith(fontSize: 20)),
                Divider(),
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Cover Letter \n",
                        style: blacksemiboldMediumTextStyle),
                    TextSpan(
                        text:
                            "Introduce yourself and explain why you’re a strong candidate for this job. Feel free to suggest any changes to the job details or ask to schedule a video call.",
                        style: blacksemiboldMediumTextStyle)
                  ],
                )),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autofillHints: Iterable.empty(),
                  decoration: InputDecoration(
                      hintText: "Cover Letter",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  minLines: 3,
                ),
                CustomRoundButton(
                  onPressed: () {},
                  title: "Attach File",
                  checktitle: "blue",
                  iconData: Icons.attach_file,
                ),
                Divider(),
                Row(
                  children: [
                    CustomRoundButton(
                        onPressed: () {},
                        title: "Submit Proposal     ",
                        checktitle: "secondary"),
                    SizedBox(
                      width: 20,
                    ),
                    CustomRoundButton(
                        onPressed: () {},
                        title: "Cancel    ",
                        checktitle: "white")
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

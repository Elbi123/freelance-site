import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/footer.dart';
import 'package:online_freelance_system_flutter_frontend/screens/components/navbar.dart';
import 'package:online_freelance_system_flutter_frontend/screens/feeds/feedsPage.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/customDrawer.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';
import 'package:online_freelance_system_flutter_frontend/utils/menuController.dart';

class HomePage extends StatelessWidget {
  final MenuController _controller = Get.put(MenuController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: shiroColor,
        key: _controller.scaffoldkey,
        drawer: SideMenu(),
        body: SingleChildScrollView(
          child: Column(
            children: [NavBar(), FeedsPage(), Footer()],
          ),
        ));
  }
}

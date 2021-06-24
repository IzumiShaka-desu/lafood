import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lafoody/constant/color_palette.dart';
import 'package:lafoody/presentation/view/screens/home.dart';
import 'package:lafoody/presentation/view/screens/login.dart';
import 'package:lafoody/presentation/viewmodel/auth_viewmodel.dart';

class PageContainer extends StatelessWidget {
  final AuthViewmodel _authController = Get.find(tag: "ac");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Obx(
        () => Container(
          decoration: BoxDecoration(gradient: ColorPalette.backgroundGradient),
          child: _authController.loginStatus.isNull
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _authController.loginStatus.value
                  ? Home()
                  : Login(),
        ),
      ),
    );
  }
}

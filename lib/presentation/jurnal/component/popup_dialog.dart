import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';

class PopUpDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  PopUpDialog({
    required this.title,
    required this.content,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: widthScreen * 0.8,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Primary.blue100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  spaceHeightExtraSmall,
                  Text(
                    title,
                    style: AppTextStyle.tsTitleBold(Primary.black),
                  ),
                  spaceHeightExtraSmall,
                  Text(
                    content,
                    style: AppTextStyle.tsBodyRegular(Primary.black),
                    textAlign: TextAlign.center,
                  ),
                  spaceHeightNormal,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: actions,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -50,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Primary.blue100,
              child: Image.asset(
                'lib/infrastructure/assets/icons8-login-100.png',
                scale: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showCustomPopupDialog(String title, String content, List<Widget> actions) {
  Get.dialog(
    PopUpDialog(
      title: title,
      content: content,
      actions: actions,
    ),
  );
}

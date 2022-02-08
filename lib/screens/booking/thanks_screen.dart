import 'package:flutter/material.dart';
import 'package:pet_groom/core/screen_utils.dart';
import 'package:pet_groom/shared/app_colors.dart';
import 'package:pet_groom/shared/button_widget.dart';
import 'package:pet_groom/shared/header_text.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThanksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Image.asset(
              "assets/images/thumbs-up.png",
              height: 220,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "${AppLocalizations.of(context)?.thankyou_service}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 1.3,
                  wordSpacing: 3,
                  fontSize: 22,
                  color: AppColor.font_header,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "${AppLocalizations.of(context)?.you_will_get}",
              textAlign: TextAlign.center,
              style: TextStyle(letterSpacing: 1.1, wordSpacing: 2),
            ),
            SizedBox(
              height: 20.h,
            ),
            AppPrimaryButton(
              onPress: () {
                Navigator.pop(context);
              },
              text: '${AppLocalizations.of(context)?.goto_home}',
              fontsize: 14,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

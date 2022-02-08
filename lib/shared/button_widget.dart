import 'package:flutter/material.dart';
import 'package:pet_groom/core/screen_utils.dart';
import 'package:pet_groom/shared/app_colors.dart';



class AppPrimaryButton extends StatelessWidget {
  final double? height;
  final double? width;

  final VoidCallback  onPress;
  final String text;
  Color color;
  double fontsize;
   AppPrimaryButton({
    Key? key,
    required this.text,
    required this.onPress,
    this.height,
    this.width,
     this.color=AppColor.btn_color,
     this.fontsize=24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 5,
      onPressed: onPress,
      child: Container(
        width: width??220,
        height: height ?? 40,
        decoration: BoxDecoration(
        color: color,
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            )),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: fontsize),
        ),
      ),
    );
  }
}


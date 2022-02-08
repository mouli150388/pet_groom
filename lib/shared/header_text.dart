
import 'package:flutter/cupertino.dart';
import 'package:pet_groom/shared/app_colors.dart';

class HeaderText extends StatelessWidget{
  String text;
  HeaderText({required this.text});
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(text,style: TextStyle(fontSize: 22,color: AppColor.font_header,fontWeight: FontWeight.bold),),
    );
  }

}
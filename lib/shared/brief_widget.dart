import 'package:flutter/material.dart';

class Briefs extends StatelessWidget {
  final String title, subtitle;

  Briefs({required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _width * 0.15,
      width: _width * 0.15,
      alignment: Alignment.center,
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.symmetric(
        horizontal: _width * 0.02,
        vertical: _width * 0.03,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            /*style: GoogleFonts.mukta(
              color: Colors.orange,
              fontWeight: FontWeight.w700,
            ),*/
          ),
          SizedBox(height: 2),
          Text(
            subtitle,
            /*style: GoogleFonts.mukta(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),*/
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final Widget child;
   double? width=120;
  final double height;
   Color? color;
   Color? highlightColor;
   Color? splashColor;
   Gradient? gradient;
   BorderRadius? radius;
  VoidCallback  onPressed;
   BoxBorder? border;
   EdgeInsets? padding;
   EdgeInsets? margin;

  /// DialogButton constructor
  DialogButton({
    Key? key,
    required this.child,
     this.width,
    this.height = 40.0,
     this.color,
     this.highlightColor,
     this.splashColor,
     this.gradient,
     this.radius,
     this.border,
    this.padding = const EdgeInsets.only(left: 6, right: 6),
    this.margin = const EdgeInsets.all(6),
    required this.onPressed,
  }) : super(key: key);

  /// Creates alert buttons based on constructor params
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).accentColor,
          gradient: gradient,
          borderRadius: radius ?? BorderRadius.circular(6),
          border: border ?? Border.all(color: Colors.transparent, width: 0)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: highlightColor ?? Theme.of(context).highlightColor,
          splashColor: splashColor ?? Theme.of(context).splashColor,
          onTap: onPressed,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
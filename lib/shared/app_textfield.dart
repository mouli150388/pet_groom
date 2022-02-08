import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_groom/shared/app_colors.dart';

class AppTextFormField extends StatelessWidget{
  final TextEditingController? controller;
  final String hintText;
  final bool enable;
  final bool autofocus;
  final bool obscureText;
  final bool isLimit;
  final int  limitCount;
  final TextInputType? textInputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  //TODO below and make neccessary
  // final SvgPicture? prefixIcon;
  // final SvgPicture? suffixIcon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? errorText;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? formatter;

  const AppTextFormField({
    Key? key,
    required this.hintText,
    this.controller,
    this.enable = true,
    this.isLimit = false,
    this.limitCount = 0,
    this.autofocus = false,
    this.obscureText = false,

    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.errorText,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.formatter,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(


      controller: controller,
      enabled: enable,

      autofocus: autofocus,
      obscureText: obscureText,
      obscuringCharacter: '*',
      onChanged: onChanged,
      validator: validator,
      style: TextStyle(color: Colors.black),
      inputFormatters: formatter,
      maxLength: (isLimit)?limitCount:100,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: InputDecoration(
        filled: true,
        fillColor
            : AppColor.white,
        focusColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black),
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: errorText != null
                ? AppColor.errorColor
                : Colors.white12
            ,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: errorText != null
                ? AppColor.errorColor
                : Colors.white12,
            width: 2.0,
          ),
        ),
      ),
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      keyboardType: textInputType,
    );/*Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          enabled: enable,
          focusNode: focusNode
            ..removeListener(() {
              setState(() {});
            })
            ..addListener(() {
              setState(() {});
            }),
          autofocus: autofocus,
          obscureText: obscureText,
          obscuringCharacter: '*',
          onChanged: onChanged,
          validator: validator,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: AppColor.white,
              ),
          inputFormatters: formatter,
          decoration: InputDecoration(
            filled: true,
            fillColor: focusNode.hasFocus
                ? Colors.white
                : AppColor.white,
            focusColor: Colors.white,
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: AppColor.white,
                ),
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: errorText != null
                    ? AppColor.errorColor
                    : Colors.white12
                        ,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: errorText != null
                    ? AppColor.errorColor
                    : Colors.white12,
                width: 2.0,
              ),
            ),
          ),
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          keyboardType: textInputType,
        ),
        if (errorText != null)
          Text(
            errorText!,
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: AppColor.errorColor,
                ),
          ),
      ],
    )*/;
  }
}
/*
class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(


      controller: controller,
      enabled: enable,
      focusNode: focusNode!
        ..removeListener(() {
          setState(() {});
        })
        ..addListener(() {
          setState(() {});
        }),
      autofocus: autofocus,
      obscureText: obscureText,
      obscuringCharacter: '*',
      onChanged: onChanged,
      validator: validator,
      style: TextStyle(color: Colors.black),
      inputFormatters: formatter,
      decoration: InputDecoration(
        filled: true,
        fillColor: focusNode!.hasFocus
            ? Colors.white
            : AppColor.white,
        focusColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black),
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: errorText != null
                ? AppColor.errorColor
                : Colors.white12
            ,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: errorText != null
                ? AppColor.errorColor
                : Colors.white12,
            width: 2.0,
          ),
        ),
      ),
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      keyboardType: textInputType,
    );*//*Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          enabled: enable,
          focusNode: focusNode
            ..removeListener(() {
              setState(() {});
            })
            ..addListener(() {
              setState(() {});
            }),
          autofocus: autofocus,
          obscureText: obscureText,
          obscuringCharacter: '*',
          onChanged: onChanged,
          validator: validator,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: AppColor.white,
              ),
          inputFormatters: formatter,
          decoration: InputDecoration(
            filled: true,
            fillColor: focusNode.hasFocus
                ? Colors.white
                : AppColor.white,
            focusColor: Colors.white,
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: AppColor.white,
                ),
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: errorText != null
                    ? AppColor.errorColor
                    : Colors.white12
                        ,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: errorText != null
                    ? AppColor.errorColor
                    : Colors.white12,
                width: 2.0,
              ),
            ),
          ),
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          keyboardType: textInputType,
        ),
        if (errorText != null)
          Text(
            errorText!,
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: AppColor.errorColor,
                ),
          ),
      ],
    )*//*;
  }
}*/

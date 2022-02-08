import 'package:flutter/material.dart';



extension WidgetConstraintExtensions on Widget {
  Container setMargins(EdgeInsets edgeInsets) {
    return Container(
      margin: edgeInsets,
      child: this,
    );
  }

  Container setMarginSymmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) =>
      setMargins(EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ));

  Container setMarginOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      setMargins(EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ));

  Padding setPadding(EdgeInsets edgeInsets) => Padding(
        padding: edgeInsets,
        child: this,
      );

  Padding setPaddingSymmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) =>
      setPadding(EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ));

  Padding setPaddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      setPadding(EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ));

  Center centered() => Center(
        child: this,
      );

  SafeArea safely() => SafeArea(
        child: this,
      );
}

extension IntConstraints on int {
  int get intAlt => (this == 0) ? 1 : 0;
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

extension CheckNullConvertExtension on dynamic {
  String convertToString() {
    return this != null ? toString() : '';
  }

  num convertToNum() {
    return this != null ? this as num : 0;
  }
}

extension StringExtension on String {
  String intelliTrim() {
    return length > 15 ? '${substring(0, 15)}...' : this;
  }

 /* String t(BuildContext context) {
    return AppLocalizations.of(context)?.translate(this) ?? '';
  }*/

  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidPassword() {
    return (isNotEmpty)&&(length>3);
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])')
        .hasMatch(this);
  }

  bool isValidName() {
    return isNotEmpty;
  }
  bool isValidNUmber() {
    return (isNotEmpty)&&(length>9);
  }
  bool isValidDob() {
    return isNotEmpty;
  }

// bool hasUpperLowerCase() {
//   return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])').hasMatch(this);
// }
//
// bool hasDigits() {
//   return RegExp(r'(?=.*?[0-9])').hasMatch(this);
// }
//
// bool hasSpecialCharacters() {
//   return RegExp(r'(?=.*?[!@#$&*~])').hasMatch(this);
// }
}

import 'package:flutter/material.dart';

import '../Utils/colors_util.dart';

class VVGradientButton extends StatelessWidget {
  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  // ignore: non_constant_identifier_names
  final double width;
  final double height;
  final Function onPressed;

  const VVGradientButton(
      {Key key,
      this.label,
      this.fontSize,
      this.fontWeight,
      this.textColor,
      this.width,
      this.height,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          // side: BorderSide(width: 1, color: Colors.white),
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: AppGradientColor,
            borderRadius: BorderRadius.circular(30)),
        child: Container(
          width: width ?? MediaQuery.of(context).size.width * .5,
          height: height ?? 50,
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: fontSize ?? 25,
                fontWeight: fontWeight == null ? FontWeight.w500 : fontWeight),
          ),
        ),
      ),
    );
  }
}

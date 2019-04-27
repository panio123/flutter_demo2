import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color color;
  final Color textColor;
  final Widget child;
  final double width;
  final double height;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;
  final Function onTap;
  final Color disabledColor;

  Button({
    this.color,
    this.textColor,
    this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.padding,
    this.onTap,
    this.disabledColor,
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(5.0),
      child: Material(
        color: color ?? themeData.buttonColor,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: width,
            height: height,
            padding: padding ?? EdgeInsets.symmetric(vertical: 12.0),
            alignment: Alignment.center,
            color: onTap != null
                ? Colors.transparent
                : disabledColor ??
                    // themeData.disabledColor ??
                    Colors.grey.withOpacity(0.5),
            child: DefaultTextStyle(
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 18.0,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

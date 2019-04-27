import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _MyAppBar extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final Brightness brightness = widget.brightness ??
        appBarTheme.brightness ??
        themeData.primaryColorBrightness;
    final SystemUiOverlayStyle overlayStyle = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Material(
        color: widget.backgroudColor,
        elevation: widget.elevation,
        // padding: EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0),
        child: SafeArea(
          bottom: false,
          child: Container(
            height: 45.0,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: widget.title,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.navigate_before,
                            color: widget.color,
                            size: 35.0,
                          ),
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 10.0,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children:
                          widget.actions == null ? [Text('')] : widget.actions,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyAppBar extends StatefulWidget {
  final List<Widget> actions;
  final Widget title;
  final Color backgroudColor;
  final Color color;
  final Brightness brightness;
  final double elevation;

  MyAppBar({
    this.backgroudColor = Colors.white,
    this.color = Colors.white,
    this.actions,
    this.title = const Text(''),
    this.brightness = Brightness.light,
    this.elevation = 1.0,
    key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppBar();
  }
}

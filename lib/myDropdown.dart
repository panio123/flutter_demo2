import 'package:flutter/material.dart';
import 'dart:math';

class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return Opacity(
      opacity: Tween(begin: 0.0, end: 1.0).animate(animation).value,
      child: child,
    );
  }
}

class Popup extends StatefulWidget {
  final List<MyDropdownItem> items;
  final double left;
  final double top;

  Popup({this.items, this.left, this.top, key}) : super(key: key);

  createState() => _Popup();
}

class _Popup extends State<Popup> {
  void _back(context, value) {
    Navigator.pop(context, [value]);
  }

  @override
  Widget build(BuildContext context) {
    widget.items.forEach((MyDropdownItem item) {
      item._onTap = (value) {
        _back(context, value);
      };
    });
    return Container(
      color: Colors.transparent,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final EdgeInsets padding = MediaQuery.of(context).padding;
          final double maxWidth = constraints.maxWidth;
          final double maxHeight = constraints.maxHeight;
          final double menuWidth = widget.items[0].width;
          final double menuHeight =
              widget.items.length * widget.items[0].height;
          double _top = max(widget.top, padding.top);
          double _left = max(widget.left, padding.left);
          if (_top + menuHeight > maxHeight) {
            _top = maxHeight - menuHeight - padding.bottom;
          }
          if (_left + menuWidth > maxWidth) {
            _left = maxWidth - menuWidth - padding.right;
          }

          return GestureDetector(
            onTap: () {
              _back(context, null);
            },
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.transparent,
                ),
                Positioned(
                  top: _top,
                  left: _left,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[700],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: widget.items),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MyDropdownItem extends StatelessWidget {
  final String lable;
  final String value;
  final double width;
  final double height;

  Function _onTap = () {};

  MyDropdownItem({
    this.lable,
    this.value,
    this.width = 150.0,
    this.height = 50.0,
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _onTap(value);
        },
        child: Container(
          padding: EdgeInsets.only(left: 20.0),
          width: width,
          height: height,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MyDropdown extends State<MyDropdown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (TapUpDetails tapUpDetails) {
        RenderBox box = context.findRenderObject();
        Offset position = box.localToGlobal(Offset.zero);
        Navigator.push(
          context,
          PopRoute(
            child: Popup(
              left: position.dx,
              top: position.dy,
              items: widget.items,
            ),
          ),
        ).then((result) {
          if (result[0] != null) {
            widget.onChange(result[0]);
          }
        });
      },
      child: Container(
        width: 150.0,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Colors.blueGrey[700],
            width: 2.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.value,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.expand_more,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

class MyDropdown extends StatefulWidget {
  final List<MyDropdownItem> items;
  final String value;
  final Function onChange;

  MyDropdown({
    this.items = const [],
    this.value,
    this.onChange,
    key,
  })  : assert(onChange != null),
        super(key: key);
  createState() => _MyDropdown();
}

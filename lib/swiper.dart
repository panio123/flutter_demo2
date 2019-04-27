import 'package:flutter/material.dart';

class _Swiper extends State<Swiper> {
  final PageController _controller = PageController();
  double activeIndex = 1;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        activeIndex = _controller.page + 1;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _pointer(int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      decoration: BoxDecoration(
          color: index + 1 == activeIndex.round() ? Colors.white : Colors.grey,
          borderRadius: BorderRadius.circular(10.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pointer = [];
    for (var i = 0; i < widget.children.length; i++) {
      pointer.add(_pointer(i));
    }
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          PageView(
            controller: _controller,
            children: widget.children,
          ),
          Positioned(
            bottom: 15.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
                  decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(200),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: pointer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Swiper extends StatefulWidget {
  final List<Widget> children;
  Swiper({
    this.children = const [],
    key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Swiper();
  }
}

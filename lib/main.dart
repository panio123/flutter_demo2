import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'myAppBar.dart';
import 'swiper.dart';
import 'data.dart';
import 'myDropdown.dart';
import 'button.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
  ));
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // var a = AppBar;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController;
  bool favorite = false;
  bool showToolsButton = true;
  double _bottom = 0;
  double _opacity = 0;
  int _count = 1;
  double _screenWidth = 320;
  String _color = 'White';
  final List<Widget> swiperChildren = images
      .map((img) => Image.asset(
            img,
            fit: BoxFit.cover,
          ))
      .toList();

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 0) {
        if (_scrollController.offset >= _screenWidth - 50) {
          setState(() {
            showToolsButton = false;
          });
        } else {
          setState(() {
            showToolsButton = true;
          });
        }
        setState(() {
          _bottom = 0 - min(_scrollController.offset, _screenWidth);
          _opacity = min(_scrollController.offset / _screenWidth, 1.0);
        });
      }
    });
    super.initState();
  }

  Widget _block(double height) {
    return SizedBox(height: height);
  }

  Widget _toolsButton(IconData icon, Color color, {onTap, noShadow}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, 5.0),
            blurRadius: 5.0,
            color: noShadow == null ? Colors.black26 : Colors.transparent,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap != null ? onTap : () {},
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: color,
                size: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _toolsButtons({noShadow}) {
    return Wrap(
      spacing: 10.0,
      children: <Widget>[
        _toolsButton(
          favorite ? Icons.favorite : Icons.favorite_border,
          Colors.redAccent,
          onTap: () {
            setState(() {
              favorite = !favorite;
            });
          },
          noShadow: noShadow,
        ),
        _toolsButton(
          Icons.share,
          Colors.black,
          noShadow: noShadow,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Swiper(
                      children: swiperChildren,
                    ),
                    Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(20.0),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '\$250 USD',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.redAccent,
                                ),
                              ),
                              _block(15.0),
                              Text(
                                "Adidas Men's Soccer Tiro 17 Training Pants",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              _block(15.0),
                              Text(
                                'By:Adidas',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                ),
                              ),
                              _block(15.0),
                              Text(
                                  'Lorem ipsum dolor,consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                              _block(10.0),
                              Text(
                                  'Lorem ipsum dolor,consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                              _block(20.0),
                              Divider(),
                              _block(20.0),
                              Image.asset('assets/image_01.jpg'),
                              Image.asset('assets/image_02.jpg'),
                              Image.asset('assets/image_03.jpg'),
                              Image.asset('assets/image_04.jpg'),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -20.0,
                          right: 10.0,
                          child: showToolsButton ? _toolsButtons() : Text(''),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            MyAppBar(
              elevation: 0.0,
              color: Colors.black87,
              title: Opacity(
                opacity: _opacity,
                child: Text("Adidas Men's Soccer Tiro",
                    style: TextStyle(fontSize: 16.0)),
              ),
              backgroudColor: Colors.white70.withOpacity(_opacity),
              actions: <Widget>[
                showToolsButton ? Text('') : _toolsButtons(noShadow: true)
              ],
              // actions: <Widget>[_toolsButtons()],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: _bottom,
              child: Opacity(
                opacity: 1 - _opacity,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                    color: Colors.blueGrey[900],
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Quantity',
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.white),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                      color: Colors.blueGrey[700],
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 50.0,
                                        child: Center(
                                          child: Text(
                                            _count.toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.blueGrey[700],
                                        child: InkWell(
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            if (_count == 1) return;
                                            setState(() {
                                              _count -= 1;
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.blueGrey[700],
                                        child: InkWell(
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            setState(() {
                                              _count += 1;
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Colors',
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.white),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  child: MyDropdown(
                                    onChange: (val) {
                                      setState(() {
                                        _color = val;
                                      });
                                    },
                                    value: _color,
                                    items: ['White', 'Black', 'Blue', 'Red']
                                        .map((value) => MyDropdownItem(
                                              value: value,
                                              lable: value,
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        _block(20.0),
                        Button(
                          onTap: () {
                            print('23432423');
                          },
                          color: Colors.redAccent,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 10.0,
                            children: <Widget>[
                              Icon(
                                Icons.shopping_cart,
                              ),
                              Text(
                                'Add to Cart',
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

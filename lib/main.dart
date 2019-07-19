import 'dart:math' as math;

import 'package:flutter/material.dart';

var random = math.Random.secure();

List<Color> colors = [
  Colors.red,
  Colors.purple,
  Colors.yellow,
  Colors.pink,
  Colors.blue,
  Colors.orange,
  Colors.green,
  Colors.brown
];

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.green)),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  Animation<double> arrowAnimation;
  AnimationController _arrowcontroller;
  String _color;

  bool luckycolortext = false;
  double _randomValue = 0.0;

  int _colorIndex = 0;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);

    arrowAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuart);

    animation.addStatusListener((AnimationStatus status) {
      switch (status) {
        case AnimationStatus.dismissed:
          // TODO: Handle this case.
          break;
        case AnimationStatus.forward:
          setState(() {
            luckycolortext = false;
          });
          // TODO: Handle this case.
          break;
        case AnimationStatus.reverse:
          // TODO: Handle this case.
          break;
        case AnimationStatus.completed:
          setState(() {
            if (_randomValue >= 0.0 && _randomValue < 0.25) {
              _color = 'Orange';
              _colorIndex = 5;
            } else if (_randomValue >= 0.25 && _randomValue < 0.50) {
              _color = 'Blue';
              _colorIndex = 4;
            } else if (_randomValue >= 0.50 && _randomValue < 0.75) {
              _color = 'Pink';
              _colorIndex = 3;
            } else if (_randomValue >= 0.75 && _randomValue < 1.00) {
              _color = 'Yellow';
              _colorIndex = 2;
            } else if (_randomValue >= 1.00 && _randomValue < 1.25) {
              _color = 'Purple';
              _colorIndex = 1;
            } else if (_randomValue >= 1.25 && _randomValue < 1.50) {
              _color = 'Red';
              _colorIndex = 0;
            } else if (_randomValue >= 1.50 && _randomValue < 1.75) {
              _color = 'Brown';
              _colorIndex = 7;
            } else if (_randomValue >= 1.75 && _randomValue < 2.00) {
              _color = 'Green';
              _colorIndex = 6;
            }
            luckycolortext = true;
          });
          break;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: ("Tap on"),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green)),
                TextSpan(
                    text: ("  "),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red)),
                TextSpan(
                    text: ("SPINNER"),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red)),
              ],
            ),
          ),
          SizedBox(
            height: 100.0,
          ),
          Stack(
            alignment: Alignment(0.0, -1.7),
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _randomValue = (random.nextInt(20000) / 10000);
                      print("random: $_randomValue");
                      _controller.forward(from: 0.0);
                    });
//                Future.delayed(Duration(seconds: 10));
//                text = !text;
//                setState(() {
//                  text = true;
//                });
                  },
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return SizedBox(
                        width: 250.0,
                        height: 250.0,
                        child: Container(
                          child: Transform.scale(
                            scale: 1.0 +
                                (0.2 * math.sin(math.pi * animation.value)),
                            child: Transform.rotate(
                              angle: animation.value *
                                  (4.0 + _randomValue) *
                                  math.pi,
                              child: CustomPaint(
                                painter: DrawCircle(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 50.0,
                    child: Image.asset("assets/down_a.png"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Opacity(
            opacity: luckycolortext ? 1.0 : 0.0,
            child: RichText(
              text: TextSpan(
                text: 'Congratulations... ',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "Your lucky color is  ",
                  ),
                  TextSpan(
                      text: '$_color',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colors[_colorIndex],
                          fontSize: 22.0)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DrawCircle extends CustomPainter {
  DrawCircle();

  @override
  bool shouldRepaint(DrawCircle oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);

    for (var i = 0; i < 8; i++) {
      canvas.drawPath(
          Path()..arcTo(rect, i * (math.pi / 4), math.pi / 4, true),
          Paint()
            ..color = colors[i]
            ..strokeWidth = 50.0
            ..style = PaintingStyle.stroke);
    }
  }
}

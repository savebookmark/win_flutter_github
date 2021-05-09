import 'package:flutter/material.dart';

void main() => runApp(MyClipperApp());

class MyClipperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: MyHomePage()));
  }
}

class MyHomePage extends StatelessWidget {
  final Image starsBackground = Image.asset('assets/images/milky-way-6209352_1920.jpg', fit: BoxFit.fill);
  final Image ufo = Image.asset('assets/images/ufo-42453_1280.png', scale: 10.0);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(),
          child: starsBackground,
        ),
        ClipPath(
          clipper: const BeamClipper(),
          child: Container(
            height: 1000,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 1.5,
                colors: [
                  Colors.yellow,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        ufo,
      ],
    );
  }
}

class BeamClipper extends CustomClipper<Path> {
  const BeamClipper();

  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..close();
  }

  /// Return false always because we always clip the same area.
  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

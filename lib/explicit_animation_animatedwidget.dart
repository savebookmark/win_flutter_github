import 'package:flutter/material.dart';

void main() => runApp(MyAnimatedApp());

class MyAnimatedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePageAnimatedWidget());
  }
}

class MyHomePageAnimatedWidget extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePageAnimatedWidget> with SingleTickerProviderStateMixin {
  final Image starsBackground = Image.asset('assets/images/milky-way-6209352_1920.jpg', fit: BoxFit.fitHeight);
  final Image ufo = Image.asset('assets/images/ufo-42453_1280.png', scale: 10);
  late AnimationController _animation;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(duration: const Duration(seconds: 4), vsync: this)..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(constraints: BoxConstraints.expand(), child: starsBackground),
          BeamTransition(animation: _animation),
          ufo,
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}

class BeamTransition extends AnimatedWidget {
  BeamTransition({Key? key, required Animation<double> animation}) : super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return ClipPath(
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
            stops: [0, animation.value],
          ),
        ),
      ),
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

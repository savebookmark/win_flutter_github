import 'package:flutter/material.dart';

class MyHomePageAnimatedWidget extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePageAnimatedWidget> with SingleTickerProviderStateMixin {
  final Image starsBackground = Image.asset('assets/images/milky-way-6209352_1920.jpg');
  final Image ufo = Image.asset('assets/images/ufo-42453_1280.png');
  late AnimationController _animation;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(duration: const Duration(seconds: 5), vsync: this)..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        starsBackground,
        BeamTransition(animation: _animation),
        ufo,
      ],
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
    // final animation = listenable;
    return ClipPath(
      clipper: const BeamClipper(),
      child: Container(
        height: 1000,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1.5,
            colors: [Colors.yellow, Colors.transparent],
            stops: [0.0, 1.0],
            // stops: [0.0, animation.value],
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

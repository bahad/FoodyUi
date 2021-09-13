import 'package:flutter/material.dart';
import 'dart:math';

class LoadingAnimation extends StatefulWidget {
  final routeName;
  const LoadingAnimation({this.routeName});
  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> rotateX;
  Animation<double> rotateY;
  Animation<double> rotateZ;

  @override
  initState() {
    super.initState();
    animationController = new AnimationController(
      duration: const Duration(milliseconds: 12000),
      vsync: this,
    )..repeat();
    rotateY = new Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(
        new CurvedAnimation(parent: animationController, curve: Curves.linear));
    Future.delayed(Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, widget.routeName));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            final img = Image.asset('assets/icons/resto.png',
                height: size.height * 0.099);

            return new Transform(
              transform: new Matrix4.rotationY(rotateY.value * pi),
              alignment: Alignment.center,
              child: img,
            );
          },
        ),
      ),
    );
  }
}

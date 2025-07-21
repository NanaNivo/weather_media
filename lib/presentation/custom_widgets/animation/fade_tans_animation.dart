import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeTransAnimation extends StatelessWidget {
  final Widget child;
  final int delayInMillisecond;
  final AxisDirection direction;
  final double translateYDistance;

  const FadeTransAnimation({
    Key? key,
    required this.delayInMillisecond,
    required this.child,
    this.direction = AxisDirection.up,
    this.translateYDistance = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double beginOffset =
        (direction == AxisDirection.up || direction == AxisDirection.left)
            ? -translateYDistance
            : translateYDistance;

    final bool isHorizontal =
        direction == AxisDirection.left || direction == AxisDirection.right;

    final tween = MovieTween()
      ..tween<double>(
        'opacity',
        Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 500),
      )
      ..tween<double>(
        'translate',
        Tween(begin: beginOffset, end: 0.0),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );

    return PlayAnimationBuilder<Movie>(
      tween: tween,
      delay: Duration(milliseconds: delayInMillisecond),
      duration: tween.duration,
      builder: (context, value, childWidget) {
        return Opacity(
          opacity: value.get<double>('opacity'),
          child: Transform.translate(
            offset: isHorizontal
                ? Offset(value.get<double>('translate'), 0)
                : Offset(0, value.get<double>('translate')),
            child: childWidget,
          ),
        );
      },
      child: child,
    );
  }
}

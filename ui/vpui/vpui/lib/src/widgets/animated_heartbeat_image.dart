import 'package:flutter/material.dart';

class AnimatedHeartbeatImage extends StatefulWidget {
  @override
  _AnimatedHeartbeatImageState createState() => _AnimatedHeartbeatImageState();
}

class _AnimatedHeartbeatImageState extends State<AnimatedHeartbeatImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1, end: 1.2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: ClipOval(
        child: Container(
          width: 120, // Adjust the size as needed
          height: 120, // Adjust the size as needed
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/active_protest.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: ShaderMask(
            shaderCallback: (rect) {
              return RadialGradient(
                radius: 1.5,
                colors: [
                  Colors.white,
                  Colors.white,
                  Colors.transparent,
                ],
                stops: [0, 0.7, 1],
                center: FractionalOffset.center,
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/active_protest.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

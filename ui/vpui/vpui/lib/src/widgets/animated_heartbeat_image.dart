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
      child: ShaderMask(
        shaderCallback: (rect) {
          return RadialGradient(
            radius: 0.5,
            colors: [Colors.black, Colors.transparent],
            stops: [0.8, 1.0], // Adjust these stops for desired fade effect
            center: FractionalOffset.center,
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: Image.asset('assets/images/active_protest.png',
            width: 200, height: 200),
      ),
    );
  }
}

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
      child: Container(
        width: 100, // Adjust the size as needed
        height: 100, // Adjust the size as needed
        child: ShaderMask(
          shaderCallback: (rect) {
            return RadialGradient(
              radius: 0.5, // Adjust the radius for the gradient effect
              center: Alignment.center,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.5), // Adjust opacity for fade effect
              ],
              stops: [0.5, 1.0], // Adjust stops for a smoother transition
            ).createShader(
                Rect.fromCircle(center: rect.center, radius: rect.width / 2));
          },
          blendMode: BlendMode.dstOut,
          child: ClipOval(
            child: Image.asset(
              'assets/images/active_protest.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

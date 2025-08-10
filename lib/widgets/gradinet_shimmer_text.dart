
import 'package:flutter/material.dart';

class GradientShimmerText extends StatefulWidget {
  const GradientShimmerText({super.key});

  @override
  State<GradientShimmerText> createState() => _GradientShimmerTextState();
}

class _GradientShimmerTextState extends State<GradientShimmerText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const shimmerGradient = LinearGradient(
      colors: [
        Color.fromARGB(0, 87, 75, 226),
        Color.fromARGB(255, 199, 203, 251),
        Color.fromARGB(0, 126, 67, 160),
      ],
      stops: [0.1, 0.5, 0.9],
      begin: Alignment(-1.0, -0.3),
      end: Alignment(1.0, 0.3),
      tileMode: TileMode.clamp,
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1,horizontal: 25),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ShaderMask(
            shaderCallback: (bounds) {
              return shimmerGradient.createShader(
                Rect.fromLTWH(
                  -bounds.width + (bounds.width * 2) * _controller.value,
                  0,
                  bounds.width,
                  bounds.height,
                ),
              );
            },
            blendMode: BlendMode.srcATop,
            child: child,
          );
        },
        child: Text(
          'Your Private Ai Model is Thinking....',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class BuildMarquee extends StatelessWidget {
  const BuildMarquee({
    super.key,
    required this.news,
    required this.size,
    required this.paddingSize,
  });

  final String news;
  final double size;
  final double paddingSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: Card(
        surfaceTintColor: const Color(0xFF410002),
        child: Padding(
          padding: EdgeInsets.all(paddingSize),
          child:
          Marquee(crossAxisAlignment: CrossAxisAlignment.start, text: news),
        ),
      ),
    );
  }
}

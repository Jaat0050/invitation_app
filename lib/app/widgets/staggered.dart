import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

class MovingGrid extends StatelessWidget {
  const MovingGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FrameListView(
          images: movies,
          seconds: 135,
        ),
        // FrameListView(
        //   images: movies2,
        //   seconds: 56,
        // ),
        // FrameListView(
        //   images: movies3,
        //   seconds: 63,
        // ),
        // FrameListView(
        //   images: movies4,
        //   seconds: 58,
        // ),
      ],
    );
  }
}

class FrameListView extends StatelessWidget {
  final List images;
  final int seconds;
  const FrameListView({super.key, required this.images, required this.seconds});
  @override
  Widget build(BuildContext context) {
    // final _controller = AutoScrollController();

    return SizedBox(
      width: MediaQuery.of(context).size.width - 16,
      child: ScrollLoopAutoScroll(
        scrollDirection: Axis.vertical,
        delay: const Duration(seconds: 0),
        duration: Duration(seconds: seconds),
        gap: 0,
        reverseScroll: false,
        duplicateChild: 15,
        enableScrollInput: false,
        delayAfterScrollInput: const Duration(seconds: 0),
        child: MasonryGridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            // Example: Alternate between two different heights
            // (index.isEven) ? 150.0 : 135.0;

            return Container(
              margin: const EdgeInsets.all(4),
              // height: height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  '${images[index]}',
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
        ),
      ),
    );
  }
}

List movies = [
  'assets/grid-cards/m1 (1).webp',
  'assets/grid-cards/m7_half.webp.png',
  'assets/grid-cards/m3 (1).webp',
  'assets/grid-cards/m8_half.webp.png',
  'assets/grid-cards/m6 (1).webp',
  'assets/grid-cards/m7 (1).webp',
  'assets/grid-cards/m8 (1).webp',
  'assets/grid-cards/m9 (1).webp',
  'assets/grid-cards/m10 (1).webp',
  'assets/grid-cards/m11 (1).webp',
  'assets/grid-cards/m12 (1).webp',
  'assets/grid-cards/m13 (1).webp',
  'assets/grid-cards/m14 (1).webp',
  'assets/grid-cards/m15 (1).webp',
  'assets/grid-cards/m16 (1).webp',
  'assets/grid-cards/m17 (1).webp',
  'assets/grid-cards/m18 (1).webp',
  'assets/grid-cards/m19 (1).webp',
  'assets/grid-cards/m20 (1).webp',
  'assets/grid-cards/m21 (1).webp',
  'assets/grid-cards/m22 (1).webp',
  'assets/grid-cards/m23 (1).webp',
  'assets/grid-cards/m24 (1).webp',
  'assets/grid-cards/m2 (1).webp',
  'assets/grid-cards/m7_half.webp.png',
  'assets/grid-cards/m8_half.webp.png',
];

List movies1 = [
  'assets/grid-cards/m1 (1).webp',
  'assets/grid-cards/m2 (1).webp',
  'assets/grid-cards/m3 (1).webp',
  'assets/grid-cards/m4 (1).webp',
  'assets/grid-cards/m5 (1).webp',
  'assets/grid-cards/m6 (1).webp',
];

List movies2 = [
  'assets/grid-cards/m7 (1).webp',
  'assets/grid-cards/m8 (1).webp',
  'assets/grid-cards/m9 (1).webp',
  'assets/grid-cards/m10 (1).webp',
  'assets/grid-cards/m11 (1).webp',
  'assets/grid-cards/m12 (1).webp',
];

List movies3 = [
  'assets/grid-cards/m13 (1).webp',
  'assets/grid-cards/m14 (1).webp',
  'assets/grid-cards/m15 (1).webp',
  'assets/grid-cards/m16 (1).webp',
  'assets/grid-cards/m17 (1).webp',
  'assets/grid-cards/m18 (1).webp',
];

List movies4 = [
  'assets/grid-cards/m19 (1).webp',
  'assets/grid-cards/m20 (1).webp',
  'assets/grid-cards/m21 (1).webp',
  'assets/grid-cards/m22 (1).webp',
  'assets/grid-cards/m23 (1).webp',
  'assets/grid-cards/m24 (1).webp',
];

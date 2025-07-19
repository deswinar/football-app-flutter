import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlayerCardSkeleton extends StatelessWidget {
  const PlayerCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 8),
            Container(
              width: 80,
              height: 12,
              color: Colors.white,
            ),
            const SizedBox(height: 6),
            Container(
              width: 40,
              height: 10,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

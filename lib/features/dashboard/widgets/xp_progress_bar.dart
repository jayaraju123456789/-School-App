import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class XPProgressBar extends StatelessWidget {
  final int currentXP;
  final int maxXP;
  final VoidCallback onLevelUp;

  const XPProgressBar({
    Key? key,
    required this.currentXP,
    required this.maxXP,
    required this.onLevelUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = currentXP / maxXP;
    if (progress >= 1.0) {
      onLevelUp();
    }

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: 20,
                width: MediaQuery.of(context).size.width * progress,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ).animate().shimmer(duration: 2000.ms, curve: Curves.easeInOut),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$currentXP / $maxXP XP',
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AchievementBadge extends StatelessWidget {
  final int level;

  const AchievementBadge({
    Key? key,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.amber[400]!,
            Colors.amber[700]!,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.amber[200]!.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Icon(
        _getBadgeIcon(),
        color: Colors.white,
        size: 24,
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 2000.ms)
        .then()
        .shake(duration: 500.ms, curve: Curves.easeInOut);
  }

  IconData _getBadgeIcon() {
    if (level >= 20) return Icons.military_tech;
    if (level >= 10) return Icons.star;
    return Icons.school;
  }
}

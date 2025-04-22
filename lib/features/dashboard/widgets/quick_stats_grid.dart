import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuickStatsGrid extends StatelessWidget {
  const QuickStatsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildStatCard(context, 'Attendance', '85%', Icons.check_circle),
        _buildStatCard(context, 'Assignments', '5', Icons.assignment),
        _buildStatCard(context, 'Fee Due', '₹7,500', Icons.receipt),
        _buildStatCard(context, 'CGPA', '8.5', Icons.school),
      ],
    );
  }

  Widget _buildStatCard(
      BuildContext context, String title, String value, IconData icon) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(0.01),
      alignment: FractionalOffset.center,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).primaryColor)
                .animate()
                .scale(duration: 300.ms, curve: Curves.easeOut),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

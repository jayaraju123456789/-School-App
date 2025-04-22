import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> actions = [
      {'title': 'Fee Statement', 'icon': Icons.receipt_long},
      {'title': 'Attendance', 'icon': Icons.how_to_reg},
      {'title': 'Assignments', 'icon': Icons.assignment},
      {'title': 'Results', 'icon': Icons.analytics},
      {'title': 'Exams', 'icon': Icons.edit_note},
      {'title': 'Parent Details', 'icon': Icons.family_restroom},
      {'title': 'View Marks', 'icon': Icons.grade},
      {'title': 'AI Helper', 'icon': Icons.smart_toy},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: actions.length,
          itemBuilder: (context, index) {
            return _buildActionCard(
              context,
              actions[index]['title'],
              actions[index]['icon'],
              index,
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionCard(
      BuildContext context, String title, IconData icon, int index) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/${title.toLowerCase().replaceAll(' ', '_')}',
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.7),
                Theme.of(context).primaryColor.withOpacity(0.4),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: Colors.white,
              ),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .scale(delay: (100 * index).ms, duration: 300.ms)
        .fade(delay: (100 * index).ms, duration: 300.ms);
  }
}

import 'package:flutter/material.dart';

import 'drawer/my_drawer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple.shade400,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTimetableSection(),
              const SizedBox(height: 24.0),
              _buildDashboardTiles(),
              const SizedBox(height: 16.0),
              _buildRewardSection(), // New feature for gamification
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildTimetableSection() {
    final List<Map<String, String>> timetable = [
      {'title': 'URP809', 'time': '01-02 PM'},
      {'title': 'PHY101', 'time': '02-03 PM'},
      {'title': 'MTH102', 'time': '03-04 PM'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Today\'s Timetable',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16.0),
        ...timetable.map(
          (item) => _buildTimetableItem(
            title: item['title']!,
            time: item['time']!,
          ),
        ),
      ],
    );
  }

  Widget _buildTimetableItem({
    required String title,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade300, Colors.purple.shade600],
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardTiles() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        children: [
          _buildDashboardTile(
            icon: Icons.announcement,
            title: 'Announce',
            count: '21',
          ),
          _buildDashboardTile(
            icon: Icons.receipt,
            title: 'Fee',
            count: '7.08',
          ),
          _buildDashboardTile(
            icon: Icons.assignment_turned_in,
            title: 'Attendance',
            count: '74%',
          ),
          _buildDashboardTile(
            icon: Icons.assignment,
            title: 'Assignment',
            count: '0',
          ),
          _buildDashboardTile(
            icon: Icons.show_chart,
            title: 'Results',
            count: '0',
          ),
          _buildDashboardTile(
            icon: Icons.assignment_turned_in,
            title: 'Exams',
            count: '0',
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardTile({
    required IconData icon,
    required String title,
    required String count,
  }) {
    return GestureDetector(
      onTap: () {
        // Add action for tap
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          gradient: const LinearGradient(
            colors: [Color(0xFFFFD700), Color(0xFFFFA07A)],
          ),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32.0, color: Colors.white),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 8.0),
            Text(
              count,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(12.0),
        gradient: const LinearGradient(
          colors: [Color(0xFF76FF03), Color(0xFF4CAF50)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '🎉 Level 1: Great Attendance!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Icon(Icons.stars, size: 30.0, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Happenings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt),
          label: 'RMS',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.quiz),
          label: 'Quick Quiz',
        ),
      ],
    );
  }
}

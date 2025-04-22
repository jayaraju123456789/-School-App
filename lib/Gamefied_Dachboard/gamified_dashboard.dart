import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math';
import '../screens/timetable_screen.dart';
import '../screens/assignments_screen.dart';
import '../screens/fees_screen.dart';
import '../screens/results_screen.dart';

class GamifiedDashboard extends StatefulWidget {
  @override
  _GamifiedDashboardScreenState createState() =>
      _GamifiedDashboardScreenState();
}

class _GamifiedDashboardScreenState extends State<GamifiedDashboard>
    with SingleTickerProviderStateMixin {
  int _studentLevel = 1;
  int _xpPoints = 0;
  int _challengeStreak = 0;
  List<GameChallenge> _activeChallenges = [];
  Timer? _gameTimer;
  late AnimationController _expandableMenuController;
  bool _isExpandableMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _generateChallenges();
    _startGameTimer();
    _expandableMenuController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  void _startGameTimer() {
    _gameTimer = Timer.periodic(Duration(minutes: 5), (timer) {
      _generateChallenges();
      _checkLevelUp();
    });
  }

  void _generateChallenges() {
    final random = Random();
    setState(() {
      _activeChallenges = List.generate(3, (_) {
        final types = [
          'Attendance Challenge',
          'Study Sprint',
          'Assignment Master',
          'Quiz Wizard'
        ];
        final type = types[random.nextInt(types.length)];
        final points = random.nextInt(50) + 10;

        return GameChallenge(
          title: type,
          description: _generateChallengeDescription(type),
          points: points,
          isCompleted: false,
        );
      });
    });
  }

  String _generateChallengeDescription(String type) {
    final descriptions = {
      'Attendance Challenge': 'Attend all classes this week',
      'Study Sprint': 'Complete 2 hours of focused study',
      'Assignment Master': 'Submit assignments before the deadline',
      'Quiz Wizard': 'Score above 80% in the next quiz',
    };
    return descriptions[type] ?? 'Complete the challenge';
  }

  void _completeChallenge(GameChallenge challenge) {
    if (challenge.isCompleted) return;

    HapticFeedback.heavyImpact();

    setState(() {
      challenge.isCompleted = true;
      _xpPoints += challenge.points;
      _challengeStreak++;

      if (_challengeStreak % 5 == 0) {
        _studentLevel++;
        _showLevelUpDialog();
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.star, color: Colors.yellow),
            SizedBox(width: 8),
            Text('Earned ${challenge.points} XP!'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showLevelUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.emoji_events, color: Colors.amber, size: 30),
            SizedBox(width: 8),
            Text('Level Up!'),
          ],
        ),
        content: Text('Congratulations! You\'ve reached Level $_studentLevel!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              HapticFeedback.mediumImpact();
            },
            child: Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _checkLevelUp() {
    if (_xpPoints >= _studentLevel * 100) {
      setState(() {
        _studentLevel++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawerMenu(),
      body: Stack(
        children: [
          Column(
            children: [
              _buildTopBar(),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildDashboardCard('Timetable', Icons.schedule),
                    _buildDashboardCard('Announcements', Icons.announcement),
                    _buildDashboardCard(
                        'Fee Statement', Icons.account_balance_wallet),
                    _buildDashboardCard('Attendance', Icons.how_to_reg),
                    _buildDashboardCard('Assignments', Icons.assignment),
                    _buildDashboardCard('Results & Exams', Icons.school),
                    _buildDashboardCard('Parent Details', Icons.people),
                    _buildDashboardCard('View Marks', Icons.bar_chart),
                    _buildDashboardCard('Messages', Icons.message),
                  ],
                ),
              ),
            ],
          ),
          _buildExpandableMenu(),
        ],
      ),
    );
  }

  Widget _buildPlayerStats() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Icon(Icons.star, color: Color(0xFFFFD700)),
                Text('Level $_studentLevel'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.trending_up, color: Colors.green),
                Text('XP: $_xpPoints'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.whatshot, color: Colors.red),
                Text('Streak: $_challengeStreak'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardSection() {
    return Container(
      color: Colors.amber[100],
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '🏆 Achievement Unlocked!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('Streak Bonus: +${_challengeStreak * 5} XP'),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            Expanded(child: _buildPlayerStats()),
            _buildMessageButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageButton() {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Messages coming soon!'),
            duration: Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.message, color: Colors.deepPurple),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String title, IconData icon) {
    return StatefulBuilder(builder: (context, setState) {
      bool isHovered = false;

      return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
          child: Card(
            elevation: isHovered ? 8 : 4,
            child: InkWell(
              onTap: () {
                _navigateToFeature(title);
                HapticFeedback.lightImpact();
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple[400]!, Colors.deepPurple[600]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: isHovered ? 36 : 32, color: Colors.white),
                    SizedBox(height: 8),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: isHovered ? 16 : 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildDrawerMenu() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.deepPurple),
                ),
                SizedBox(height: 10),
                Text(
                  'Quick Access Menu',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          _buildDrawerItem('Assignments', Icons.assignment),
          _buildDrawerItem('Backlog Registration', Icons.history),
          _buildDrawerItem('Doctor Appointment', Icons.local_hospital),
          _buildDrawerItem('Document Upload', Icons.upload_file),
          _buildDrawerItem('Teacher on Leave', Icons.person_off),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      onTap: () => _navigateToFeature(title),
    );
  }

  Widget _buildExpandableMenu() {
    return Positioned(
      right: 16,
      bottom: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isExpandableMenuOpen) ..._buildExpandableMenuItems(),
          FloatingActionButton(
            onPressed: () =>
                setState(() => _isExpandableMenuOpen = !_isExpandableMenuOpen),
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _expandableMenuController,
            ),
            backgroundColor: Colors.deepPurple,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildExpandableMenuItems() {
    final menuItems = [
      {'title': 'Teacher on Leave', 'icon': Icons.person_off},
      {'title': 'Assignment Upload', 'icon': Icons.upload_file},
      {'title': 'Backlog Registration', 'icon': Icons.history},
      {'title': 'Doctor Appointment', 'icon': Icons.local_hospital},
      {'title': 'Document Upload', 'icon': Icons.upload},
      {'title': 'Library Section', 'icon': Icons.library_books},
      {'title': 'List of Holidays', 'icon': Icons.calendar_today},
      {'title': 'Placement Drives', 'icon': Icons.work},
      {'title': 'AI Helper', 'icon': Icons.smart_toy},
    ];

    return menuItems
        .map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: FloatingActionButton(
                mini: true,
                child: Icon(item['icon'] as IconData),
                onPressed: () => _navigateToFeature(item['title'] as String),
                backgroundColor: Colors.deepPurple[300],
              ),
            ))
        .toList();
  }

  void _navigateToFeature(String feature) {
    HapticFeedback.mediumImpact();

    switch (feature.toLowerCase()) {
      case 'timetable':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TimeTableScreen()),
        );
        break;
      case 'assignments':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AssignmentsScreen()),
        );
        break;
      case 'fee statement':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FeesScreen()),
        );
        break;
      case 'results & exams':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultsScreen()),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$feature feature coming soon!'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
    }
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }
}

class GameChallenge {
  final String title;
  final String description;
  final int points;
  bool isCompleted;

  GameChallenge({
    required this.title,
    required this.description,
    required this.points,
    this.isCompleted = false,
  });
}

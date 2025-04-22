import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import '../../services/dashboard_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_app/my_routes/My_Routes.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'widgets/game_card.dart';
import 'widgets/xp_progress_bar.dart';
import 'widgets/achievement_badge.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  int _studentLevel = 1;
  int _xpPoints = 0;
  int _challengeStreak = 0;
  List<GameChallenge> _activeChallenges = [];
  Timer? _gameTimer;
  late DashboardService _dashboardService;
  bool _isLoading = true;
  late ConfettiController _confettiController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _initializeServices();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  Future<void> _initializeServices() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
      return;
    }

    _dashboardService = DashboardService(token);
    await _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      final studentData = await _dashboardService.getStudentData();
      final challenges = await _dashboardService.getChallenges();

      setState(() {
        _studentLevel = studentData['level'] ?? 1;
        _xpPoints = studentData['xp'] ?? 0;
        _challengeStreak = studentData['streak'] ?? 0;
        _activeChallenges = challenges
            .map((c) => GameChallenge(
                  title: c['title'],
                  description: c['description'],
                  points: c['points'],
                  isCompleted: c['completed'] ?? false,
                ))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
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
    setState(() {
      challenge.isCompleted = true;
      _xpPoints += challenge.points;
      _challengeStreak++;

      if (_challengeStreak % 5 == 0) {
        _studentLevel++;
      }
    });
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
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildDashboardContent(),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: -pi / 2,
            particleDrag: 0.05,
            emissionFrequency: 0.05,
            numberOfParticles: 20,
            gravity: 0.05,
          ),
        ],
      ),
      floatingActionButton: _buildExpandableMenu(),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withAlpha(204),
            Theme.of(context).primaryColor.withAlpha(51),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardContent() {
    return CustomScrollView(
      slivers: [
        _buildAppBar(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildPlayerStats(),
                const SizedBox(height: 20),
                _buildFeatureGrid(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      title: Text('Student Quest Dashboard'),
      backgroundColor: Colors.deepPurple,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: Text(
              'Level $_studentLevel',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: Text(
              'XP: $_xpPoints',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Level $_studentLevel',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AchievementBadge(level: _studentLevel),
            ],
          ),
          const SizedBox(height: 10),
          XPProgressBar(
            currentXP: _xpPoints,
            maxXP: _studentLevel * 1000,
            onLevelUp: _handleLevelUp,
          ),
        ],
      ),
    ).animate().slideY(
          begin: 0.3,
          duration: 600.ms,
          curve: Curves.easeOutBack,
        );
  }

  Widget _buildFeatureGrid() {
    final features = [
      ('Messages', Icons.message),
      ('Timetable', Icons.calendar_today),
      ('Assignments', Icons.assignment),
      ('Attendance', Icons.check_circle),
      ('Results', Icons.emoji_events),
      ('Fees', Icons.attach_money),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return GameCard(
          title: features[index].$1,
          icon: features[index].$2,
          onTap: () => _handleFeatureTap(features[index].$1),
        ).animate(delay: (index * 100).ms).scale(
              duration: 600.ms,
              curve: Curves.easeOutBack,
            );
      },
    );
  }

  void _handleLevelUp() {
    setState(() {
      _studentLevel++;
      _xpPoints = 0;
    });
    _confettiController.play();
  }

  void _handleFeatureTap(String feature) {
    setState(() {
      _xpPoints += 10;
    });
    // Navigate to feature screen
  }

  Widget _buildExpandableMenu() {
    return FloatingActionButton(
      onPressed: () {
        // Show expandable menu options
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.person_off),
                  title: Text('Teacher on Leave'),
                  onTap: () => _handleFeatureTap('Teacher on Leave'),
                ),
                ListTile(
                  leading: Icon(Icons.upload_file),
                  title: Text('Assignment Upload'),
                  onTap: () => _handleFeatureTap('Assignment Upload'),
                ),
                // Add more menu items as needed
              ],
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    _confettiController.dispose();
    _animationController.dispose();
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

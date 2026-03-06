import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../utils/colors.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _chipsController;
  late AnimationController _cardsController;
  late AnimationController _listController;
  
  late Animation<double> _headerFade;
  late Animation<double> _headerSlide;
  late Animation<double> _chipsFade;
  late Animation<double> _cardsFade;
  late Animation<double> _cardsSlide;
  late Animation<double> _listFade;

  final List<Map<String, dynamic>> _inProgressTasks = [
    {
      "icon": Icons.cloud_upload,
      "title": "Upload Assets",
      "subtitle": "Waiting for approval"
    },
    {
      "icon": Icons.brush,
      "title": "Icon Set Design",
      "subtitle": "40/50 Icons done"
    },
    {
      "icon": Icons.code,
      "title": "Frontend Logic",
      "subtitle": "Login flow debugging"
    },
  ];

  int _selectedChip = 0;

  @override
  void initState() {
    super.initState();
    
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _headerFade = CurvedAnimation(parent: _headerController, curve: Curves.easeOut);
    _headerSlide = Tween<double>(begin: -30, end: 0).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOutCubic),
    );
    
    _chipsController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _chipsFade = CurvedAnimation(parent: _chipsController, curve: Curves.easeOut);
    
    _cardsController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _cardsFade = CurvedAnimation(parent: _cardsController, curve: Curves.easeOut);
    _cardsSlide = Tween<double>(begin: 100, end: 0).animate(
      CurvedAnimation(parent: _cardsController, curve: Curves.easeOutCubic),
    );
    
    _listController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _listFade = CurvedAnimation(parent: _listController, curve: Curves.easeOut);
    
    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _chipsController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _cardsController.forward();
    });
    Future.delayed(const Duration(milliseconds: 700), () {
      _listController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _chipsController.dispose();
    _cardsController.dispose();
    _listController.dispose();
    super.dispose();
  }

  void _deleteItem(int index) {
    setState(() {
      _inProgressTasks.removeAt(index);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Project deleted"),
        action: SnackBarAction(label: "Undo", onPressed: () {}), 
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Matrix4 _getChipTransform(bool isActive) {
    if (isActive) {
      return Matrix4.identity()..scale(1.05);
    }
    return Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedBuilder(
              animation: _headerSlide,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _headerSlide.value),
                  child: Opacity(
                    opacity: _headerFade.value,
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppColors.defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, User!",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          "Let's finish your tasks",
                          style: TextStyle(color: AppColors.textLight),
                        ),
                      ],
                    ),
                    Hero(
                      tag: 'profile',
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryPurple.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage: const AssetImage('assets/icon/profile.jpeg'),
                          backgroundColor: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            FadeTransition(
              opacity: _chipsFade,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppColors.defaultPadding),
                child: Row(
                  children: [
                    _buildAnimatedFilterChip("My Tasks", 0),
                    const SizedBox(width: 12),
                    _buildAnimatedFilterChip("Pending", 1),
                    const SizedBox(width: 12),
                    _buildAnimatedFilterChip("Completed", 2),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            AnimatedBuilder(
              animation: _cardsSlide,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _cardsSlide.value),
                  child: Opacity(
                    opacity: _cardsFade.value,
                    child: child,
                  ),
                );
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppColors.defaultPadding),
                child: Row(
                  children: [
                    _buildAnimatedProjectCard("Mobile App\nDesign", "Oct 24", 0.7, 0),
                    const SizedBox(width: 16),
                    _buildAnimatedProjectCard("Website\nRedesign", "Nov 01", 0.4, 1),
                    const SizedBox(width: 16),
                    _buildAnimatedProjectCard("Dashboard\nAnalytics", "Dec 12", 0.9, 2),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            FadeTransition(
              opacity: _listFade,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppColors.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "In Progress",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    if (_inProgressTasks.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("No tasks remaining!", style: TextStyle(color: Colors.grey)),
                      )
                    else
                      ..._inProgressTasks.map((task) => _buildAnimatedSwipeableListItem(
                        _inProgressTasks.indexOf(task),
                        task['icon'],
                        task['title'],
                        task['subtitle'],
                      )).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedFilterChip(String label, int index) {
    final isActive = _selectedChip == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedChip = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryPurple : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: isActive
              ? Border.all(color: Colors.transparent)
              : Border.all(color: Colors.grey.shade300),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primaryPurple.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        transform: _getChipTransform(isActive),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.textLight,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedProjectCard(String title, String date, double progress, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: progress),
      duration: Duration(milliseconds: 800 + (200 * index)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return _AnimatedProjectCard(
          title: title,
          date: date,
          progress: value,
        );
      },
    );
  }

  Widget _buildAnimatedSwipeableListItem(int index, IconData icon, String title, String subtitle) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + (100 * index)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Slidable(
          key: ValueKey(title),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.25,
            children: [
              CustomSlidableAction(
                onPressed: (context) => _deleteItem(index),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD32F2F),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Icon(Icons.delete_outline, color: Colors.white, size: 28),
                  ),
                ),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryPurple.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: AppColors.primaryPurple),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.textDark,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert, color: AppColors.textLight),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool isActive;

  const FilterChipWidget({super.key, required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryPurple : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: isActive
            ? Border.all(color: Colors.transparent)
            : Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : AppColors.textLight,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _AnimatedProjectCard extends StatelessWidget {
  final String title;
  final String date;
  final double progress;

  const _AnimatedProjectCard({
    required this.title,
    required this.date,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 260,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primaryPurple,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              date,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const Spacer(),
          const Text("Progress", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: 6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                height: 6,
                width: double.infinity * progress,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProjectCardWidget extends StatelessWidget {
  final String title;
  final String date;
  final double progress;

  const ProjectCardWidget({
    super.key,
    required this.title,
    required this.date,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 260,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primaryPurple,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              date,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const Spacer(),
          const Text("Progress", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: 6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                height: 6,
                width: double.infinity * progress,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


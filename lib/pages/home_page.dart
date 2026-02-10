import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'history_page.dart';
import 'profile_page.dart';
import 'todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // The pages for the shell
  final List<Widget> _pages = [
    const DashboardView(),
    const TodoPage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryBlue,
        shape: const CircleBorder(),
        elevation: 4,
        child: const Icon(Icons.qr_code_scanner, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        child: SizedBox(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Left Side
              _buildNavIcon(Icons.home_rounded, 0),
              _buildNavIcon(Icons.check_circle_outline, 1),
              
              const SizedBox(width: 40), // Spacer for FAB
              
              // Right Side
              _buildNavIcon(Icons.history, 2),
              _buildNavIcon(Icons.person_outline, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    final bool isActive = _selectedIndex == index;
    return IconButton(
      icon: Icon(
        icon,
        color: isActive ? AppColors.primaryBlue : AppColors.textLight,
        size: 28,
      ),
      onPressed: () => _onItemTapped(index),
    );
  }
}

// --- DASHBOARD VIEW WIDGET (Home Content) ---

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppColors.defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Hello, User!",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark)),
                      Text("Let's finish your tasks",
                          style: TextStyle(color: AppColors.textLight)),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
                    backgroundColor: AppColors.primaryBlue,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),

            // 2. Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppColors.defaultPadding),
              child: Row(
                children: [
                  _buildChip("My Tasks", true),
                  _buildChip("Pending", false),
                  _buildChip("Completed", false),
                  _buildChip("Archived", false),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 3. Project Cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppColors.defaultPadding),
              child: Row(
                children: [
                  _buildProjectCard(
                      "Mobile App\nDesign", "Oct 24", 0.7),
                  const SizedBox(width: 16),
                  _buildProjectCard(
                      "Website\nRedesign", "Nov 01", 0.4),
                  const SizedBox(width: 16),
                  _buildProjectCard(
                      "Dashboard\nAnalytics", "Dec 12", 0.9),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 4. In Progress List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppColors.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("In Progress",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark)),
                  const SizedBox(height: 16),
                  _buildListItem(Icons.cloud_upload, "Upload Assets", "Waiting for approval"),
                  _buildListItem(Icons.brush, "Icon Set Design", "40/50 Icons done"),
                  _buildListItem(Icons.code, "Frontend Logic", "Login flow debugging"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryPurple : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: isActive ? null : Border.all(color: Colors.grey.shade300),
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

  Widget _buildProjectCard(String title, String date, double progress) {
    return Container(
      width: 220,
      height: 260,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primaryPurple,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withOpacity(0.3),
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
          // Custom Progress Stack
          Stack(
            children: [
              Container(
                height: 6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildListItem(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primaryPurple),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textDark)),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.textLight)),
              ],
            ),
          ),
          const Icon(Icons.more_vert, color: AppColors.textLight),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart'; // Import this
import '../utils/colors.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  // 1. Create a data model for your list so we can delete items dynamically
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

  // Logic to remove an item
  void _deleteItem(int index) {
    setState(() {
      _inProgressTasks.removeAt(index);
    });
    
    // Optional: Show a snackbar confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Project deleted"),
        action: SnackBarAction(label: "Undo", onPressed: () {}), 
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER (Unchanged) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppColors.defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello, User!",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                      Text("Let's finish your tasks",
                          style: TextStyle(color: AppColors.textLight)),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/icon/profile.jpeg'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // --- FILTER CHIPS (Unchanged) ---
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppColors.defaultPadding),
              child: Row(
                children: [
                  _buildFilterChip("My Tasks", true),
                  _buildFilterChip("Pending", false),
                  _buildFilterChip("Completed", false),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // --- PROJECT CARDS (Unchanged) ---
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppColors.defaultPadding),
              child: Row(
                children: [
                  _buildProjectCard("Mobile App\nDesign", "Oct 24", 0.7),
                  const SizedBox(width: 16),
                  _buildProjectCard("Website\nRedesign", "Nov 01", 0.4),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // --- IN PROGRESS LIST (Updated with Swipe Logic) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppColors.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("In Progress",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 16),
                  
                  // 2. Generate the list dynamically
                  if (_inProgressTasks.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("No tasks remaining!", style: TextStyle(color: Colors.grey)),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true, // Vital for nested ListViews
                      physics: const NeverScrollableScrollPhysics(), // Let the main page scroll
                      itemCount: _inProgressTasks.length,
                      itemBuilder: (context, index) {
                        final task = _inProgressTasks[index];
                        return _buildSwipeableListItem(
                          index,
                          task['icon'],
                          task['title'],
                          task['subtitle'],
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildSwipeableListItem(int index, IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16), // Margin is outside the slide area
      child: Slidable(
        key: ValueKey(title), // Unique key for animation
        
        // The Action Pane (The Red Button)
        endActionPane: ActionPane(
          motion: const ScrollMotion(), // Smooth slide animation
          extentRatio: 0.25, // Button takes 25% of width
          children: [
            // Custom Delete Button
            CustomSlidableAction(
              onPressed: (context) => _deleteItem(index),
              backgroundColor: Colors.transparent, // Transparent to show our container decoration
              foregroundColor: Colors.white,
              padding: const EdgeInsets.only(left: 8), // Gap between card and button
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFD32F2F), // Red color
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
                child: const Center(
                  child: Icon(Icons.delete_outline, color: Colors.white, size: 28),
                ),
              ),
            ),
          ],
        ),

        // The Main Card Content
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
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
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textDark)),
                    Text(subtitle,
                        style: const TextStyle(fontSize: 13, color: AppColors.textLight)),
                  ],
                ),
              ),
              const Icon(Icons.more_vert, color: AppColors.textLight),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryPurple : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: isActive ? null : Border.all(color: Colors.grey.shade300),
      ),
      child: Text(label,
          style: TextStyle(
              color: isActive ? Colors.white : AppColors.textLight, fontWeight: FontWeight.w600)),
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(date, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ),
          const SizedBox(height: 20),
          Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, height: 1.2)),
          const Spacer(),
          const Text("Progress", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
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
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
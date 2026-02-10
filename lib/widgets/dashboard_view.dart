import 'package:flutter/material.dart';
import '../utils/colors.dart';

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
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: const AssetImage('assets/icon/profile.jpeg'),
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
                  FilterChipWidget(label: "My Tasks", isActive: true),
                  FilterChipWidget(label: "Pending", isActive: false),
                  FilterChipWidget(label: "Completed", isActive: false),
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
                  ProjectCardWidget(title: "Mobile App\nDesign", date: "Oct 24", progress: 0.7),
                  const SizedBox(width: 16),
                  ProjectCardWidget(title: "Website\nRedesign", date: "Nov 01", progress: 0.4),
                  const SizedBox(width: 16),
                  ProjectCardWidget(title: "Dashboard\nAnalytics", date: "Dec 12", progress: 0.9),
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
                  const Text(
                    "In Progress",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListItemWidget(
                    icon: Icons.cloud_upload,
                    title: "Upload Assets",
                    subtitle: "Waiting for approval",
                  ),
                  ListItemWidget(
                    icon: Icons.brush,
                    title: "Icon Set Design",
                    subtitle: "40/50 Icons done",
                  ),
                  ListItemWidget(
                    icon: Icons.code,
                    title: "Frontend Logic",
                    subtitle: "Login flow debugging",
                  ),
                ],
              ),
            ),
          ],
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
}

class ListItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ListItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
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
    );
  }
}


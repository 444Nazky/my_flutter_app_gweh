import 'package:flutter/material.dart';
import '../utils/colors.dart';

class AppNavbar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const AppNavbar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<AppNavbar> createState() => _AppNavbarState();
}

class _AppNavbarState extends State<AppNavbar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // CHANGED: Added shape and notch margin
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0, 
      color: Colors.white,
      elevation: 0,
      clipBehavior: Clip.antiAlias, // Ensures the notch curve is smooth
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(Icons.home_rounded, 'Home', 0),
            _buildNavItem(Icons.check_circle_outline, 'To-Do', 1),
            const SizedBox(width: 60), // Spacer for FAB
            _buildNavItem(Icons.history, 'History', 2),
            _buildNavItem(Icons.person_outline, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isActive = widget.selectedIndex == index;
    return InkWell(
      onTap: () => widget.onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primaryPurple : AppColors.textLight,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? AppColors.primaryPurple : AppColors.textLight,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
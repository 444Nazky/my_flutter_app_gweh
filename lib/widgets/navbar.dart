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
      shape: const CircularNotchedRectangle(),
      notchMargin: 7.0,
      color: Colors.white,
      child: SizedBox(
        height: 0,
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
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    final bool isActive = widget.selectedIndex == index;
    return IconButton(
      icon: Icon(
        icon,
        color: isActive ? AppColors.primaryBlue : AppColors.textLight,
        size: 28,
      ),
      onPressed: () => widget.onItemTapped(index),
    );
  }
}


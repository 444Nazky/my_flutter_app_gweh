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
  
  Matrix4 _getNavTransform(bool isActive) {
    if (isActive) {
      return Matrix4.identity()..translate(0, -4);
    }
    return Matrix4.identity();
  }
  
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Colors.white,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildAnimatedNavItem(Icons.home_rounded, 'Home', 0),
            _buildAnimatedNavItem(Icons.check_circle_outline, 'To-Do', 1),
            const SizedBox(width: 60),
            _buildAnimatedNavItem(Icons.history, 'History', 2),
            _buildAnimatedNavItem(Icons.person_outline, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedNavItem(IconData icon, String label, int index) {
    final bool isActive = widget.selectedIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      transform: _getNavTransform(isActive),
      child: InkWell(
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
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isActive ? 4 : 0,
              width: isActive ? 4 : 0,
              decoration: BoxDecoration(
                color: AppColors.primaryPurple,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
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
      ),
    );
  }
}


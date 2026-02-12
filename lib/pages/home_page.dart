import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/dashboard_view.dart';
import '../widgets/navbar.dart';
import 'history_page.dart';
import 'profile_page.dart';
import 'submit_report_page.dart';
import 'todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
      floatingActionButton: SizedBox(
        height: 65,
        width: 65,
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.92,
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F6FA),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: const SubmitReportPage(),
              ),
            );
          },
          backgroundColor: AppColors.primaryPurple,
          shape: const CircleBorder(),
          elevation: 4,
          child: const Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ),
      // CHANGE HERE: Use the custom location with an offset
      // Increase 'offsetY' to move it lower. 
      // 0 = standard docked. 20 = 20 pixels lower.
      floatingActionButtonLocation: const CenterDockedLowered(offsetY: 20),
      bottomNavigationBar: AppNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

// --- Add this class at the bottom of the file ---

class CenterDockedLowered extends FloatingActionButtonLocation {
  final double offsetY;
  const CenterDockedLowered({this.offsetY = 0});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    // 1. Get the standard "centerDocked" position
    final Offset offset = FloatingActionButtonLocation.centerDocked.getOffset(scaffoldGeometry);
    
    // 2. Add your custom Y-offset to push it downp=
    return Offset(offset.dx, offset.dy + offsetY);
  }
}
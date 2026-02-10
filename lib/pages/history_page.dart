import 'package:flutter/material.dart';
import '../utils/colors.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("History Page", style: TextStyle(color: AppColors.textLight))),
    );
  }
}
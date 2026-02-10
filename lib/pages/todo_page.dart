import 'package:flutter/material.dart';
import '../utils/colors.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("To-Do Page", style: TextStyle(color: AppColors.textLight))),
    );
  }
}
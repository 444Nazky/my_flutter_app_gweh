import 'package:flutter/material.dart';
import '../utils/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/icon/profile.jpeg'),
            ),
            const SizedBox(height: 20),
            const Text("User Name", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text("user@email.com", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            const Icon(Icons.settings, size: 40, color: AppColors.primaryPurple),
          ],
        ),
      ),
    );
  }
}


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
          children: const [
            CircleAvatar(radius: 50, backgroundImage: NetworkImage('https://i.pravatar.cc/150')),
            SizedBox(height: 20),
            Text("User Name", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("user@email.com", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 30),
            Icon(Icons.settings, size: 40, color: AppColors.primaryPurple),
          ],
        ),
      ),
    );
  }
}
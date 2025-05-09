import 'package:eCommerce/data/service/auth/auth_service.dart';
import 'package:eCommerce/presentation/screens/auth/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final AuthService _authService = AuthService();

  void _logout() async {
    await _authService.signOut();
    Get.offAll(() => const SignInScreen());
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("My Profile"), centerTitle: true),
      body:
          user == null
              ? const Center(child: Text("No user logged in"))
              : Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email: ${user.email ?? "Not Available"}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Name: ${user.displayName ?? "Not Set"}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'UID: ${user.uid}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _logout,
                        child: const Text("Logout"),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}

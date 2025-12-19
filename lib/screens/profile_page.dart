// lib/screens/profile_page.dart
import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'settings_page.dart'; // Import to access EditProfilePage

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String loungeName = 'Colombo Gold Lounge';
  String ownerName = 'Alex Johnson';
  String contactNumber = '07436900899';
  String emailAddress = 'alex@skylinelounge.com';
  String location = 'NO.133, Katunayaka';

  void _editProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          initialName: loungeName,
          initialLocation: location,
          initialContact: contactNumber,
        ),
      ),
    );

    if (result is Map<String, String>) {
      setState(() {
        loungeName = result['name'] ?? loungeName;
        location = result['location'] ?? location;
        contactNumber = result['contact'] ?? contactNumber;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile image
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile_avatar.png'), // replace with your image
              ),
              const SizedBox(height: 20),

              // Info Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildInfoRow(Icons.local_cafe, 'Lounge Name', loungeName),
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.person, 'Owner Name', ownerName),
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.phone, 'Contact Number', contactNumber),
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.email, 'Email Address', emailAddress),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Edit Profile button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _editProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

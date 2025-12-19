import 'package:flutter/material.dart';

class RegisterLoungeLocationPage extends StatelessWidget {
  const RegisterLoungeLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ✅ ORANGE HEADER WITH BACK BUTTON
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFFF8C1A),
        elevation: 0,
        toolbarHeight: 70,
        title: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/lounge/register'),
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            const SizedBox(width: 8),
            const Text(
              "Register Lounge",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),

      // ✅ BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),

            const Text(
              "Location and Contact",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "Where is your lounge located",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            // ✅ ADDRESS FIELD
            _inputField(
              icon: Icons.person,
              hint: "Address",
            ),

            const SizedBox(height: 20),

            // ✅ CONTACT NUMBER FIELD
            _inputField(
              icon: Icons.call,
              hint: "Contact Number",
            ),

            const SizedBox(height: 30),

            // ✅ MAP SELECT BOX
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1E6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black),
              ),
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.location_on, size: 28),
            ),

            const SizedBox(height: 10),

            const Text(
              "Tap the location button to select precise\ncoordinates",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),

            const SizedBox(height: 30),

            // ✅ NEXT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8C1A),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Navigate to photos and gallery screen
                  Navigator.pushNamed(context, '/lounge/photos-gallery');
                },
                child: const Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ✅ REUSABLE INPUT FIELD (MATCHES YOUR UI)
  Widget _inputField({required IconData icon, required String hint}) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

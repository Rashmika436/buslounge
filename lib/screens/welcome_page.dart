import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
        ),
        title: const Text(
          'Welcome to Bus Lounge',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/admin/dashboard'),
            icon: const Icon(Icons.home, color: Color(0xFFFF8C1A)),
            label: const Text(
              'Home',
              style: TextStyle(
                color: Color(0xFFFF8C1A),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),

      // -------------------------------
      // ✅ BODY
      // -------------------------------
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Text(
                "Welcome to Bus Lounge!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Start earning by listing your lounge for bus travelers",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 40),

              // -------------------------------
              // ✅ NO LOUNGE CARD
              // -------------------------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEBDD),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: const [
                    Icon(Icons.store, size: 40),
                    SizedBox(height: 10),
                    Text(
                      "No Lounge Listed Yet",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // -------------------------------
              // ✅ LIST YOUR LOUNGE BUTTON
              // -------------------------------
              _buildOrangeButton(
                text: "List Your Lounge",
                onTap: () {
                  Navigator.pushNamed(context, '/lounge/register');
                },
              ),
            ],
          ),
        ),
      ),

      // -------------------------------
      // ✅ BOTTOM NAVIGATION BAR
      // -------------------------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/admin/dashboard');
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airport_shuttle),
            label: "Transport",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Staff",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: "Bookings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Market",
          ),
        ],
      ),
    );
  }

  // -------------------------------
  // ✅ ORANGE BUTTON COMPONENT
  // -------------------------------
  Widget _buildOrangeButton({
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

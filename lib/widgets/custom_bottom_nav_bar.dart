import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFFFF8C1A),
      unselectedItemColor: Colors.black54,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      elevation: 8,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 28),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.apartment, size: 28),
          label: 'Lounge',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people, size: 28),
          label: 'Community',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_box, size: 28),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart, size: 28),
          label: 'Cart',
        ),
      ],
      onTap: (index) {
        // Navigate based on selected icon
        switch (index) {
          case 0: // Home
            Navigator.pushNamed(context, '/dashboard');
            break;
          case 1: // Lounge/Building
            Navigator.pushNamed(context, '/lounge');
            break;
          case 2: // People/Community
            Navigator.pushNamed(context, '/passengerBookingDetails');
            break;
          case 3: // Checkmark/Tasks/Schedule
            Navigator.pushNamed(context, '/bus/schedule');
            break;
          case 4: // Shopping Cart
            Navigator.pushNamed(context, '/marketplace');
            break;
        }
      },
    );
  }
}

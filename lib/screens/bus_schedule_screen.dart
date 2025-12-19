import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class BusScheduleScreen extends StatelessWidget {
  const BusScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFFFF8C1A),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 72, bottom: 16), // Adjust for leading icon
              title: const Text(
                'Up Coming Bus Schedule',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8C1A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Next Arrivals Today',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  BusCard(
                    busNumber: 'Express 101',
                    route: 'Colombo-Negambo',
                    time: '1:00 PM',
                    status: 'Ontime',
                  ),
                  const SizedBox(height: 12),
                  BusCard(
                    busNumber: '',
                    route: '',
                    time: '',
                    status: '',
                    isPlaceholder: true,
                  ),
                  const SizedBox(height: 12),
                  BusCard(
                    busNumber: '',
                    route: '',
                    time: '',
                    status: '',
                    isPlaceholder: true,
                  ),
                  const SizedBox(height: 12),
                  BusCard(
                    busNumber: '',
                    route: '',
                    time: '',
                    status: '',
                    isPlaceholder: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BusCard extends StatelessWidget {
  final String busNumber;
  final String route;
  final String time;
  final String status;
  final bool isPlaceholder;

  const BusCard({
    super.key,
    required this.busNumber,
    required this.route,
    required this.time,
    required this.status,
    this.isPlaceholder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.directions_bus, size: 40, color: Colors.grey),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isPlaceholder) ...[
                  Text(
                    busNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    route,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ] else
                  Column(
                    children: [
                      Container(height: 20, color: Colors.grey.shade300),
                      const SizedBox(height: 8),
                      Container(height: 16, color: Colors.grey.shade300),
                    ],
                  ),
              ],
            ),
          ),
          if (!isPlaceholder) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFF8C1A)),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Color(0xFFFF8C1A),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ] else
            Column(
              children: [
                Container(width: 50, height: 20, color: Colors.grey.shade300),
                const SizedBox(height: 8),
                Container(width: 40, height: 16, color: Colors.grey.shade300),
              ],
            ),
        ],
      ),
    );
  }
}
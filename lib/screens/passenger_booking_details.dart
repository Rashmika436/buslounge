import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class PassengerBookingDetails extends StatelessWidget {
  const PassengerBookingDetails({super.key});

  // sample bookings (replace with real data later)
  List<Map<String, String>> _sampleBookings() => [
        {'name': 'Sarah', 'route': 'Colombo → Kandy', 'time': '08:30 AM', 'seat': 'B3'},
        {'name': 'John', 'route': 'Colombo → Galle', 'time': '09:30 AM', 'seat': 'A1'},
        {'name': 'Ali', 'route': 'Colombo → Jaffna', 'time': '02:15 PM', 'seat': 'C4'},
      ];

  @override
  Widget build(BuildContext context) {
    final bookings = _sampleBookings();
    final today = DateTime.now();
    final days = List.generate(7, (i) => today.add(Duration(days: i)));

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F9),

      // Bottom navigation bar
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFF8C1A),
        elevation: 0,
        title: const Text('All Bookings for Today'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/lounge/booking'),
        ),
      ),

      body: Column(
        children: [
          // Search field
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search booking or passenger',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Date strip
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(Icons.calendar_today_outlined, size: 18),
                      SizedBox(width: 8),
                      Text('Calendar', style: TextStyle(fontWeight: FontWeight.w600)),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 64,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        final d = days[i];
                        final isToday = d.day == today.day &&
                            d.month == today.month &&
                            d.year == today.year;
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/lounge/booking');
                          },
                          child: Container(
                            width: 64,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: isToday ? const Color(0xFFFF8C1A) : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isToday ? Colors.transparent : Colors.grey.shade200,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][d.weekday % 7],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isToday ? Colors.white : Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${d.day}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: isToday ? Colors.white : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemCount: days.length,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bookings header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bookings',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ),

          // Booking list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 24, left: 12, right: 12),
              itemCount: bookings.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, idx) {
                final b = bookings[idx];
                return _BookingCard(
                  name: b['name'] ?? '',
                  route: b['route'] ?? '',
                  time: b['time'] ?? '',
                  seat: b['seat'] ?? '',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final String name;
  final String route;
  final String time;
  final String seat;

  const _BookingCard({
    required this.name,
    required this.route,
    required this.time,
    required this.seat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.person, color: Color(0xFFFF8C1A), size: 30),
          ),
          const SizedBox(width: 12),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 14, color: Colors.black45),
                    const SizedBox(width: 6),
                    Expanded(child: Text(route, style: const TextStyle(color: Colors.black54))),
                    const SizedBox(width: 8),
                    const Icon(Icons.schedule, size: 14, color: Colors.black45),
                    const SizedBox(width: 6),
                    Text(time, style: const TextStyle(color: Colors.black54)),
                  ],
                )
              ],
            ),
          ),
          // Seat + action
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFF7E8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(seat, style: const TextStyle(fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 6),
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Open booking for $name')),
                  );
                },
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          )
        ],
      ),
    );
  }
}

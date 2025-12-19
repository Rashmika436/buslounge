// lib/screens/lounge_booking.dart
import 'package:flutter/material.dart';
import 'booking_confirmation_screen.dart';

class LoungeBookingScreen extends StatefulWidget {
  const LoungeBookingScreen({super.key});

  @override
  State<LoungeBookingScreen> createState() => _LoungeBookingScreenState();
}

class _LoungeBookingScreenState extends State<LoungeBookingScreen> {
  // Example lounge title
  final String loungeName = 'Colombo Gold Lounge';

  // Time durations (with example prices)
  final List<_ChoiceItem> durations = [
    _ChoiceItem(label: '1 hour (LKR 700)', price: 700),
    _ChoiceItem(label: '2 hours (LKR 900)', price: 900),
    _ChoiceItem(label: '3 hours (LKR 1200)', price: 1200),
    _ChoiceItem(label: 'Until bus departure\n(LKR 600)', price: 600, badge: 'Recommended'),
  ];

  // Additional services
  final List<_ServiceItem> services = [
    _ServiceItem(name: 'Premium Meals', price: 800),
    _ServiceItem(name: 'Express Lounge', price: 200),
    _ServiceItem(name: 'Cargo Storage', price: 400),
    _ServiceItem(name: 'Meeting Room Access', price: 500),
    _ServiceItem(name: 'Spa Services', price: 400),
    _ServiceItem(name: 'Personal Assistant', price: 300),
    _ServiceItem(name: 'Airport Transfer', price: 400),
  ];

  // Selected indices / states
  int selectedDurationIndex = 0;
  int adultCount = 1;
  int childCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F2),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loungeName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Select Time Duration',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    ..._buildDurationTiles(),
                    const SizedBox(height: 16),
                    const Text(
                      'Additional Services',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    ..._buildServiceTiles(),
                    const SizedBox(height: 18),
                    const Text(
                      'Number of Guest',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    _buildGuestCounter('Adult', adultCount, (val) {
                      setState(() => adultCount = val);
                    }),
                    const SizedBox(height: 8),
                    _buildGuestCounter('Child', childCount, (val) {
                      setState(() => childCount = val);
                    }),
                    const SizedBox(height: 26),
                    _buildConfirmButton(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header with orange curved top and back arrow
  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF6931E), // warm orange
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).maybePop(),
            customBorder: const CircleBorder(),
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Lounge Booking',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build duration options as selectable rounded tiles
  List<Widget> _buildDurationTiles() {
    List<Widget> tiles = [];
    for (int i = 0; i < durations.length; i++) {
      final d = durations[i];
      tiles.add(
        GestureDetector(
          onTap: () => setState(() => selectedDurationIndex = i),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: selectedDurationIndex == i ? Colors.grey.shade100 : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: selectedDurationIndex == i ? Colors.grey.shade400 : Colors.grey.shade300,
              ),
              boxShadow: selectedDurationIndex == i
                  ? [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ]
                  : null,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    d.label,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                if (d.badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      d.badge!,
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }
    return tiles;
  }

  // Build services as rows with small rounded "pill" price on the right
  List<Widget> _buildServiceTiles() {
    List<Widget> tiles = [];
    for (int i = 0; i < services.length; i++) {
      final s = services[i];
      tiles.add(
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              // checkbox style
              GestureDetector(
                onTap: () => setState(() => s.selected = !s.selected),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: s.selected ? const Color(0xFFF6931E) : Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade100, blurRadius: 4, offset: const Offset(0,2)),
                    ],
                  ),
                  child: s.selected
                      ? const Icon(Icons.check, color: Colors.white, size: 20)
                      : const Icon(Icons.local_activity, color: Colors.black54, size: 18), // small icon placeholder
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  s.name,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('LKR ${s.price}', style: const TextStyle(fontSize: 13)),
              ),
            ],
          ),
        ),
      );
    }
    return tiles;
  }

  // Guest counter row
  Widget _buildGuestCounter(String label, int value, ValueChanged<int> onChanged) {
    return Row(
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 4, offset: const Offset(0,2))],
          ),
          child: Row(
            children: [
              _counterButton('-', () {
                if (value > 0) onChanged(value - 1);
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Text('$value', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              _counterButton('+', () {
                onChanged(value + 1);
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _counterButton(String sign, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 36,
        alignment: Alignment.center,
        child: Text(sign, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ),
    );
  }

  // Confirm button
  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF6931E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          elevation: 2,
        ),
        onPressed: _onConfirm,
        child: const Text('Confirm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }

  void _onConfirm() {
    // Navigate to booking confirmation screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BookingConfirmationScreen(),
      ),
    );
  }
}

/// small helper classes for demo data
class _ChoiceItem {
  final String label;
  final int price;
  final String? badge;
  _ChoiceItem({required this.label, required this.price, this.badge});
}

class _ServiceItem {
  final String name;
  final int price;
  bool selected;
  _ServiceItem({required this.name, required this.price, this.selected = false});
}

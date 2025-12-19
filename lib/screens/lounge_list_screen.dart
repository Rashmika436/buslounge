import 'package:flutter/material.dart';

/// LoungeListScreen - Displays a comprehensive list of all lounges
/// 
/// This screen shows all lounges owned/managed by the admin with:
/// - Summary statistics (Total, Approved, Pending counts)
/// - Detailed lounge cards with ratings, facilities, and pricing
/// - Quick action buttons (Edit and View)
/// - Filter and add new lounge options
/// 
/// Features:
/// - Visual status badges (Approved/Pending)
/// - Facility tags display
/// - Capacity and pricing information
/// - Navigation to lounge details and edit pages
class LoungeListScreen extends StatefulWidget {
  const LoungeListScreen({super.key});

  @override
  State<LoungeListScreen> createState() => _LoungeListScreenState();
}

class _LoungeListScreenState extends State<LoungeListScreen> {
  // Sample lounge data
  final List<Map<String, dynamic>> _lounges = [
    {
      'title': 'Sky Terrace Lounge',
      'location': '123 Downtown Plaza, Colombo',
      'owner': 'John Smith',
      'capacity': '50-80 people',
      'price': 'LKR 1,250/hr',
      'status': 'Approved',
      'rating': 4.8,
      'facilities': ['Wi-Fi', 'A/C', 'Parking', 'Cafeteria'],
      'date': 'Nov 20, 2025',
    },
    {
      'title': 'Elite Business Hub',
      'location': '45 Business District, Tower A',
      'owner': 'Sarah Johnson',
      'capacity': '30-50 people',
      'price': 'LKR 980/hr',
      'status': 'Approved',
      'rating': 4.6,
      'facilities': ['Wi-Fi', 'A/C', 'Entertainment'],
      'date': 'Nov 18, 2025',
    },
    {
      'title': 'Comfort Zone Lounge',
      'location': 'Airport Terminal 2, Katunayake',
      'owner': 'Mike Chen',
      'capacity': '40-60 people',
      'price': 'LKR 1,100/hr',
      'status': 'Pending',
      'rating': 4.7,
      'facilities': ['Wi-Fi', 'Rest Rooms', 'Charging Ports'],
      'date': 'Nov 19, 2025',
    },
    {
      'title': 'Sunset View Lounge',
      'location': '78 Beach Road, Galle',
      'owner': 'Emma Wilson',
      'capacity': '60-100 people',
      'price': 'LKR 1,500/hr',
      'status': 'Approved',
      'rating': 4.9,
      'facilities': ['Wi-Fi', 'A/C', 'Parking', 'Entertainment', 'Cafeteria'],
      'date': 'Nov 15, 2025',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black12,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pushReplacementNamed(context, '/admin/dashboard'),
        ),
        centerTitle: true,
        title: const Text(
          "My Lounges",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Color(0xFFFF8C1A)),
            onPressed: () {
              Navigator.pushNamed(context, '/lounge/create');
            },
          ),
        ],
      ),

      // ---------------- BODY ----------------
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF8C1A), Color(0xFFFF6B00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF8C1A).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryItem(Icons.apartment, '${_lounges.length}', 'Total'),
                  Container(width: 1, height: 40, color: Colors.white30),
                  _buildSummaryItem(Icons.check_circle, '${_lounges.where((l) => l['status'] == 'Approved').length}', 'Approved'),
                  Container(width: 1, height: 40, color: Colors.white30),
                  _buildSummaryItem(Icons.pending, '${_lounges.where((l) => l['status'] == 'Pending').length}', 'Pending'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Section Header
            Row(
              children: [
                const Text(
                  "All Lounges",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list, size: 18),
                  label: const Text('Filter'),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFFF8C1A),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Lounge List
            Expanded(
              child: ListView.builder(
                itemCount: _lounges.length,
                itemBuilder: (context, index) {
                  final lounge = _lounges[index];
                  return _buildLoungeCard(context, lounge);
                },
              ),
            ),
          ],
        ),
      ),

      // ---------------- BOTTOM NAVIGATION ----------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFFFF8C1A),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.apartment), label: "Lounges"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Staff"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Shop"),
        ],
      ),
    );
  }

  // ---------------- SUMMARY ITEM WIDGET ----------------
  Widget _buildSummaryItem(IconData icon, String count, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 6),
        Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // ---------------- LOUNGE CARD WIDGET ----------------
  Widget _buildLoungeCard(BuildContext context, Map<String, dynamic> lounge) {
    final isApproved = lounge['status'] == 'Approved';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Header with Status Badge
          Stack(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade100, Colors.orange.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(Icons.apartment, size: 64, color: Colors.white70),
              ),
              
              // Status Badge
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isApproved ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isApproved ? Icons.check_circle : Icons.pending,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        lounge['status'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Rating
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        lounge['title'],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Color(0xFFFF8C1A), size: 14),
                          const SizedBox(width: 4),
                          Text(
                            lounge['rating'].toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFF8C1A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Location
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Color(0xFFFF8C1A)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        lounge['location'],
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Capacity
                Row(
                  children: [
                    const Icon(Icons.people, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      lounge['capacity'],
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Price
                Row(
                  children: [
                    const Icon(Icons.attach_money, size: 16, color: Colors.green),
                    const SizedBox(width: 6),
                    Text(
                      lounge['price'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Facilities
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: (lounge['facilities'] as List<String>).map((facility) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        facility,
                        style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 12),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/lounge/edit');
                        },
                        icon: const Icon(Icons.edit, size: 16),
                        label: const Text('Edit'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFFF8C1A),
                          side: const BorderSide(color: Color(0xFFFF8C1A)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/lounge/details');
                        },
                        icon: const Icon(Icons.visibility, size: 16),
                        label: const Text('View'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8C1A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

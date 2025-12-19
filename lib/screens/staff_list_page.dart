import 'package:flutter/material.dart';

class StaffListPage extends StatefulWidget {
  const StaffListPage({super.key});

  @override
  State<StaffListPage> createState() => _StaffListPageState();
}

class _StaffListPageState extends State<StaffListPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushReplacementNamed(context, '/admin/dashboard'),
        ),
        title: const Text(
          "Staff List",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Column(
        children: [
          // ---------------- TAB BAR ----------------
          Container(
            color: Colors.white,
            child: TabBar(
              controller: tabController,
              labelColor: const Color(0xFFFF8C1A),
              unselectedLabelColor: Colors.black54,
              indicatorColor: const Color(0xFFFF8C1A),
              tabs: const [
                Tab(text: "Lounge"),
                Tab(text: "Staff"),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                // Lounge Tab Empty View
                Center(
                  child: Text(
                    "No Lounge Data",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                ),

                // Staff Tab Empty View
                Stack(
                  children: [
                    Center(
                      child: Text(
                        "No Staff Added Yet",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14),
                      ),
                    ),

                    // Add Staff Button
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/staff/register');
                        },
                        icon: const Icon(Icons.add, color: Colors.black),
                        label: const Text(
                          "Add Staff",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          backgroundColor: const Color(0xffd4c2b4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
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

      // ---------------- BOTTOM NAV BAR ----------------
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.home, size: 28),
            Icon(Icons.apartment, size: 28, color: Color(0xFFFF8C1A)),
            Icon(Icons.group, size: 28),
            Icon(Icons.check_box, size: 28),
            Icon(Icons.shopping_cart, size: 28),
          ],
        ),
      ),
    );
  }
}

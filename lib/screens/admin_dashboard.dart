import 'package:flutter/material.dart';

/// AdminDashboardPage - Main dashboard screen for admin users
/// 
/// This page provides an overview and quick access to admin functionalities including:
/// - Staff management
/// - Marketplace management  
/// - Lounge profile editing
/// - Statistics display (Active Lounges, Total Staff)
/// 
/// The page features a welcome banner, statistics cards, quick action tiles,
/// and bottom navigation for easy access to different sections.
class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Color scheme constants for consistent theming
    const Color orange = Color(0xFFFF8C1A); // Primary brand color
    const Color pageBg = Color(0xFFFFFBF5); // Light cream background
    const Color headerBg = Color(0xFFFDEEE6); // Peach header background
    const double cardRadius = 14.0; // Standard border radius for cards

    return Scaffold(
      backgroundColor: pageBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          child: Column(
            children: [
              // ==================== TOP NAVIGATION BAR ====================
              // Back button and notification icon
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/admin/home'),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  ),
                  const Text(
                    'Admin Dashboard',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      // TODO: open notifications
                    },
                    icon: const Icon(Icons.notifications_none),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // ==================== WELCOME CARD ====================
              // Displays personalized greeting and admin avatar
              // Provides quick context about the admin's role
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: headerBg,
                  borderRadius: BorderRadius.circular(cardRadius),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                child: Row(
                  children: [
                    // Welcome texts
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Welcome back, Admin 👋',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Manage your lounge operations',
                            style: TextStyle(fontSize: 13, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),

                    // Small bell / avatar placeholder
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.person, color: Colors.black87),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ==================== STATISTICS ROW ====================
              // Displays quick access to bookings and bus schedule
              // Provides at-a-glance navigation to key features
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: 'All Bookings',
                      subtitle: 'Today',
                      icon: Icons.event_available,
                      background: Colors.white,
                      onTap: () {
                        Navigator.pushNamed(context, '/today/bookings');
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      title: 'Upcoming',
                      subtitle: 'Bus Schedule',
                      icon: Icons.directions_bus,
                      background: Colors.white,
                      onTap: () {
                        Navigator.pushNamed(context, '/bus/schedule');
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // ==================== QUICK ACTIONS HEADER ====================
              // Section title for administrative action tiles
              Row(
                children: const [
                  Text(
                    'Quick Actions',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ==================== ACTION TILES LIST ====================
              // Scrollable list of quick action cards for:
              // - Staff management
              // - Marketplace updates
              // - Lounge profile editing
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _QuickActionTile(
                      title: 'Add Staff Members',
                      subtitle: 'Add or manage your staff members easily',
                      actionText: 'Manage Staff →',
                      onTap: () {
                        Navigator.pushNamed(context, '/staff/register');
                      },
                    ),
                    const SizedBox(height: 12),
                    _QuickActionTile(
                      title: 'Manage Marketplace',
                      subtitle: 'Update marketplace details or featured items',
                      actionText: 'Open Marketplace →',
                      onTap: () {
                        Navigator.pushNamed(context, '/marketplace/edit');
                      },
                    ),
                    const SizedBox(height: 12),
                    _QuickActionTile(
                      title: 'Edit Lounge Details',
                      subtitle: 'Update lounge profile & details',
                      actionText: 'Open Lounge profile →',
                      onTap: () {
                        Navigator.pushNamed(context, '/lounge/edit');
                      },
                    ),
                    const SizedBox(height: 12),
                    _QuickActionTile(
                      title: 'Add Tuk Tuk Details',
                      subtitle: 'Add and manage tuk tuk service details',
                      actionText: 'Add Tuk Tuk →',
                      onTap: () {
                        Navigator.pushNamed(context, '/tuktuk/add');
                      },
                    ),

                    // Add small bottom spacing so content doesn't hide under bottom nav
                    const SizedBox(height: 26),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom navigation bar
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 8,
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavIcon(
                icon: Icons.home_outlined,
                label: 'Home',
                onTap: () {
                  // TODO: navigate to home/dashboard
                },
              ),
              _NavIcon(
                icon: Icons.storefront_outlined,
                label: 'Lounges',
                onTap: () {
                  // TODO: lounges
                },
              ),
              _NavIcon(
                icon: Icons.group_outlined,
                label: 'Staff',
                onTap: () {
                  // TODO: staff list
                },
              ),
              _NavIcon(
                icon: Icons.receipt_long_outlined,
                label: 'Bookings',
                onTap: () {
                  // TODO: bookings
                },
              ),
              _NavIcon(
                icon: Icons.shopping_cart_outlined,
                label: 'Shop',
                onTap: () {
                  Navigator.pushNamed(context, '/marketplace');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==============================================================================
// HELPER WIDGETS - Private widget classes used within AdminDashboardPage
// ==============================================================================

/// _StatCard - Statistics display card widget
/// 
/// A compact card component that displays a key metric with an icon.
/// Used in the admin dashboard to show statistics and provide quick navigation.
/// 
/// Properties:
/// - [title]: The main statistic value or label
/// - [subtitle]: Description of the statistic
/// - [icon]: Icon representing the statistic category
/// - [background]: Background color of the card
/// - [onTap]: Optional callback when card is tapped
class _StatCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color background;
  final VoidCallback? onTap;

  const _StatCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.background,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double radius = 12;
    const Color orange = Color(0xFFFF8C1A);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            // Icon box
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: orange.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: orange),
            ),
            const SizedBox(width: 12),
            // Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// _QuickActionTile - Interactive action card for quick navigation
/// 
/// A clickable card that provides quick access to admin functionalities.
/// Features a title, subtitle description, action text, and navigation callback.
/// 
/// Properties:
/// - [title]: Main heading of the action
/// - [subtitle]: Brief description of what the action does
/// - [actionText]: Call-to-action text displayed on the right (e.g., "Manage Staff →")
/// - [onTap]: Callback function executed when the tile is tapped
class _QuickActionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String actionText;
  final VoidCallback onTap;

  const _QuickActionTile({
    required this.title,
    required this.subtitle,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color orange = Color(0xFFFF8C1A);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 4)),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: orange.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.add_box_outlined, size: 22),
            ),
            const SizedBox(width: 14),
            // text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                          const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(subtitle,
                      style: const TextStyle(fontSize: 13, color: Colors.black54)),
                ],
              ),
            ),
            // action text
            Text(actionText,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: orange)),
          ],
        ),
      ),
    );
  }
}

/// _NavIcon - Bottom navigation bar icon button
/// 
/// A custom navigation icon with label used in the bottom navigation bar.
/// Provides visual feedback and navigation to different sections of the app.
/// 
/// Properties:
/// - [icon]: Icon to display in the navigation bar
/// - [label]: Text label shown below the icon
/// - [onTap]: Callback function when the icon is tapped
class _NavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavIcon({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: SizedBox(
        width: 56,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: Colors.black87),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.black54),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

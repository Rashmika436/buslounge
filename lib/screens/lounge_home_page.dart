import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../services/lounge_service.dart';
import '../models/lounge.dart';

class LoungeHomePage extends StatefulWidget {
  const LoungeHomePage({super.key});

  @override
  State<LoungeHomePage> createState() => _LoungeHomePageState();
}

class _LoungeHomePageState extends State<LoungeHomePage> {
  final LoungeService _loungeService = LoungeService();
  bool _isLoading = true;
  List<Lounge> _lounges = [];
  String? _errorMessage;
  
  final String _loungeOwnerId = 'a022caf0-ebd6-4d18-9557-48886c930fd5';

  @override
  void initState() {
    super.initState();
    _loadLounges();
  }

  Future<void> _loadLounges() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Use empty list for now (no lounges)
      setState(() {
        _lounges = [];
        _isLoading = false;
      });
      
      /* // Original API call - commented out
      final response = await _loungeService.getLounges(
        loungeOwnerId: _loungeOwnerId,
      );

      if (response.success && response.data != null) {
        setState(() {
          _lounges = response.data!;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = response.message;
          _isLoading = false;
        });
      }
      */
    } catch (e) {
      setState(() {
        _lounges = [];
        _isLoading = false;
      });
    }
  }

  void _navigateToRegisterLounge() async {
    final result = await Navigator.pushNamed(context, '/lounge/register');
    if (result == true) {
      _loadLounges();
    }
  }

  void _viewLoungeDetails(Lounge lounge) {
    Navigator.pushNamed(
      context,
      '/lounge/details',
      arguments: lounge,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF8C1A),
        title: const Text('My Lounges', style: TextStyle(color: Colors.white)),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: _navigateToRegisterLounge,
            tooltip: 'Add Lounge',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 60, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(_errorMessage!, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadLounges,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _lounges.isEmpty
                  ? _buildEmptyState()
                  : _buildLoungeList(),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.storefront_rounded,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text(
              "No Lounges Yet",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Start earning by listing your lounge for bus travelers",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _navigateToRegisterLounge,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8C1A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  "List Your Lounge",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoungeList() {
    return RefreshIndicator(
      onRefresh: _loadLounges,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _lounges.length,
        itemBuilder: (context, index) {
          final lounge = _lounges[index];
          return _buildLoungeCard(lounge);
        },
      ),
    );
  }

  Widget _buildLoungeCard(Lounge lounge) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _viewLoungeDetails(lounge),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      lounge.loungeName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildStatusChip(lounge.status),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${lounge.city ?? 'N/A'}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.people_outline, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Capacity: ${lounge.capacity}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.attach_money, size: 16, color: Colors.grey),
                  Text(
                    'LKR ${lounge.pricePerHour}/hr',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              if (lounge.facilities.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: lounge.facilities.take(3).map((facility) {
                    return Chip(
                      label: Text(
                        facility,
                        style: const TextStyle(fontSize: 11),
                      ),
                      backgroundColor: Colors.orange.shade50,
                      padding: const EdgeInsets.all(2),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bgColor;
    Color textColor;
    
    switch (status.toLowerCase()) {
      case 'active':
        bgColor = Colors.green.shade50;
        textColor = Colors.green.shade700;
        break;
      case 'pending':
        bgColor = Colors.orange.shade50;
        textColor = Colors.orange.shade700;
        break;
      case 'approved':
        bgColor = Colors.blue.shade50;
        textColor = Colors.blue.shade700;
        break;
      default:
        bgColor = Colors.grey.shade200;
        textColor = Colors.grey.shade700;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

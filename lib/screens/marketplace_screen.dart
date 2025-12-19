import 'package:flutter/material.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  int _selectedTab = 0;
  
  // Track quantities for each product (index -> quantity)
  final Map<int, int> _cartQuantities = {};

  final List<String> _tabs = ['All', 'Drinks', 'Snacks', 'Essentials'];

  final List<Map<String, dynamic>> _products = [
    {'name': 'Water Bottle 500ml', 'price': 150.0, 'icon': Icons.water_drop, 'color': const Color(0xFF2196F3), 'category': 'Drinks'},
    {'name': 'Chocolate Cookies', 'price': 250.0, 'icon': Icons.cookie, 'color': const Color(0xFF8D6E63), 'category': 'Snacks'},
    {'name': 'Orange Juice', 'price': 200.0, 'icon': Icons.local_drink, 'color': const Color(0xFFFF9800), 'category': 'Drinks'},
    {'name': 'Potato Chips', 'price': 180.0, 'icon': Icons.fastfood, 'color': const Color(0xFFFFC107), 'category': 'Snacks'},
    {'name': 'Hot Coffee', 'price': 300.0, 'icon': Icons.coffee, 'color': const Color(0xFF795548), 'category': 'Drinks'},
    {'name': 'Energy Bar', 'price': 220.0, 'icon': Icons.bakery_dining, 'color': const Color(0xFF4CAF50), 'category': 'Snacks'},
    {'name': 'Soft Drink 330ml', 'price': 175.0, 'icon': Icons.local_cafe, 'color': const Color(0xFFE91E63), 'category': 'Drinks'},
    {'name': 'Club Sandwich', 'price': 450.0, 'icon': Icons.lunch_dining, 'color': const Color(0xFFFF5722), 'category': 'Snacks'},
    {'name': 'Fresh Milk', 'price': 120.0, 'icon': Icons.emoji_food_beverage, 'color': const Color(0xFFFFFFFF), 'category': 'Drinks'},
    {'name': 'Ice Cream', 'price': 280.0, 'icon': Icons.icecream, 'color': const Color(0xFFFFB6C1), 'category': 'Snacks'},
    {'name': 'Pizza Slice', 'price': 350.0, 'icon': Icons.local_pizza, 'color': const Color(0xFFFF6347), 'category': 'Snacks'},
    {'name': 'Green Tea', 'price': 180.0, 'icon': Icons.free_breakfast, 'color': const Color(0xFF8BC34A), 'category': 'Drinks'},
  ];

  int get _cartCount => _cartQuantities.values.fold(0, (sum, qty) => sum + qty);

  double get _total {
    double total = 0.0;
    _cartQuantities.forEach((index, qty) {
      total += (_products[index]['price'] as double) * qty;
    });
    return total;
  }

  void _addItem(int productIndex) {
    setState(() {
      _cartQuantities[productIndex] = (_cartQuantities[productIndex] ?? 0) + 1;
    });
  }

  void _removeItem(int productIndex) {
    setState(() {
      final currentQty = _cartQuantities[productIndex] ?? 0;
      if (currentQty > 1) {
        _cartQuantities[productIndex] = currentQty - 1;
      } else {
        _cartQuantities.remove(productIndex);
      }
    });
  }

  int _getQuantity(int productIndex) => _cartQuantities[productIndex] ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushReplacementNamed(context, '/admin/dashboard'),
        ),
        title: const Text('Marketplace', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Color(0xFFFF8C1A)),
                onPressed: () => Navigator.pushNamed(context, '/payment'),
              ),
              if (_cartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text('$_cartCount', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedTab = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _selectedTab == index ? const Color(0xFFFF8C1A) : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(_tabs[index], style: TextStyle(color: _selectedTab == index ? Colors.white : const Color(0xFFFF8C1A), fontWeight: FontWeight.bold)),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemCount: _tabs.length,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.75, crossAxisSpacing: 16, mainAxisSpacing: 16),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  final quantity = _getQuantity(index);
                  final inCart = quantity > 0;
                  
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [(product['color'] as Color).withOpacity(0.3), (product['color'] as Color).withOpacity(0.1)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                            ),
                            child: Center(child: Icon(product['icon'] as IconData, size: 64, color: product['color'] as Color)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Text('LKR ${product['price']}', style: const TextStyle(color: Color(0xFFFF8C1A), fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                height: 36,
                                child: inCart
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () => _removeItem(index),
                                              child: Container(
                                                decoration: BoxDecoration(color: const Color(0xFFFF8C1A), borderRadius: BorderRadius.circular(8)),
                                                child: const Icon(Icons.remove, color: Colors.white, size: 20),
                                              ),
                                            ),
                                          ),
                                          Expanded(flex: 2, child: Container(alignment: Alignment.center, child: Text('$quantity', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)))),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () => _addItem(index),
                                              child: Container(
                                                decoration: BoxDecoration(color: const Color(0xFFFF8C1A), borderRadius: BorderRadius.circular(8)),
                                                child: const Icon(Icons.add, color: Colors.white, size: 20),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : ElevatedButton.icon(
                                        onPressed: () => _addItem(index),
                                        icon: const Icon(Icons.add_shopping_cart, size: 16),
                                        label: const Text('Add', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF8C1A), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(horizontal: 8)),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _cartCount > 0
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2))],
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.shopping_cart, color: Color(0xFFFF8C1A), size: 28),
                          const SizedBox(width: 8),
                          Text('$_cartCount items', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Total', style: TextStyle(fontSize: 14, color: Colors.black54)),
                              Text('LKR ${_total.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/payment'),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF8C1A), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0),
                          child: const Text('Checkout', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
    );
  }
}

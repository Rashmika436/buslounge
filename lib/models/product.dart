class Product {
  final String productId;
  final String loungeId;
  final String productName;
  final String description;
  final String category;
  final double price;
  final int stockQuantity;
  final bool isAvailable;
  final String? imageUrl;
  final DateTime createdAt;

  Product({
    required this.productId,
    required this.loungeId,
    required this.productName,
    required this.description,
    required this.category,
    required this.price,
    required this.stockQuantity,
    required this.isAvailable,
    this.imageUrl,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'] ?? '',
      loungeId: json['lounge_id'] ?? '',
      productName: json['product_name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      stockQuantity: json['stock_quantity'] ?? 0,
      isAvailable: json['is_available'] ?? false,
      imageUrl: json['image_url'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class BusSchedule {
  final String scheduleId;
  final String routeId;
  final String routeName;
  final String busNumber;
  final String departureTime;
  final String arrivalTime;
  final double fare;
  final int availableSeats;
  final String status;

  BusSchedule({
    required this.scheduleId,
    required this.routeId,
    required this.routeName,
    required this.busNumber,
    required this.departureTime,
    required this.arrivalTime,
    required this.fare,
    required this.availableSeats,
    required this.status,
  });

  factory BusSchedule.fromJson(Map<String, dynamic> json) {
    return BusSchedule(
      scheduleId: json['schedule_id'] ?? '',
      routeId: json['route_id'] ?? '',
      routeName: json['route_name'] ?? '',
      busNumber: json['bus_number'] ?? '',
      departureTime: json['departure_time'] ?? '',
      arrivalTime: json['arrival_time'] ?? '',
      fare: (json['fare'] ?? 0).toDouble(),
      availableSeats: json['available_seats'] ?? 0,
      status: json['status'] ?? 'scheduled',
    );
  }
}

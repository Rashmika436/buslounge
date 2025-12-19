class Lounge {
  final String loungeId;
  final String loungeName;
  final String description;
  final String address;
  final String city;
  final String contactNumber;
  final String? contactEmail;
  final int capacity;
  final double pricePerHour;
  final List<String> facilities;
  final String status;
  final double? rating;
  final int? totalReviews;
  final String? openingTime;
  final String? closingTime;
  final DateTime createdAt;

  Lounge({
    required this.loungeId,
    required this.loungeName,
    required this.description,
    required this.address,
    required this.city,
    required this.contactNumber,
    this.contactEmail,
    required this.capacity,
    required this.pricePerHour,
    required this.facilities,
    required this.status,
    this.rating,
    this.totalReviews,
    this.openingTime,
    this.closingTime,
    required this.createdAt,
  });

  factory Lounge.fromJson(Map<String, dynamic> json) {
    return Lounge(
      loungeId: json['lounge_id'] ?? '',
      loungeName: json['lounge_name'] ?? '',
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      contactNumber: json['contact_number'] ?? '',
      contactEmail: json['contact_email'],
      capacity: json['capacity'] ?? 0,
      pricePerHour: (json['price_per_hour'] ?? 0).toDouble(),
      facilities: json['facilities'] != null 
          ? List<String>.from(json['facilities'])
          : [],
      status: json['status'] ?? 'pending',
      rating: json['rating']?.toDouble(),
      totalReviews: json['total_reviews'],
      openingTime: json['opening_time'],
      closingTime: json['closing_time'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lounge_name': loungeName,
      'description': description,
      'address': address,
      'city': city,
      'contact_number': contactNumber,
      'contact_email': contactEmail,
      'capacity': capacity,
      'price_per_hour': pricePerHour,
      'facilities': facilities,
      'opening_time': openingTime,
      'closing_time': closingTime,
    };
  }
}

class CreateLoungeRequest {
  final String loungeName;
  final String description;
  final String address;
  final String city;
  final String contactNumber;
  final String? contactEmail;
  final int capacity;
  final double pricePerHour;
  final List<String> facilities;
  final String openingTime;
  final String closingTime;

  CreateLoungeRequest({
    required this.loungeName,
    required this.description,
    required this.address,
    required this.city,
    required this.contactNumber,
    this.contactEmail,
    required this.capacity,
    required this.pricePerHour,
    required this.facilities,
    required this.openingTime,
    required this.closingTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'lounge_name': loungeName,
      'description': description,
      'address': address,
      'city': city,
      'contact_number': contactNumber,
      'contact_email': contactEmail,
      'capacity': capacity,
      'price_per_hour': pricePerHour,
      'facilities': facilities,
      'opening_time': openingTime,
      'closing_time': closingTime,
    };
  }
}

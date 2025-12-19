class Booking {
  final String loungeBookingId;
  final String loungeId;
  final String loungeName;
  final String guestName;
  final String guestPhone;
  final String? guestEmail;
  final int numberOfAdults;
  final int numberOfChildren;
  final String bookingDate;
  final String checkInTime;
  final String? checkOutTime;
  final String durationType;
  final String bookingReference;
  final double basePrice;
  final double serviceCharges;
  final double totalPrice;
  final String status;
  final String? specialRequests;
  final DateTime createdAt;

  Booking({
    required this.loungeBookingId,
    required this.loungeId,
    required this.loungeName,
    required this.guestName,
    required this.guestPhone,
    this.guestEmail,
    required this.numberOfAdults,
    required this.numberOfChildren,
    required this.bookingDate,
    required this.checkInTime,
    this.checkOutTime,
    required this.durationType,
    required this.bookingReference,
    required this.basePrice,
    required this.serviceCharges,
    required this.totalPrice,
    required this.status,
    this.specialRequests,
    required this.createdAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      loungeBookingId: json['lounge_booking_id'] ?? '',
      loungeId: json['lounge_id'] ?? '',
      loungeName: json['lounge_name'] ?? '',
      guestName: json['guest_name'] ?? '',
      guestPhone: json['guest_phone'] ?? '',
      guestEmail: json['guest_email'],
      numberOfAdults: json['number_of_adults'] ?? 0,
      numberOfChildren: json['number_of_children'] ?? 0,
      bookingDate: json['booking_date'] ?? '',
      checkInTime: json['check_in_time'] ?? '',
      checkOutTime: json['check_out_time'],
      durationType: json['duration_type'] ?? '',
      bookingReference: json['booking_reference'] ?? '',
      basePrice: (json['base_price'] ?? 0).toDouble(),
      serviceCharges: (json['service_charges'] ?? 0).toDouble(),
      totalPrice: (json['total_price'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      specialRequests: json['special_requests'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class DashboardStats {
  final int totalLounges;
  final int pendingLounges;
  final int activeLounges;
  final int currentBookings;
  final int upcomingBookings;
  final double todayRevenue;
  final double occupancyRate;

  DashboardStats({
    required this.totalLounges,
    required this.pendingLounges,
    required this.activeLounges,
    required this.currentBookings,
    required this.upcomingBookings,
    required this.todayRevenue,
    required this.occupancyRate,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalLounges: json['total_lounges'] ?? 0,
      pendingLounges: json['pending_lounges'] ?? 0,
      activeLounges: json['active_lounges'] ?? 0,
      currentBookings: json['current_bookings'] ?? 0,
      upcomingBookings: json['upcoming_bookings'] ?? 0,
      todayRevenue: (json['today_revenue'] ?? 0).toDouble(),
      occupancyRate: (json['occupancy_rate'] ?? 0).toDouble(),
    );
  }
}

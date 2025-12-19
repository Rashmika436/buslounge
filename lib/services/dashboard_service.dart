import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/booking.dart';
import 'api_config.dart';

class DashboardService {
  // Get dashboard statistics
  Future<ApiResponse<DashboardStats>> getDashboardStats({
    required String loungeOwnerId,
  }) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/dashboard/stats')
          .replace(queryParameters: {'lounge_owner_id': loungeOwnerId});

      final response = await http
          .get(uri, headers: ApiConfig.headers)
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final stats = DashboardStats.fromJson(jsonData['data']);

        return ApiResponse<DashboardStats>(
          success: jsonData['success'] ?? true,
          message: jsonData['message'] ?? 'Stats retrieved successfully',
          data: stats,
        );
      } else {
        final errorData = json.decode(response.body);
        throw ApiException(
          errorData['message'] ?? 'Failed to fetch dashboard stats',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }
}

class BookingService {
  // Get all bookings for a lounge owner
  Future<ApiResponse<List<Booking>>> getBookings({
    required String loungeOwnerId,
    String? loungeId,
    String? status,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final queryParams = {
        'lounge_owner_id': loungeOwnerId,
        'page': page.toString(),
        'per_page': perPage.toString(),
        if (loungeId != null) 'lounge_id': loungeId,
        if (status != null) 'status': status,
      };

      final uri = Uri.parse('${ApiConfig.baseUrl}/bookings')
          .replace(queryParameters: queryParams);

      final response = await http
          .get(uri, headers: ApiConfig.headers)
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final bookings = (jsonData['data'] as List)
            .map((item) => Booking.fromJson(item))
            .toList();

        return ApiResponse<List<Booking>>(
          success: jsonData['success'] ?? true,
          message: jsonData['message'] ?? 'Bookings retrieved successfully',
          data: bookings,
          pagination: jsonData['pagination'],
        );
      } else {
        final errorData = json.decode(response.body);
        throw ApiException(
          errorData['message'] ?? 'Failed to fetch bookings',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  // Get today's bookings
  Future<ApiResponse<List<Booking>>> getTodayBookings({
    required String loungeOwnerId,
  }) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/bookings/today')
          .replace(queryParameters: {'lounge_owner_id': loungeOwnerId});

      final response = await http
          .get(uri, headers: ApiConfig.headers)
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final bookings = (jsonData['data'] as List)
            .map((item) => Booking.fromJson(item))
            .toList();

        return ApiResponse<List<Booking>>(
          success: jsonData['success'] ?? true,
          message: jsonData['message'] ?? 'Today\'s bookings retrieved',
          data: bookings,
        );
      } else {
        final errorData = json.decode(response.body);
        throw ApiException(
          errorData['message'] ?? 'Failed to fetch today\'s bookings',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  // Update booking status
  Future<ApiResponse<Booking>> updateBookingStatus({
    required String bookingId,
    required String status,
  }) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/bookings/$bookingId/status');

      final response = await http
          .patch(
            uri,
            headers: ApiConfig.headers,
            body: json.encode({'status': status}),
          )
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final booking = Booking.fromJson(jsonData['data']);

        return ApiResponse<Booking>(
          success: jsonData['success'] ?? true,
          message: jsonData['message'] ?? 'Booking status updated',
          data: booking,
        );
      } else {
        final errorData = json.decode(response.body);
        throw ApiException(
          errorData['message'] ?? 'Failed to update booking status',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }
}

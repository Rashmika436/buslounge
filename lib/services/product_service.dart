import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import 'api_config.dart';

class ProductService {
  // Get products for a lounge
  Future<ApiResponse<List<Product>>> getProducts({
    required String loungeId,
    String? category,
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      final queryParams = {
        'lounge_id': loungeId,
        'page': page.toString(),
        'per_page': perPage.toString(),
        if (category != null) 'category': category,
      };

      final uri = Uri.parse('${ApiConfig.baseUrl}/products')
          .replace(queryParameters: queryParams);

      final response = await http
          .get(uri, headers: ApiConfig.headers)
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final products = (jsonData['data'] as List)
            .map((item) => Product.fromJson(item))
            .toList();

        return ApiResponse<List<Product>>(
          success: jsonData['success'] ?? true,
          message: jsonData['message'] ?? 'Products retrieved successfully',
          data: products,
          pagination: jsonData['pagination'],
        );
      } else {
        final errorData = json.decode(response.body);
        throw ApiException(
          errorData['message'] ?? 'Failed to fetch products',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }
}

class BusScheduleService {
  // Get today's bus schedules
  Future<ApiResponse<List<BusSchedule>>> getTodaySchedules() async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/bus-schedules/today');

      final response = await http
          .get(uri, headers: ApiConfig.headers)
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final schedules = (jsonData['data'] as List)
            .map((item) => BusSchedule.fromJson(item))
            .toList();

        return ApiResponse<List<BusSchedule>>(
          success: jsonData['success'] ?? true,
          message: jsonData['message'] ?? 'Schedules retrieved successfully',
          data: schedules,
        );
      } else {
        final errorData = json.decode(response.body);
        throw ApiException(
          errorData['message'] ?? 'Failed to fetch schedules',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }
}

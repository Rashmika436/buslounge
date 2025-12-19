import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lounge.dart';
import 'api_config.dart';

class LoungeService {
  // Get all lounges for a lounge owner
  Future<ApiResponse<List<Lounge>>> getLounges({
    required String loungeOwnerId,
    int page = 1,
    int perPage = 10,
    String? status,
    String? city,
  }) async {
    try {
      final queryParams = {
        'lounge_owner_id': loungeOwnerId,
        'page': page.toString(),
        'per_page': perPage.toString(),
        if (status != null) 'status': status,
        if (city != null) 'city': city,
      };

      final uri = Uri.parse('${ApiConfig.baseUrl}/lounges')
          .replace(queryParameters: queryParams);

      final response = await http
          .get(uri, headers: ApiConfig.headers)
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        
        // Handle null or empty data
        final dataList = jsonData['data'];
        final lounges = (dataList != null && dataList is List)
            ? dataList.map((item) => Lounge.fromJson(item)).toList()
            : <Lounge>[];

        return ApiResponse<List<Lounge>>(
          success: jsonData['success'] ?? true,
          message: jsonData['message'] ?? 'Lounges retrieved successfully',
          data: lounges,
          pagination: jsonData['pagination'],
        );
      } else {
        final errorData = json.decode(response.body);
        throw ApiException(
          errorData['message'] ?? 'Failed to fetch lounges',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  // Create a new lounge
  Future<ApiResponse<Lounge>> createLounge({
    required String loungeOwnerId,
    required CreateLoungeRequest request,
  }) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/lounges')
          .replace(queryParameters: {'lounge_owner_id': loungeOwnerId});

      final response = await http
          .post(
            uri,
            headers: ApiConfig.headers,
            body: json.encode(request.toJson()),
          )
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        final lounge = Lounge.fromJson(jsonData['data']);

        return ApiResponse<Lounge>(
          success: jsonData['success'] ?? true,
          message: jsonData['message'] ?? 'Lounge created successfully',
          data: lounge,
        );
      } else {
        final errorData = json.decode(response.body);
        throw ApiException(
          errorData['message'] ?? 'Failed to create lounge',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  // Get lounge by ID
  Future<ApiResponse<Lounge>> getLoungeById(String loungeId) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/lounges/$loungeId');

      final response = await http
          .get(uri, headers: ApiConfig.headers)
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final lounge = Lounge.fromJson(jsonData['data']);

        return ApiResponse<Lounge>(
          success: jsonData['success'] ?? true,
          message: jsonData['message'] ?? 'Lounge retrieved successfully',
          data: lounge,
        );
      } else {
        final errorData = json.decode(response.body);
        throw ApiException(
          errorData['message'] ?? 'Failed to fetch lounge',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  // Update lounge
  Future<ApiResponse<Lounge>> updateLounge({
    required String loungeId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/lounges/$loungeId');

      final response = await http
          .put(
            uri,
            headers: ApiConfig.headers,
            body: json.encode(updates),
          )
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final lounge = Lounge.fromJson(jsonData['data']);

        return ApiResponse<Lounge>(
          success: jsonData['success'] ?? true,
          message: jsonData['message'] ?? 'Lounge updated successfully',
          data: lounge,
        );
      } else {
        final errorData = json.decode(response.body);
        throw ApiException(
          errorData['message'] ?? 'Failed to update lounge',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  // Delete lounge
  Future<ApiResponse<void>> deleteLounge(String loungeId) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/lounges/$loungeId');

      final response = await http
          .delete(uri, headers: ApiConfig.headers)
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        return ApiResponse<void>(
          success: jsonData['success'] ?? true,
          message: jsonData['message'] ?? 'Lounge deleted successfully',
        );
      } else {
        final errorData = json.decode(response.body);
        throw ApiException(
          errorData['message'] ?? 'Failed to delete lounge',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }
}

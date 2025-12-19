import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiConfig {
  // IMPORTANT: Update this based on your testing device:
  // - Android Emulator: http://10.0.2.2:8080/api/v1 (CURRENT)
  // - iOS Simulator: http://localhost:8080/api/v1
  // - Physical Device: http://192.168.43.180:8080/api/v1
  
  // Using Android Emulator special IP (10.0.2.2 maps to host machine's localhost)
  static const String baseUrl = 'http://10.0.2.2:8080/api/v1';
  
  static const Duration timeout = Duration(seconds: 30);

  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
}

class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final dynamic error;
  final Map<String, dynamic>? pagination;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.error,
    this.pagination,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'],
      error: json['error'],
      pagination: json['pagination'],
    );
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

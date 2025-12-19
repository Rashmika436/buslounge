import 'dart:async';
import 'dart:math';

/// OTP Service for sending and verifying One-Time Passwords
/// 
/// This service handles:
/// - Generating random 6-digit OTP codes
/// - Sending OTP to phone numbers (simulated for now)
/// - Verifying OTP codes with timeout
/// - Managing OTP expiration (5 minutes)
class OtpService {
  // Store OTP codes temporarily (in production, this should be backend storage)
  final Map<String, _OtpData> _otpStorage = {};
  
  // OTP configuration
  static const int otpLength = 6;
  static const Duration otpExpiration = Duration(minutes: 5);
  
  /// Generate a random 6-digit OTP
  String _generateOtp() {
    final random = Random();
    String otp = '';
    for (int i = 0; i < otpLength; i++) {
      otp += random.nextInt(10).toString();
    }
    return otp;
  }
  
  /// Send OTP to phone number
  /// Returns true if OTP was sent successfully
  /// In production, this would call an SMS gateway API
  Future<OtpResponse> sendOtp(String phoneNumber) async {
    try {
      // Validate phone number format (Sri Lankan format)
      if (!_isValidPhoneNumber(phoneNumber)) {
        return OtpResponse(
          success: false,
          message: 'Invalid phone number format',
        );
      }
      
      // Generate OTP
      final otp = _generateOtp();
      
      // Store OTP with expiration time
      _otpStorage[phoneNumber] = _OtpData(
        otp: otp,
        expiresAt: DateTime.now().add(otpExpiration),
        attempts: 0,
      );
      
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));
      
      // In production, send SMS via API gateway
      print('📱 OTP sent to $phoneNumber: $otp'); // Debug only
      
      return OtpResponse(
        success: true,
        message: 'OTP sent successfully to $phoneNumber',
        otp: otp, // Only for testing - remove in production
      );
    } catch (e) {
      return OtpResponse(
        success: false,
        message: 'Failed to send OTP: ${e.toString()}',
      );
    }
  }
  
  /// Verify OTP code for a phone number
  /// Returns true if OTP is valid and not expired
  Future<OtpResponse> verifyOtp(String phoneNumber, String otp) async {
    try {
      // Check if OTP exists for this phone number
      if (!_otpStorage.containsKey(phoneNumber)) {
        return OtpResponse(
          success: false,
          message: 'No OTP found. Please request a new OTP.',
        );
      }
      
      final otpData = _otpStorage[phoneNumber]!;
      
      // Check if OTP is expired
      if (DateTime.now().isAfter(otpData.expiresAt)) {
        _otpStorage.remove(phoneNumber);
        return OtpResponse(
          success: false,
          message: 'OTP has expired. Please request a new OTP.',
        );
      }
      
      // Check maximum attempts
      if (otpData.attempts >= 3) {
        _otpStorage.remove(phoneNumber);
        return OtpResponse(
          success: false,
          message: 'Maximum verification attempts exceeded. Please request a new OTP.',
        );
      }
      
      // Increment attempts
      otpData.attempts++;
      
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Verify OTP
      if (otpData.otp == otp) {
        // OTP verified successfully - remove from storage
        _otpStorage.remove(phoneNumber);
        return OtpResponse(
          success: true,
          message: 'OTP verified successfully',
        );
      } else {
        final remainingAttempts = 3 - otpData.attempts;
        return OtpResponse(
          success: false,
          message: 'Invalid OTP. $remainingAttempts attempt${remainingAttempts == 1 ? '' : 's'} remaining.',
        );
      }
    } catch (e) {
      return OtpResponse(
        success: false,
        message: 'Failed to verify OTP: ${e.toString()}',
      );
    }
  }
  
  /// Validate Sri Lankan phone number format
  bool _isValidPhoneNumber(String phoneNumber) {
    final cleaned = phoneNumber.trim().replaceAll(RegExp(r'[\s-]'), '');
    // Sri Lankan phone format: 10 digits starting with 0
    final phoneRegex = RegExp(r'^0[0-9]{9}$');
    return phoneRegex.hasMatch(cleaned);
  }
  
  /// Clear OTP for a phone number (used for resend)
  void clearOtp(String phoneNumber) {
    _otpStorage.remove(phoneNumber);
  }
  
  /// Get remaining time for OTP expiration
  Duration? getRemainingTime(String phoneNumber) {
    if (!_otpStorage.containsKey(phoneNumber)) {
      return null;
    }
    final expiresAt = _otpStorage[phoneNumber]!.expiresAt;
    final remaining = expiresAt.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }
}

/// Internal class to store OTP data
class _OtpData {
  final String otp;
  final DateTime expiresAt;
  int attempts;
  
  _OtpData({
    required this.otp,
    required this.expiresAt,
    this.attempts = 0,
  });
}

/// Response class for OTP operations
class OtpResponse {
  final bool success;
  final String message;
  final String? otp; // Only for testing - remove in production
  
  OtpResponse({
    required this.success,
    required this.message,
    this.otp,
  });
}

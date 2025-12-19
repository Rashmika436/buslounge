/// RoleManager - Manages user roles and permissions throughout the app
/// 
/// This singleton class handles:
/// - Role storage and retrieval
/// - Permission checks for features
/// - Role-based navigation logic
/// 
/// Supported roles:
/// - Admin: Full access to all features
/// - Staff: Limited access to dashboard and lounge details

class RoleManager {
  // Singleton instance
  static final RoleManager _instance = RoleManager._internal();
  factory RoleManager() => _instance;
  RoleManager._internal();

  // User role storage
  String? _currentRole;
  String? _phoneNumber;

  // Role constants
  static const String roleAdmin = 'admin';
  static const String roleStaff = 'staff';

  /// Set the current user's role based on phone number
  void setRole(String phoneNumber) {
    _phoneNumber = phoneNumber;
    
    if (phoneNumber == '0710000001') {
      _currentRole = roleAdmin;
    } else if (phoneNumber == '0710000002') {
      _currentRole = roleStaff;
    } else {
      _currentRole = null; // Guest or undefined
    }
  }

  /// Get the current user's role
  String? get currentRole => _currentRole;

  /// Get the current user's phone number
  String? get phoneNumber => _phoneNumber;

  /// Check if current user is admin
  bool get isAdmin => _currentRole == roleAdmin;

  /// Check if current user is staff
  bool get isStaff => _currentRole == roleStaff;

  /// Check if user has access to a specific feature
  bool hasAccessTo(String feature) {
    if (_currentRole == null) return false;

    // Admin has access to everything
    if (isAdmin) return true;

    // Staff has limited access
    if (isStaff) {
      return _staffAllowedFeatures.contains(feature);
    }

    return false;
  }

  /// Features accessible to staff role
  static const List<String> _staffAllowedFeatures = [
    'dashboard',
    'lounge_details',
    'profile',
  ];

  /// Features accessible to admin role (all features)
  static const List<String> _adminAllowedFeatures = [
    'dashboard',
    'admin_dashboard',
    'lounge_list',
    'lounge_details',
    'marketplace',
    'staff_register',
    'edit_lounge',
    'create_lounge',
    'settings',
    'profile',
  ];

  /// Get all accessible features for current role
  List<String> getAccessibleFeatures() {
    if (isAdmin) return _adminAllowedFeatures;
    if (isStaff) return _staffAllowedFeatures;
    return [];
  }

  /// Clear role data (logout)
  void clearRole() {
    _currentRole = null;
    _phoneNumber = null;
  }
}

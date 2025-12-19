import 'package:flutter/material.dart';

/// AdminRegistrationPage - Registration form for new admin users
/// 
/// This page collects and validates admin information including:
/// - Personal details (First Name, Last Name)
/// - National Identity Card (NIC) - supports both old and new Sri Lankan formats
/// - Contact information (Email, Phone Number)
/// 
/// Features:
/// - Comprehensive input validation for all fields
/// - Sri Lankan NIC format validation (9 digits+V or 12 digits)
/// - Email format validation
/// - Phone number validation (10 digits starting with 0)
/// - Name validation (letters only, 2-50 characters)
/// - Navigates to admin dashboard upon successful submission
class AdminRegistrationPage extends StatefulWidget {
  const AdminRegistrationPage({Key? key}) : super(key: key);

  @override
  State<AdminRegistrationPage> createState() => _AdminRegistrationPageState();
}

class _AdminRegistrationPageState extends State<AdminRegistrationPage> {
  // ==============================================================================
  // FORM STATE - Form key and text field controllers
  // ==============================================================================
  final _formKey = GlobalKey<FormState>();

  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _nicCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  // ==============================================================================
  // VALIDATION METHODS - Input validation for form fields
  // ==============================================================================
  
  /// Validates name fields (first name, last name)
  /// - Checks for empty input
  /// - Ensures minimum 2 characters
  /// - Ensures maximum 50 characters
  /// - Only allows letters and spaces
  String? _validateName(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }
    if (value.trim().length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    if (value.trim().length > 50) {
      return '$fieldName must not exceed 50 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
      return '$fieldName should only contain letters';
    }
    return null;
  }

  /// Validates Sri Lankan National Identity Card (NIC) format
  /// - Checks for empty input
  /// - Accepts old format: 9 digits followed by V or X (e.g., 123456789V)
  /// - Accepts new format: 12 digits (e.g., 200012345678)
  String? _validateNIC(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter NIC';
    }
    final nic = value.trim();
    // Sri Lankan NIC format: Old (9 digits + V/X) or New (12 digits)
    final oldNICRegex = RegExp(r'^[0-9]{9}[vVxX]$');
    final newNICRegex = RegExp(r'^[0-9]{12}$');
    
    if (!oldNICRegex.hasMatch(nic) && !newNICRegex.hasMatch(nic)) {
      return 'Enter valid NIC (9 digits+V or 12 digits)';
    }
    return null;
  }

  /// Validates email address format
  /// - Checks for empty input
  /// - Validates proper email structure (user@domain.ext)
  /// - Ensures email doesn't exceed 100 characters
  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter email address';
    }
    final email = value.trim();
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    if (email.length > 100) {
      return 'Email must not exceed 100 characters';
    }
    return null;
  }

  /// Validates Sri Lankan phone number format
  /// - Checks for empty input
  /// - Expects 10 digits starting with 0 (e.g., 0771234567)
  /// - Automatically strips spaces and hyphens before validation
  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter phone number';
    }
    final phone = value.trim().replaceAll(RegExp(r'[\s-]'), '');
    // Sri Lankan phone format: 10 digits starting with 0
    final phoneRegex = RegExp(r'^0[0-9]{9}$');
    
    if (!phoneRegex.hasMatch(phone)) {
      return 'Enter valid phone (10 digits starting with 0)';
    }
    return null;
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _nicCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Replace with your submit logic (API call / navigation)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration submitted successfully')),
      );
      
      // Navigate to welcome page after admin registration
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF5F5F7),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // colors matching the screenshot
    const headerBg = Color(0xFFFDEEE6); // light peach
    const orange = Color(0xFFFF8C1A);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: orange,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
        title: const Text(
          'Admin Registration',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: ConstrainedBox(
              // keep card narrow similar to mobile screenshot
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header area with peach background and title
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: const BoxDecoration(
                        color: headerBg,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Admin Registration',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    // Body content
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
                      child: Column(
                        children: [
                          // Avatar and titles
                          const CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.black,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Complete Your Admin Profile',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Please provide your driver details for verification',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                          const SizedBox(height: 18),

                          // Form
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _firstNameCtrl,
                                  decoration: _fieldDecoration('First Name'),
                                  textCapitalization: TextCapitalization.words,
                                  validator: (v) => _validateName(v, 'First name'),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _lastNameCtrl,
                                  decoration: _fieldDecoration('Last Name'),
                                  textCapitalization: TextCapitalization.words,
                                  validator: (v) => _validateName(v, 'Last name'),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _nicCtrl,
                                  decoration: _fieldDecoration('NIC'),
                                  textCapitalization: TextCapitalization.characters,
                                  validator: _validateNIC,
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _emailCtrl,
                                  decoration: _fieldDecoration('Email Address'),
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  validator: _validateEmail,
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _phoneCtrl,
                                  decoration: _fieldDecoration('Phone Number'),
                                  keyboardType: TextInputType.phone,
                                  validator: _validatePhone,
                                ),
                                const SizedBox(height: 18),

                                // CTA button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _submit,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: orange,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: const Text(
                                      'Complete Registration',
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),
                              ],
                            ),
                          ),

                          // Small info box at bottom
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: headerBg,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'Your registration will be pending approval. You can view your profile while waiting for verification.',
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

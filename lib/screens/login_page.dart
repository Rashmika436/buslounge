import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/role_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController phoneController;
  late final TextEditingController otpController;
  bool _isOtpSent = false;
  bool _isLoading = false;
  int _resendTimer = 0;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _resendTimer = 60; // 60 seconds countdown
    });
    
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_resendTimer > 0 && mounted) {
        setState(() {
          _resendTimer--;
        });
        return true;
      }
      return false;
    });
  }

  Future<void> _sendOtp() async {
    final phone = phoneController.text.trim();
    
    if (phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 10-digit phone number'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // TODO: Implement actual OTP API call
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    if (mounted) {
      setState(() {
        _isLoading = false;
        _isOtpSent = true;
      });
      
      _startResendTimer();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP sent successfully! Check your messages.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _verifyOtp() async {
    final otp = otpController.text.trim();
    final phone = phoneController.text.trim();
    
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 6-digit OTP'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // TODO: Implement actual OTP verification API call
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      
      // Set user role based on phone number
      RoleManager().setRole(phone);
      
      // Role-based routing based on phone number
      // 0710000001 → Admin Registration → Welcome → Admin Dashboard
      // 0710000002 → Staff Dashboard
      if (phone == '0710000001') {
        Navigator.pushReplacementNamed(context, '/admin/register');
      } else if (phone == '0710000002') {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        // Default route for other phone numbers
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF8C1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Always navigate to the Startup page (root route '/')
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 30),

                // App Logo
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8C1A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.directions_bus_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 30),

                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _isOtpSent 
                      ? "Enter the OTP sent to your phone"
                      : "Enter your phone number to receive OTP",
                  style: const TextStyle(color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Phone number input
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  enabled: !_isOtpSent,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    hintText: "Phone number (10 digits)",
                    filled: true,
                    fillColor: _isOtpSent ? Colors.grey.shade100 : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    counterText: '',
                  ),
                ),
                const SizedBox(height: 20),

                // OTP input (shown only after OTP is sent)
                if (_isOtpSent) ...[
                  TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: "Enter 6-digit OTP",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      counterText: '',
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Resend OTP button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Didn't receive OTP? "),
                      if (_resendTimer > 0)
                        Text(
                          "Resend in ${_resendTimer}s",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      else
                        GestureDetector(
                          onTap: _sendOtp,
                          child: const Text(
                            "Resend OTP",
                            style: TextStyle(
                              color: Color(0xFFFF8C1A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],

                // Action Button (Send OTP or Verify OTP)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading 
                        ? null 
                        : (_isOtpSent ? _verifyOtp : _sendOtp),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8C1A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            _isOtpSent ? "Verify OTP" : "Send OTP",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                
                // Change phone number button (shown after OTP is sent)
                if (_isOtpSent) ...[
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isOtpSent = false;
                        otpController.clear();
                        _resendTimer = 0;
                      });
                    },
                    child: const Text(
                      "Change Phone Number",
                      style: TextStyle(
                        color: Color(0xFFFF8C1A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
                
                const SizedBox(height: 25),

                // Signup Navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Color(0xFFFF8C1A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

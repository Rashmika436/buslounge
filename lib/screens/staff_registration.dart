import 'package:flutter/material.dart';

class StaffRegistrationPage extends StatefulWidget {
  const StaffRegistrationPage({Key? key}) : super(key: key);

  @override
  State<StaffRegistrationPage> createState() => _StaffRegistrationPageState();
}

class _StaffRegistrationPageState extends State<StaffRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _nicCtrl = TextEditingController();
  String? _selectedLounge;

  final List<String> _lounges = [
    'Select lounge',
    'Sky Lounge',
    'Elite Business Hub',
    'Comfort Zone'
  ];

  @override
  void initState() {
    super.initState();
    _selectedLounge = _lounges[0];
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _nicCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Staff member added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Navigate to staff list page
      Navigator.pushReplacementNamed(context, '/staff/list');
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
    const Color orange = Color(0xFFFF8C1A);
    const Color pageBg = Color(0xFFFFFBF5);
    const Color headerBg = Color(0xFFFDEEE6);

    return Scaffold(
      backgroundColor: pageBg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: const BoxDecoration(
                        color: headerBg,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.maybePop(context),
                            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                          ),
                          const Expanded(
                            child: Center(
                              child: Text(
                                'Staff Registration',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 48), // space to keep title centered
                        ],
                      ),
                    ),

                    // body
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.black,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Complete Your Staff Profile',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Please provide your driver details for verification',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                          const SizedBox(height: 16),

                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nameCtrl,
                                  decoration: _fieldDecoration('Name'),
                                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter name' : null,
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _phoneCtrl,
                                  keyboardType: TextInputType.phone,
                                  decoration: _fieldDecoration('Phone Number'),
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) return 'Enter phone number';
                                    if (v.trim().length < 7) return 'Enter a valid phone';
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _nicCtrl,
                                  decoration: _fieldDecoration('NIC'),
                                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter NIC' : null,
                                ),
                                const SizedBox(height: 12),

                                // Lounge Dropdown
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5F5F7),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedLounge,
                                    items: _lounges.map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(e),
                                      );
                                    }).toList(),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        _selectedLounge = val;
                                      });
                                    },
                                    validator: (v) {
                                      if (v == null || v == _lounges[0]) return 'Please select a lounge';
                                      return null;
                                    },
                                  ),
                                ),

                                const SizedBox(height: 18),

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
                              ],
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTukTukPage extends StatefulWidget {
  const AddTukTukPage({super.key});

  @override
  State<AddTukTukPage> createState() => _AddTukTukPageState();
}

class _AddTukTukPageState extends State<AddTukTukPage> {
  final _formKey = GlobalKey<FormState>();

  final _driverNameController = TextEditingController();
  final _vehicleNumberController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _nicController = TextEditingController();

  String _selectedVehicleType = 'Three Wheeler';
  bool _isAvailable = true;

  @override
  void dispose() {
    _driverNameController.dispose();
    _vehicleNumberController.dispose();
    _contactNumberController.dispose();
    _nicController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tuk Tuk details added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacementNamed(context, '/tuktuk/settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF8C1A),
        title: const Text('Add Vehicle Details',
            style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Driver Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              TextFormField(
                controller: _driverNameController,
                decoration: _inputDecoration('Driver Name', Icons.person),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter driver name' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _nicController,
                decoration: _inputDecoration('NIC Number', Icons.badge),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter NIC number';
                  if (v.length != 10 && v.length != 12) {
                    return 'NIC must be 10 or 12 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _contactNumberController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: _inputDecoration('Contact Number', Icons.phone),
                validator: (v) =>
                    v == null || v.length != 10 ? 'Enter valid contact number' : null,
              ),
              const SizedBox(height: 24),

              const Text('Vehicle Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              TextFormField(
                controller: _vehicleNumberController,
                decoration:
                    _inputDecoration('Vehicle Number', Icons.directions_car),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter vehicle number' : null,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedVehicleType,
                decoration:
                    _inputDecoration('Vehicle Type', Icons.local_taxi),
                items: ['Three Wheeler', 'Van', 'Car']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedVehicleType = value!),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Color(0xFFFF8C1A)),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text('Availability Status',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    Switch(
                      value: _isAvailable,
                      activeColor: const Color(0xFFFF8C1A),
                      onChanged: (v) => setState(() => _isAvailable = v),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8C1A),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Add Tuk Tuk',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color(0xFFFF8C1A)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.white,
    );
  }
}

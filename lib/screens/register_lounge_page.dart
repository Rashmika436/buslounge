import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/lounge_service.dart';

class RegisterLoungePage extends StatefulWidget {
  const RegisterLoungePage({super.key});

  @override
  State<RegisterLoungePage> createState() => _RegisterLoungePageState();
}

class _RegisterLoungePageState extends State<RegisterLoungePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _loungeNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _beforeStopController = TextEditingController();
  final TextEditingController _afterStopController = TextEditingController();

  bool _isLoading = false;
  final LoungeService _loungeService = LoungeService();

  /// Available Routes
  final List<String> _availableRoutes = [
    'Colombo - Kandy',
    'Colombo - Galle',
    'Colombo - Jaffna',
    'Kandy - Badulla',
    'Galle - Matara',
  ];

  String? _selectedRoute;
  final List<String> _selectedRoutes = [];

  // Facilities
  final Map<String, bool> _facilities = {
    'wifi': false,
    'ac': false,
    'cafeteria': false,
    'charging_ports': false,
    'parking': false,
    'rest_rooms': false,
  };

  @override
  void dispose() {
    _loungeNameController.dispose();
    _cityController.dispose();
    _capacityController.dispose();
    _priceController.dispose();
    _beforeStopController.dispose();
    _afterStopController.dispose();
    super.dispose();
  }

  Future<void> _submitLounge() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedRoutes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one route'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Basic details saved!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamed(context, '/lounge/location-contact');
    }

    setState(() => _isLoading = false);
  }

  Widget _buildFacilityCheckbox(String label, String key, IconData icon) {
    return CheckboxListTile(
      title: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade700),
          const SizedBox(width: 12),
          Text(label),
        ],
      ),
      value: _facilities[key],
      onChanged: (value) {
        setState(() => _facilities[key] = value ?? false);
      },
      controlAffinity: ListTileControlAffinity.leading,
      dense: true,
      contentPadding: EdgeInsets.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              color: const Color(0xFFFF8C1A),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/welcome'),
                  ),
                  const Text(
                    'Register Lounge',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Basic Details',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),

                      /// Lounge Name
                      TextFormField(
                        controller: _loungeNameController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.business),
                          labelText: 'Lounge Name',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Enter lounge name' : null,
                      ),
                      const SizedBox(height: 15),

                      /// City
                      TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_city),
                          labelText: 'City',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Enter city' : null,
                      ),
                      const SizedBox(height: 15),

                      /// Routes Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedRoute,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.alt_route),
                          labelText: 'Select Route',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: _availableRoutes
                            .map(
                              (route) => DropdownMenuItem(
                                value: route,
                                child: Text(route),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null &&
                              !_selectedRoutes.contains(value)) {
                            setState(() {
                              _selectedRoutes.add(value);
                              _selectedRoute = null;
                            });
                          }
                        },
                      ),

                      /// Selected Routes Chips
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        children: _selectedRoutes
                            .map(
                              (route) => Chip(
                                label: Text(route),
                                deleteIcon: const Icon(Icons.close),
                                onDeleted: () {
                                  setState(
                                      () => _selectedRoutes.remove(route));
                                },
                              ),
                            )
                            .toList(),
                      ),

                      const SizedBox(height: 20),

                      /// Before Stop
                      TextFormField(
                        controller: _beforeStopController,
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.location_on_outlined),
                          labelText: 'Before Stop',
                          hintText: 'Eg: Kurunegala',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (v) => v == null || v.isEmpty
                            ? 'Enter before stop'
                            : null,
                      ),

                      const SizedBox(height: 15),

                      /// After Stop
                      TextFormField(
                        controller: _afterStopController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.flag_outlined),
                          labelText: 'After Stop',
                          hintText: 'Eg: Kandy',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (v) => v == null || v.isEmpty
                            ? 'Enter after stop'
                            : null,
                      ),

                      const SizedBox(height: 15),

                      /// Capacity
                      TextFormField(
                        controller: _capacityController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.people),
                          labelText: 'Capacity',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (v) => v == null || int.tryParse(v) == null
                            ? 'Enter valid capacity'
                            : null,
                      ),
                      const SizedBox(height: 15),

                      /// Price
                      TextFormField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.attach_money),
                          labelText: 'Price Per Hour (LKR)',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (v) => v == null || double.tryParse(v) == null
                            ? 'Enter valid price'
                            : null,
                      ),

                      const SizedBox(height: 25),

                      /// Facilities
                      const Text(
                        'Facilities',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          children: [
                            _buildFacilityCheckbox(
                                'Wi-Fi', 'wifi', Icons.wifi),
                            _buildFacilityCheckbox(
                                'AC', 'ac', Icons.ac_unit),
                            _buildFacilityCheckbox('Cafeteria', 'cafeteria',
                                Icons.restaurant),
                            _buildFacilityCheckbox(
                                'Charging Ports',
                                'charging_ports',
                                Icons.electrical_services),
                            _buildFacilityCheckbox('Parking', 'parking',
                                Icons.local_parking),
                            _buildFacilityCheckbox(
                                'Rest Rooms', 'rest_rooms', Icons.wc),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// Next Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed:
                              _isLoading ? null : _submitLounge,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFF8C1A),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(30),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

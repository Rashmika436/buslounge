import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateLoungePage extends StatefulWidget {
  const CreateLoungePage({super.key});

  @override
  State<CreateLoungePage> createState() => _CreateLoungePageState();
}

class _CreateLoungePageState extends State<CreateLoungePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();
  final TextEditingController _capacityCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();

  final Map<String, bool> _facilities = {
    'Wi-Fi': false,
    'A/C': false,
    'Cafeteria': false,
    'Charging Ports': false,
    'Entertainment': false,
    'Parking': false,
    'Rest Rooms': false,
    'Waiting Area': false,
  };

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _capacityCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  Widget _buildIconTile(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Icon(icon, size: 20, color: Colors.black87),
    );
  }

  InputDecoration _fieldDecoration({required Widget prefix}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 12, right: 8),
        child: prefix,
      ),
      prefixIconConstraints: const BoxConstraints(minWidth: 52, minHeight: 48),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade400, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: const Color(0xFFFF8832), width: 1.6),
      ),
    );
  }

  void _onNext() {
    if (_formKey.currentState!.validate()) {
      final selectedFacilities =
          _facilities.entries.where((e) => e.value).map((e) => e.key).toList();

      final loungeData = {
        'name': _nameCtrl.text.trim(),
        'description': _descCtrl.text.trim(),
        'capacity': _capacityCtrl.text.trim(),
        'price_per_hour': _priceCtrl.text.trim(),
        'facilities': selectedFacilities,
      };

      // Navigate to Register Lounge Page and pass data
      Navigator.pushNamed(
        context,
        '/lounge/register',
        arguments: loungeData,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the form')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    const cardTopRadius = 26.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F6),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color:  const Color(0xFFFF8832),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(cardTopRadius),
                  bottomRight: Radius.circular(cardTopRadius),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF8832),
                        shape: BoxShape.rectangle,
                      ),
                      child:
                          const Icon(Icons.arrow_back, color: Colors.white, size: 18),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Register Lounge',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Basic Information',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameCtrl,
                            decoration: _fieldDecoration(
                                    prefix: _buildIconTile(Icons.apartment))
                                .copyWith(hintText: 'Lounge Name'),
                            validator: (v) =>
                                (v == null || v.trim().isEmpty)
                                    ? 'Enter lounge name'
                                    : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _descCtrl,
                            decoration: _fieldDecoration(
                                    prefix: _buildIconTile(Icons.description))
                                .copyWith(hintText: 'Description'),
                            maxLines: 3,
                            validator: (v) =>
                                (v == null || v.trim().isEmpty)
                                    ? 'Enter a description'
                                    : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _capacityCtrl,
                            decoration: _fieldDecoration(
                                    prefix: _buildIconTile(Icons.people))
                                .copyWith(hintText: 'Capacity (numbers only)'),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Please enter capacity';
                              }
                              final capacity = int.tryParse(v.trim());
                              if (capacity == null) {
                                return 'Capacity must be a valid number';
                              }
                              if (capacity <= 0) {
                                return 'Capacity must be greater than 0';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _priceCtrl,
                            decoration: _fieldDecoration(
                                    prefix: _buildIconTile(Icons.attach_money))
                                .copyWith(hintText: 'Price per hour (numbers only)'),
                            keyboardType:
                                const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Please enter price per hour';
                              }
                              final price = double.tryParse(v.trim());
                              if (price == null) {
                                return 'Price must be a valid number';
                              }
                              if (price <= 0) {
                                return 'Price must be greater than 0';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text('Facilities', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 8,
                              offset: const Offset(0, 4))
                        ],
                      ),
                      child: Column(
                        children: _facilities.keys.map((key) {
                          return CheckboxListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(key, style: const TextStyle(fontSize: 14)),
                            value: _facilities[key],
                            onChanged: (v) =>
                                setState(() => _facilities[key] = v ?? false),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 26),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _onNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8832),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                        ),
                        child: const Text('Next',
                            style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                    SizedBox(height: mq.viewPadding.bottom + 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

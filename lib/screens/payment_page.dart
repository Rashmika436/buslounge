import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _nameCtrl = TextEditingController(text: 'John Doe');
  final _cardCtrl = TextEditingController(text: '1234 5678 9012 3456');
  final _expiryCtrl = TextEditingController();
  final _cvvCtrl = TextEditingController();
  bool saveCard = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _cardCtrl.dispose();
    _expiryCtrl.dispose();
    _cvvCtrl.dispose();
    super.dispose();
  }

  Widget _buildCardField({
    required String label,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.black87)),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  InputDecoration _baseDecoration({String? hintText, Widget? suffix}) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      suffixIcon: suffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with back arrow
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: const Icon(Icons.arrow_back_rounded),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Payment Details',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    // Order total card
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 1,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text('Order Total',
                                style: TextStyle(color: Colors.black54)),
                            SizedBox(height: 6),
                            Text('LKR 600',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w700)),
                            SizedBox(height: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.lock, size: 16, color: Colors.green),
                                SizedBox(width: 6),
                                Text('Secure checkout',
                                    style: TextStyle(color: Colors.green)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Payment information card
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Payment Information',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 12),

                            // Cardholder name
                            _buildCardField(
                              label: 'Cardholder Name',
                              child: TextField(
                                controller: _nameCtrl,
                                decoration:
                                    _baseDecoration(hintText: 'John Doe'),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Card number
                            _buildCardField(
                              label: 'Card Number',
                              child: TextField(
                                controller: _cardCtrl,
                                keyboardType: TextInputType.number,
                                decoration: _baseDecoration(
                                  hintText: '1234 5678 9012 3456',
                                  suffix: const Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.credit_card,
                                      color: Color(0xFFFF8C1A),
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Expiry and CVV row
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: _buildCardField(
                                      label: 'Expiry Date',
                                      child: TextField(
                                        controller: _expiryCtrl,
                                        keyboardType: TextInputType.datetime,
                                        decoration:
                                            _baseDecoration(hintText: 'MM/YY'),
                                      )),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 1,
                                  child: _buildCardField(
                                      label: 'CVV',
                                      child: TextField(
                                        controller: _cvvCtrl,
                                        keyboardType: TextInputType.number,
                                        obscureText: true,
                                        decoration:
                                            _baseDecoration(hintText: '123'),
                                      )),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Checkbox(
                                  value: saveCard,
                                  onChanged: (v) {
                                    setState(() {
                                      saveCard = v ?? false;
                                    });
                                  },
                                ),
                                const SizedBox(width: 6),
                                const Text('Save card for future purchases'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Accepted payment methods card
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      color: const Color(0xFFFFF4E6),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Accepted Payment Methods',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87)),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey.shade300),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.credit_card,
                                          color: Color(0xFF1A237E), size: 24),
                                      SizedBox(width: 6),
                                      Text('VISA',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1A237E))),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey.shade300),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.payment,
                                          color: Color(0xFFEB001B), size: 24),
                                      SizedBox(width: 6),
                                      Text('Mastercard',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFEB001B))),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 60), // space for the pay button
                  ],
                ),
              ),
            ),

            // Bottom pay button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: implement real payment flow
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pay Now tapped')),
                        );
                      },
                      icon: const Icon(Icons.lock_outline),
                      label: const Text('Pay Now - LKR 600',
                          style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6A3D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.shield, size: 16, color: Colors.green),
                      SizedBox(width: 6),
                      Text('Secure Payment Gateway',
                          style: TextStyle(fontSize: 12, color: Colors.black54)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

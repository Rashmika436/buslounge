import 'package:flutter/material.dart';

class TukTukServiceSettingsPage extends StatefulWidget {
  const TukTukServiceSettingsPage({super.key});

  @override
  State<TukTukServiceSettingsPage> createState() =>
      _TukTukServiceSettingsPageState();
}

class _TukTukServiceSettingsPageState extends State<TukTukServiceSettingsPage> {
  bool _serviceEnabled = false;

  /// location =>
  /// name
  /// prices -> Three Wheeler, Car, Van
  ///
  final List<Map<String, dynamic>> _locations = [];

  final List<String> vehicleTypes = [
    "Three Wheeler",
    "Car",
    "Van",
  ];

  _addLocationDialog() {
    final TextEditingController locCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Add Location"),
        content: TextField(
          controller: locCtrl,
          decoration: const InputDecoration(
            labelText: "Location Name",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              if (locCtrl.text.isNotEmpty) {
                setState(() {
                  _locations.add({
                    "name": locCtrl.text.trim(),
                    "prices": {
                      "Three Wheeler": "",
                      "Car": "",
                      "Van": "",
                    }
                  });
                });

                Navigator.pop(ctx);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _deleteLocation(int index) {
    setState(() => _locations.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    const orange = Colors.orange;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transpotation"),
        backgroundColor: orange,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: orange,
        onPressed: _addLocationDialog,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Transpotation Service Settings",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Enable Transport Service", style: TextStyle(fontSize: 16)),
              Switch(
                value: _serviceEnabled,
                activeColor: orange,
                onChanged: (val) => setState(() => _serviceEnabled = val),
              ),
            ],
          ),

          const Divider(),

          const Text(
            "Custom Locations",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          Expanded(
            child: _locations.isEmpty
                ? const Center(
                    child: Text("No locations added",
                        style: TextStyle(color: Colors.grey)),
                  )
                : ListView.builder(
                    itemCount: _locations.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// location name row
                              Row(
                                children: [
                                  const Icon(Icons.location_on, color: orange),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      _locations[index]["name"],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _deleteLocation(index),
                                  )
                                ],
                              ),

                              const SizedBox(height: 10),

                              /// Price UI for the 3 vehicles
                              buildPriceFields(index),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          ElevatedButton(
            onPressed: () {
              print(_locations); // for testing
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Settings Saved"),
                  backgroundColor: orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: orange,
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text("Save Settings",
                style: TextStyle(color: Colors.white)),
          )
        ]),
      ),
    );
  }

  /// Widget builder for price input row

  Widget buildPriceFields(int index) {
    return Column(
      children: [
        priceInputRow(
          index,
          "Three Wheeler",
          Icons.electric_rickshaw,
          Colors.orange,
        ),
        const SizedBox(height: 10),
        priceInputRow(
          index,
          "Car",
          Icons.directions_car,
          Colors.blue,
        ),
        const SizedBox(height: 10),
        priceInputRow(
          index,
          "Van",
          Icons.airport_shuttle,
          Colors.purple,
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget priceInputRow(int index, String type, IconData icon, Color color) {
    return Row(
      children: [
        /// Vehicle Icon
        SizedBox(
          width: 50,
          height: 50,
          child: Icon(icon, size: 36, color: color),
        ),
        const SizedBox(width: 15),

        /// Improved Text box
        Expanded(
          child: TextField(
            onChanged: (val) => _locations[index]["prices"][type] = val,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "$type Price (Rs.)",
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        )
      ],
    );
  }
}

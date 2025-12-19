import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String loungeName = 'Comfort Express Lounge';
  String locationText = 'NO.133, Katunayaka';
  String contact = '0372244567';

  final List<String> facilities = [
    'Free Wi-Fi',
    'Cafeteria',
    'Waiting Area',
    'Restrooms',
  ];

  void _addFacility() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        String newFacility = '';
        return AlertDialog(
          title: const Text('Add Facility'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'e.g. Charging Stations'),
            onChanged: (v) => newFacility = v,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (newFacility.trim().isNotEmpty) Navigator.pop(context, newFacility.trim());
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() => facilities.add(result));
    }
  }


  void _editProfile() async {
    // Navigate to profile page
    Navigator.pushNamed(context, '/profile');
  }

  void _removeFacility(int index) {
    setState(() => facilities.removeAt(index));
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(c);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logged out')));
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orange = const Color(0xFFEF6C00);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 18),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildLoungeInfoCard(orange),
                      const SizedBox(height: 18),
                      _buildFacilitiesCard(orange),
                      const SizedBox(height: 18),
                      _buildSettingsCard(orange),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: const Icon(Icons.arrow_back_ios, size: 20),
        ),
        const SizedBox(width: 12),
        const Text('Settings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildLoungeInfoCard(Color orange) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Lounge Information', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 6),
                Text(loungeName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ]),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/profile'),
              child: Icon(Icons.person, color: orange),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(children: [Icon(Icons.location_on_outlined, size: 18, color: orange), const SizedBox(width: 8), Expanded(child: Text(locationText))]),
        const SizedBox(height: 8),
        Row(children: [Icon(Icons.phone, size: 18, color: orange), const SizedBox(width: 8), Text(contact)]),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _editProfile,
            style: ElevatedButton.styleFrom(backgroundColor: orange, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('+ Edit Profile', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
      ]),
    );
  }

  Widget _buildFacilitiesCard(Color orange) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Lounge Facilities', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        ...List.generate(facilities.length, (i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(children: [
              Container(
                decoration: BoxDecoration(color: const Color(0xFFF6F6F6), borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.check_circle_outline, size: 20, color: Colors.black54),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(facilities[i])),
              IconButton(onPressed: () => _removeFacility(i), icon: const Icon(Icons.delete_outline)),
            ]),
          );
        }),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _addFacility,
            style: ElevatedButton.styleFrom(backgroundColor: orange, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('+ Add Facility', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
      ]),
    );
  }

  Widget _buildSettingsCard(Color orange) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(children: [
        ListTile(leading: const Icon(Icons.privacy_tip_outlined, color: Colors.black54), title: const Text('Privacy Policy'), trailing: const Icon(Icons.chevron_right), onTap: () {}),
        const Divider(),
        ListTile(leading: const Icon(Icons.help_outline, color: Colors.black54), title: const Text('Help & Support'), trailing: const Icon(Icons.chevron_right), onTap: () {}),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _confirmLogout,
            icon: const Icon(Icons.logout),
            label: const Padding(padding: EdgeInsets.symmetric(vertical: 12.0), child: Text('Log Out', style: TextStyle(fontWeight: FontWeight.w600))),
            style: ElevatedButton.styleFrom(backgroundColor: orange, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          ),
        ),
      ]),
    );
  }
}

/// A simple edit-profile page used above (returns the updated values to the previous screen)
class EditProfilePage extends StatefulWidget {
  final String initialName;
  final String initialLocation;
  final String initialContact;

  const EditProfilePage({super.key, required this.initialName, required this.initialLocation, required this.initialContact});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameCtrl;
  late TextEditingController _locationCtrl;
  late TextEditingController _contactCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initialName);
    _locationCtrl = TextEditingController(text: widget.initialLocation);
    _contactCtrl = TextEditingController(text: widget.initialContact);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _locationCtrl.dispose();
    _contactCtrl.dispose();
    super.dispose();
  }

  void _save() {
    Navigator.pop(context, {
      'name': _nameCtrl.text.trim(),
      'location': _locationCtrl.text.trim(),
      'contact': _contactCtrl.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFFEF6C00),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Lounge Name')),
          const SizedBox(height: 12),
          TextField(controller: _locationCtrl, decoration: const InputDecoration(labelText: 'Location')),
          const SizedBox(height: 12),
          TextField(controller: _contactCtrl, decoration: const InputDecoration(labelText: 'Contact'), keyboardType: TextInputType.phone),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: _save, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF6C00), padding: const EdgeInsets.symmetric(vertical: 14)), child: const Text('Save')),
          )
        ]),
      ),
    );
  }
}

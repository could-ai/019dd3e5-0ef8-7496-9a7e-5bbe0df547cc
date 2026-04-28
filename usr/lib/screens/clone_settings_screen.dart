import 'package:flutter/material.dart';
import 'dart:math';
import '../models/app_info.dart';
import '../models/clone_settings.dart';
import 'device_spoofing_screen.dart';
import 'location_spoofing_screen.dart';

class CloneSettingsScreen extends StatefulWidget {
  final AppInfo appInfo;

  const CloneSettingsScreen({Key? key, required this.appInfo}) : super(key: key);

  @override
  State<CloneSettingsScreen> createState() => _CloneSettingsScreenState();
}

class _CloneSettingsScreenState extends State<CloneSettingsScreen> {
  late TextEditingController _nameController;
  late CloneSettings _settings;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: '${widget.appInfo.name} Clone');
    _settings = CloneSettings();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _createClone() {
    // Generate a unique ID
    final cloneId = 'clone_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000)}';
    
    final newClone = ClonedApp(
      id: cloneId,
      originalApp: widget.appInfo,
      cloneName: _nameController.text.trim().isEmpty ? '${widget.appInfo.name} Clone' : _nameController.text.trim(),
      settings: _settings,
    );

    // Normally this would call native code or a service to do the actual app cloning.
    // Here we just return the new mock cloned app.
    
    // Simulate loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Cloning App...'),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // close dialog
      Navigator.pop(context, newClone); // return to previous screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clone Settings', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Basic Info
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.android, size: 40, color: Colors.green),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.appInfo.packageName,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Clone Name',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          // Spoofing Settings
          const Text(
            'Privacy & Spoofing',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Device Spoofing Toggle
          SwitchListTile(
            title: const Text('Spoof Device Identity'),
            subtitle: const Text('Change IMEI, Android ID, Brand, Model'),
            value: _settings.spoofDevice,
            activeColor: Colors.deepPurple,
            onChanged: (val) {
              setState(() {
                _settings.spoofDevice = val;
                if (val && _settings.mockDevice == null) {
                  _settings.mockDevice = DeviceMockInfo.random();
                }
              });
            },
          ),
          if (_settings.spoofDevice)
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: InkWell(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeviceSpoofingScreen(
                        currentMock: _settings.mockDevice,
                      ),
                    ),
                  );
                  if (result != null && result is DeviceMockInfo) {
                    setState(() {
                      _settings.mockDevice = result;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.smartphone, color: Colors.deepPurple),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '${_settings.mockDevice?.brand} ${_settings.mockDevice?.model}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Icon(Icons.edit, size: 20, color: Colors.deepPurple),
                    ],
                  ),
                ),
              ),
            ),

          const Divider(),

          // Location Spoofing Toggle
          SwitchListTile(
            title: const Text('Spoof Location'),
            subtitle: const Text('Mock GPS Coordinates'),
            value: _settings.spoofLocation,
            activeColor: Colors.deepPurple,
            onChanged: (val) {
              setState(() {
                _settings.spoofLocation = val;
              });
            },
          ),
          if (_settings.spoofLocation)
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: InkWell(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationSpoofingScreen(
                        currentMock: _settings.mockLocation,
                      ),
                    ),
                  );
                  if (result != null && result is LocationMockInfo) {
                    setState(() {
                      _settings.mockLocation = result;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.deepPurple),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _settings.mockLocation?.addressName ?? 'Select Location',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Icon(Icons.edit, size: 20, color: Colors.deepPurple),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _createClone,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
              'Clone App',
              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

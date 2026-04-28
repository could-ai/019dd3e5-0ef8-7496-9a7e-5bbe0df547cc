import 'package:flutter/material.dart';
import '../models/clone_settings.dart';

class DeviceSpoofingScreen extends StatefulWidget {
  final DeviceMockInfo? currentMock;

  const DeviceSpoofingScreen({Key? key, this.currentMock}) : super(key: key);

  @override
  State<DeviceSpoofingScreen> createState() => _DeviceSpoofingScreenState();
}

class _DeviceSpoofingScreenState extends State<DeviceSpoofingScreen> {
  late DeviceMockInfo _currentMock;

  // Mock list of brands and models
  final Map<String, List<String>> _devices = {
    'Samsung': ['Galaxy S23', 'Galaxy S22', 'Galaxy Z Fold 4', 'Galaxy A54', 'Galaxy Note 20'],
    'Google': ['Pixel 7 Pro', 'Pixel 7', 'Pixel 6a', 'Pixel 5'],
    'Xiaomi': ['13 Pro', '12T', 'Redmi Note 12', 'Poco F5'],
    'OnePlus': ['11', '10 Pro', 'Nord 2T', '9RT'],
    'Oppo': ['Find X5 Pro', 'Reno 8', 'A78'],
    'Vivo': ['X90 Pro', 'V27', 'Y35'],
  };

  final List<String> _osVersions = ['10.0', '11.0', '12.0', '13.0', '14.0'];

  @override
  void initState() {
    super.initState();
    _currentMock = widget.currentMock ?? DeviceMockInfo.random();
  }

  void _generateRandom() {
    setState(() {
      _currentMock = DeviceMockInfo.random();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Privacy Options', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context, _currentMock);
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Device Identity',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: _generateRandom,
                icon: const Icon(Icons.refresh),
                label: const Text('Randomize All'),
              )
            ],
          ),
          const SizedBox(height: 16),
          _buildDropdownItem(
            'Brand',
            _currentMock.brand,
            _devices.keys.toList(),
            (val) {
              if (val != null) {
                setState(() {
                  _currentMock = DeviceMockInfo(
                    brand: val,
                    model: _devices[val]!.first,
                    osVersion: _currentMock.osVersion,
                    imei: _currentMock.imei,
                    androidId: _currentMock.androidId,
                  );
                });
              }
            },
          ),
          _buildDropdownItem(
            'Model',
            _currentMock.model,
            _devices[_currentMock.brand] ?? [],
            (val) {
              if (val != null) {
                setState(() {
                  _currentMock = DeviceMockInfo(
                    brand: _currentMock.brand,
                    model: val,
                    osVersion: _currentMock.osVersion,
                    imei: _currentMock.imei,
                    androidId: _currentMock.androidId,
                  );
                });
              }
            },
          ),
          _buildDropdownItem(
            'Android Version',
            _currentMock.osVersion,
            _osVersions,
            (val) {
              if (val != null) {
                setState(() {
                  _currentMock = DeviceMockInfo(
                    brand: _currentMock.brand,
                    model: _currentMock.model,
                    osVersion: val,
                    imei: _currentMock.imei,
                    androidId: _currentMock.androidId,
                  );
                });
              }
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Hardware Identifiers',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildTextField('IMEI', _currentMock.imei, (val) {
            _currentMock = DeviceMockInfo(
              brand: _currentMock.brand,
              model: _currentMock.model,
              osVersion: _currentMock.osVersion,
              imei: val,
              androidId: _currentMock.androidId,
            );
          }),
          _buildTextField('Android ID', _currentMock.androidId, (val) {
            _currentMock = DeviceMockInfo(
              brand: _currentMock.brand,
              model: _currentMock.model,
              osVersion: _currentMock.osVersion,
              imei: _currentMock.imei,
              androidId: val,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDropdownItem(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: onChanged,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String value, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: value,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}

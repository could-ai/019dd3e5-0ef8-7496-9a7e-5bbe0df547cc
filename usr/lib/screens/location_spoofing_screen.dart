import 'package:flutter/material.dart';
import '../models/clone_settings.dart';

class LocationSpoofingScreen extends StatefulWidget {
  final LocationMockInfo? currentMock;

  const LocationSpoofingScreen({Key? key, this.currentMock}) : super(key: key);

  @override
  State<LocationSpoofingScreen> createState() => _LocationSpoofingScreenState();
}

class _LocationSpoofingScreenState extends State<LocationSpoofingScreen> {
  late double _latitude;
  late double _longitude;
  late TextEditingController _addressController;

  // Pre-defined popular locations
  final List<LocationMockInfo> _popularLocations = [
    LocationMockInfo(latitude: 40.7128, longitude: -74.0060, addressName: 'New York, USA'),
    LocationMockInfo(latitude: 51.5074, longitude: -0.1278, addressName: 'London, UK'),
    LocationMockInfo(latitude: 35.6762, longitude: 139.6503, addressName: 'Tokyo, Japan'),
    LocationMockInfo(latitude: 48.8566, longitude: 2.3522, addressName: 'Paris, France'),
    LocationMockInfo(latitude: -33.8688, longitude: 151.2093, addressName: 'Sydney, Australia'),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.currentMock != null) {
      _latitude = widget.currentMock!.latitude;
      _longitude = widget.currentMock!.longitude;
      _addressController = TextEditingController(text: widget.currentMock!.addressName);
    } else {
      _latitude = _popularLocations.first.latitude;
      _longitude = _popularLocations.first.longitude;
      _addressController = TextEditingController(text: _popularLocations.first.addressName);
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  void _setLocation(LocationMockInfo loc) {
    setState(() {
      _latitude = loc.latitude;
      _longitude = loc.longitude;
      _addressController.text = loc.addressName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mock Location', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.pop(
                context,
                LocationMockInfo(
                  latitude: _latitude,
                  longitude: _longitude,
                  addressName: _addressController.text,
                ),
              );
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 48, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('Map View Placeholder', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Coordinates', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  key: ValueKey('lat_$_latitude'),
                  initialValue: _latitude.toString(),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                  decoration: InputDecoration(
                    labelText: 'Latitude',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (val) {
                    _latitude = double.tryParse(val) ?? _latitude;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  key: ValueKey('lng_$_longitude'),
                  initialValue: _longitude.toString(),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                  decoration: InputDecoration(
                    labelText: 'Longitude',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (val) {
                    _longitude = double.tryParse(val) ?? _longitude;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(
              labelText: 'Location Name',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          const Text('Popular Locations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ..._popularLocations.map((loc) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.deepPurple),
                  title: Text(loc.addressName),
                  subtitle: Text('${loc.latitude}, ${loc.longitude}'),
                  onTap: () => _setLocation(loc),
                ),
              )),
        ],
      ),
    );
  }
}

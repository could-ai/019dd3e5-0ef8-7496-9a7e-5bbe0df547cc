class CloneSettings {
  bool spoofDevice;
  DeviceMockInfo? mockDevice;

  bool spoofLocation;
  LocationMockInfo? mockLocation;

  CloneSettings({
    this.spoofDevice = false,
    this.mockDevice,
    this.spoofLocation = false,
    this.mockLocation,
  });
}

class DeviceMockInfo {
  final String brand;
  final String model;
  final String osVersion;
  final String imei;
  final String androidId;

  DeviceMockInfo({
    required this.brand,
    required this.model,
    required this.osVersion,
    required this.imei,
    required this.androidId,
  });

  factory DeviceMockInfo.random() {
    return DeviceMockInfo(
      brand: 'Samsung',
      model: 'Galaxy S23',
      osVersion: '13.0',
      imei: '358${_randomDigits(12)}',
      androidId: _randomDigits(16),
    );
  }

  static String _randomDigits(int length) {
    // Generate some mock random digits
    return List.generate(length, (index) => (index % 10).toString()).join();
  }
}

class LocationMockInfo {
  final double latitude;
  final double longitude;
  final String addressName;

  LocationMockInfo({
    required this.latitude,
    required this.longitude,
    required this.addressName,
  });
}

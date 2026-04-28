import 'clone_settings.dart';

class AppInfo {
  final String packageName;
  final String name;
  final String? iconUrl; // We use mock icons for UI

  AppInfo({
    required this.packageName,
    required this.name,
    this.iconUrl,
  });
}

class ClonedApp {
  final String id;
  final AppInfo originalApp;
  final String cloneName;
  final CloneSettings settings;

  ClonedApp({
    required this.id,
    required this.originalApp,
    required this.cloneName,
    required this.settings,
  });
}

import 'package:flutter/material.dart';
import '../models/app_info.dart';
import 'clone_settings_screen.dart';

class AppSelectionScreen extends StatefulWidget {
  const AppSelectionScreen({Key? key}) : super(key: key);

  @override
  State<AppSelectionScreen> createState() => _AppSelectionScreenState();
}

class _AppSelectionScreenState extends State<AppSelectionScreen> {
  final List<AppInfo> _mockInstalledApps = [
    AppInfo(packageName: 'com.whatsapp', name: 'WhatsApp'),
    AppInfo(packageName: 'com.instagram.android', name: 'Instagram'),
    AppInfo(packageName: 'com.facebook.katana', name: 'Facebook'),
    AppInfo(packageName: 'org.telegram.messenger', name: 'Telegram'),
    AppInfo(packageName: 'com.twitter.android', name: 'X (Twitter)'),
    AppInfo(packageName: 'com.zhiliaoapp.musically', name: 'TikTok'),
    AppInfo(packageName: 'com.snapchat.android', name: 'Snapchat'),
    AppInfo(packageName: 'com.viber.voip', name: 'Viber'),
    AppInfo(packageName: 'com.discord', name: 'Discord'),
    AppInfo(packageName: 'com.spotify.music', name: 'Spotify'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select App to Clone', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.separated(
        itemCount: _mockInstalledApps.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final app = _mockInstalledApps[index];
          return ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.android, color: Colors.green),
            ),
            title: Text(app.name, style: const TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text(app.packageName, style: const TextStyle(fontSize: 12)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CloneSettingsScreen(appInfo: app),
                ),
              ).then((result) {
                if (result != null) {
                  // Pass the cloned app back to the home screen
                  Navigator.pop(context, result);
                }
              });
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class ApiConfig {
  static String? _baseUrl;

  // Isse check karenge ki data aaya ya nahi
  static String get baseUrl =>
      _baseUrl ??
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=AIzaSyBOGXDF8oBxTY9_6HzSQ9IHv3qRVJP-RxY";

  static Future<void> setupRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        // Development ke liye 0, production ke liye 12 hours
        minimumFetchInterval: Duration.zero,
      ),
    );

    try {
      // Forcefully fetch and activate
      await remoteConfig.fetchAndActivate();

      // Values ko variables mein store kar lo
      _baseUrl = remoteConfig.getString('api_url');

      debugPrint("Success: API URL mil gaya: $_baseUrl");
    } catch (e) {
      debugPrint("Error: Internet issue ya Firebase error: $e");
    }
  }
}

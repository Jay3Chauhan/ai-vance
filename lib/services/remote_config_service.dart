import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

/// Structured remote configuration parameters for AI Vance.
class AppRemoteConfig {
  const AppRemoteConfig({
    this.minRequiredVersion = '1.0.0',
    this.latestVersion = '1.0.0',
    this.forceUpdateTitle = 'Update Required',
    this.forceUpdateMessage =
        'A critical update for AI Vance is available. Please update the application to continue.',
    this.softUpdateTitle = 'New Update Available',
    this.softUpdateMessage =
        'A newer version of AI Vance is available with optimizations and new capabilities.',
    this.updateUrl =
        'https://play.google.com/store/apps/details?id=com.jaychauhan.aivance',
    this.maintenanceMode = false,
    this.maintenanceMessage =
        'AI Vance is currently undergoing scheduled maintenance. Please check back in a few minutes.',
    this.announcementBannerEnabled = false,
    this.announcementBannerText = '',
    this.curatedModelsJson = '',
    this.forceUpdate = false,
  });

  final String minRequiredVersion;
  final String latestVersion;
  final String forceUpdateTitle;
  final String forceUpdateMessage;
  final String softUpdateTitle;
  final String softUpdateMessage;
  final String updateUrl;
  final bool maintenanceMode;
  final String maintenanceMessage;
  final bool announcementBannerEnabled;
  final String announcementBannerText;
  final String curatedModelsJson;
  final bool forceUpdate;

  static const defaultPlayStoreUrl =
      'https://play.google.com/store/apps/details?id=com.jaychauhan.aivance';

  static bool _parseBool(FirebaseRemoteConfig rc, List<String> keys) {
    for (final k in keys) {
      try {
        final val = rc.getValue(k);
        if (val.asBool()) return true;
        final s = val.asString().trim().toLowerCase();
        if (s == 'true' || s == '1' || s == 'yes') return true;
      } catch (_) {}
    }
    return false;
  }

  static String _parseString(
    FirebaseRemoteConfig rc,
    List<String> keys,
    String defaultValue,
  ) {
    for (final k in keys) {
      try {
        final s = rc.getString(k).trim();
        if (s.isNotEmpty) return s;
      } catch (_) {}
    }
    return defaultValue;
  }

  static AppRemoteConfig fromFirebase(FirebaseRemoteConfig rc) {
    return AppRemoteConfig(
      minRequiredVersion: _parseString(
        rc,
        ['min_required_version', 'min_version', 'minimum_version'],
        '1.0.0',
      ),
      latestVersion: _parseString(
        rc,
        ['latest_version', 'new_version', 'latestVersion'],
        '1.0.0',
      ),
      forceUpdateTitle: _parseString(
        rc,
        ['force_update_title', 'update_title'],
        'Update Required',
      ),
      forceUpdateMessage: _parseString(
        rc,
        ['force_update_message', 'update_message'],
        'A critical update for AI Vance is available. Please update the application to continue.',
      ),
      softUpdateTitle: _parseString(
        rc,
        ['soft_update_title'],
        'New Update Available',
      ),
      softUpdateMessage: _parseString(
        rc,
        ['soft_update_message'],
        'A newer version of AI Vance is available with optimizations and new capabilities.',
      ),
      updateUrl: _parseString(
        rc,
        ['update_url', 'play_store_url', 'store_url'],
        defaultPlayStoreUrl,
      ),
      maintenanceMode: _parseBool(
        rc,
        ['maintenance_mode', 'maintenance', 'is_maintenance', 'under_maintenance', 'maintenanceMode'],
      ),
      maintenanceMessage: _parseString(
        rc,
        ['maintenance_message', 'maintenance_text'],
        'AI Vance is currently undergoing scheduled maintenance. Please check back in a few minutes.',
      ),
      announcementBannerEnabled: _parseBool(
        rc,
        ['announcement_banner_enabled', 'announcement_enabled', 'announcementBannerEnabled'],
      ),
      announcementBannerText: _parseString(
        rc,
        ['announcement_banner_text', 'announcement_text', 'announcementBannerText'],
        '',
      ),
      curatedModelsJson: rc.getString('curated_models_json'),
      forceUpdate: _parseBool(
        rc,
        ['force_update', 'force_update_enabled', 'force_update_required', 'is_force_update', 'forceUpdate'],
      ),
    );
  }
}

/// Production-grade Firebase Remote Config service.
///
/// Designed with 100% offline resilience: if Firebase is unconfigured,
/// network is unavailable, or google-services.json is missing,
/// it safely returns fallback defaults without crashing the app.
class RemoteConfigService {
  RemoteConfigService._();
  static final RemoteConfigService instance = RemoteConfigService._();

  FirebaseRemoteConfig? _remoteConfig;
  AppRemoteConfig _currentConfig = const AppRemoteConfig();

  AppRemoteConfig get currentConfig => _currentConfig;
  FirebaseRemoteConfig? get rawConfig => _remoteConfig;

  Future<AppRemoteConfig> initializeAndFetch() async {
    try {
      // Safely initialize Firebase app if not already initialized
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }

      final rc = FirebaseRemoteConfig.instance;
      _remoteConfig = rc;

      // Production fetch intervals
      await rc.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval:
              kDebugMode ? Duration.zero : const Duration(minutes: 1),
        ),
      );

      // Set in-app default values
      await rc.setDefaults(const {
        'min_required_version': '1.0.0',
        'latest_version': '1.0.0',
        'force_update_title': 'Update Required',
        'force_update_message':
            'A critical update for AI Vance is available. Please update the application to continue.',
        'soft_update_title': 'New Update Available',
        'soft_update_message':
            'A newer version of AI Vance is available with optimizations and new capabilities.',
        'update_url': AppRemoteConfig.defaultPlayStoreUrl,
        'maintenance_mode': false,
        'maintenance_message':
            'AI Vance is currently undergoing scheduled maintenance. Please check back in a few minutes.',
        'announcement_banner_enabled': false,
        'announcement_banner_text': '',
        'curated_models_json': '',
      });

      // Fetch and activate latest parameters from Firebase Console
      await rc.fetchAndActivate();
      rc.getAll().forEach((k, v) {
        debugPrint('[RemoteConfigKey] $k = "${v.asString()}" (source: ${v.source.name})');
      });
      _currentConfig = AppRemoteConfig.fromFirebase(rc);
      debugPrint('[RemoteConfig] Successfully loaded configuration: latest=${_currentConfig.latestVersion}, min=${_currentConfig.minRequiredVersion}, maintenance=${_currentConfig.maintenanceMode}, forceUpdate=${_currentConfig.forceUpdate}, announcement=${_currentConfig.announcementBannerEnabled} ("${_currentConfig.announcementBannerText}")');
      return _currentConfig;
    } catch (e) {
      debugPrint('[RemoteConfig] Safe fallback active (Firebase offline or unconfigured): $e');
      _currentConfig = const AppRemoteConfig();
      return _currentConfig;
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../services/remote_config_service.dart';

enum AppUpdateStatus {
  none,
  softUpdateAvailable,
  forceUpdateRequired,
  maintenance,
}

class AppVersionCheckResult {
  const AppVersionCheckResult({
    required this.status,
    required this.currentVersion,
    required this.config,
  });

  final AppUpdateStatus status;
  final String currentVersion;
  final AppRemoteConfig config;
}

/// Helper comparing two semantic versions (e.g. 1.0.0 vs 1.1.0).
/// Returns -1 if v1 < v2, 1 if v1 > v2, 0 if equal.
int compareSemanticVersions(String v1, String v2) {
  final clean1 = v1.split('+').first.split('-').first;
  final clean2 = v2.split('+').first.split('-').first;

  final parts1 = clean1.split('.').map((p) => int.tryParse(p) ?? 0).toList();
  final parts2 = clean2.split('.').map((p) => int.tryParse(p) ?? 0).toList();

  final maxLen = parts1.length > parts2.length ? parts1.length : parts2.length;
  for (var i = 0; i < maxLen; i++) {
    final num1 = i < parts1.length ? parts1[i] : 0;
    final num2 = i < parts2.length ? parts2[i] : 0;
    if (num1 < num2) return -1;
    if (num1 > num2) return 1;
  }
  return 0;
}

final remoteConfigProvider = FutureProvider<AppRemoteConfig>((ref) async {
  return await RemoteConfigService.instance.initializeAndFetch();
});

final appVersionCheckProvider = FutureProvider<AppVersionCheckResult>((ref) async {
  final config = await ref.watch(remoteConfigProvider.future);

  String currentVersion = '1.0.0';
  try {
    final packageInfo = await PackageInfo.fromPlatform();
    currentVersion = packageInfo.version;
  } catch (_) {
    currentVersion = '1.0.0';
  }

  if (config.maintenanceMode) {
    return AppVersionCheckResult(
      status: AppUpdateStatus.maintenance,
      currentVersion: currentVersion,
      config: config,
    );
  }

  // Check if force update is triggered via direct boolean flag OR version comparison
  final isVersionBelowMin =
      compareSemanticVersions(currentVersion, config.minRequiredVersion) < 0;
  if (config.forceUpdate || isVersionBelowMin) {
    return AppVersionCheckResult(
      status: AppUpdateStatus.forceUpdateRequired,
      currentVersion: currentVersion,
      config: config,
    );
  }

  // Check if a newer version is available (Soft Update)
  if (compareSemanticVersions(currentVersion, config.latestVersion) < 0) {
    return AppVersionCheckResult(
      status: AppUpdateStatus.softUpdateAvailable,
      currentVersion: currentVersion,
      config: config,
    );
  }

  return AppVersionCheckResult(
    status: AppUpdateStatus.none,
    currentVersion: currentVersion,
    config: config,
  );
});

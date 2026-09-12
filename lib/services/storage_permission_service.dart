/*
 * Copyright (C) 2026 Jay Chauhan <contact@jaychauhan.tech>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

/// Storage permission helpers for model downloads.
///
/// This app stores downloaded GGUF models in a shared folder so users can keep
/// large files outside the app sandbox.
///
/// Android behavior:
/// - Requests `Permission.storage` first
/// - On Android 11+ requests `Permission.manageExternalStorage` (“All files”)
/// - May deep-link the user to Settings when permission is permanently denied
Future<bool> requestStoragePermissionForDownloads() async {
  if (!Platform.isAndroid) return true;

  // If already granted, return true immediately.
  if (await hasStoragePermissionForDownloads()) {
    return true;
  }

  // On Android 11+ (API 30+), Scoped Storage requires manageExternalStorage ("All files access").
  // Request manageExternalStorage first, which opens the "All files access" screen on Android 11+.
  final manageStatus = await Permission.manageExternalStorage.status;
  if (!manageStatus.isGranted) {
    final res = await Permission.manageExternalStorage.request();
    if (res.isGranted) return true;
  }

  // For Android 10 and below, try standard storage permission.
  final storageStatus = await Permission.storage.status;
  if (!storageStatus.isGranted && !storageStatus.isPermanentlyDenied) {
    final res = await Permission.storage.request();
    if (res.isGranted) return true;
  }

  return await hasStoragePermissionForDownloads();
}

/// Directly opens the system "All files access" settings screen on Android 11+.
Future<bool> openManageStorageSettings() async {
  if (!Platform.isAndroid) return true;
  final res = await Permission.manageExternalStorage.request();
  return res.isGranted;
}

/// Returns `true` when the app has enough permission to read/write downloads.
///
/// On Android 11+ this requires `manageExternalStorage`; on older Android,
/// `storage` is sufficient.
Future<bool> hasStoragePermissionForDownloads() async {
  if (!Platform.isAndroid) return true;
  final manage = await Permission.manageExternalStorage.isGranted;
  if (manage) return true;
  final storage = await Permission.storage.isGranted;
  return storage;
}

# AI Vance — Firebase Remote Config & Version Control Enterprise Guide

This guide details the complete enterprise setup for **Firebase Remote Config** and **Dynamic Version Control** in **AI Vance** (`com.jaychauhan.aivance`).

---

## 1. Architectural Philosophy: 100% Offline-First AI

AI Vance is an **on-device, privacy-first local AI application**. 
- Neural network inference (GGUF via llama.cpp) executes **100% locally** on the device's CPU/GPU.
- The app **never crashes** if Firebase is unconfigured, if `google-services.json` is missing, or if the user is in airplane mode without internet.
- `RemoteConfigService` contains fallback defaults so the app runs smoothly in both offline and online environments.

---

## 2. Firebase Console Project Setup

### Step 2.1: Create or Select Firebase Project
1. Navigate to the [Firebase Console](https://console.firebase.google.com/).
2. Click **Add project** (or select your existing project).
3. Project Name: `AI Vance` (or your preferred project name).
4. Google Analytics: Optional. Enable or disable according to your preference.

### Step 2.2: Register Android Application
1. In Project Overview, click the **Android** icon to add an Android app.
2. **Android package name**: `com.jaychauhan.aivance` *(Must match exactly)*.
3. **App nickname**: `AI Vance`.
4. **Debug signing certificate SHA-1**:
   Run the following command in PowerShell to get your SHA-1 fingerprint:
   ```powershell
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```
   For release signing keystore:
   ```powershell
   keytool -list -v -keystore android/upload-keystore.jks -alias upload
   ```
5. Click **Register app**.

### Step 2.3: Download and Place `google-services.json`
1. Download the generated `google-services.json` file.
2. Move it into the Android app directory:
   ```
   c:\Users\cseja\Documents\Flutter Projects\RALocalAi\android\app\google-services.json
   ```
3. In AI Vance, `android/app/build.gradle.kts` uses a conditional check:
   ```kotlin
   if (file("google-services.json").exists()) {
       apply(plugin = "com.google.gms.google-services")
   }
   ```
   As soon as `google-services.json` is in `android/app/`, Gradle automatically activates the official Google Services plugin.

---

## 3. Remote Config Parameters Configuration

Navigate to **Firebase Console > Build > Remote Config** and click **Add parameter** (or **Create configuration**). Define the following parameters:

| Parameter Key | Data Type | Default Value | Description |
| :--- | :--- | :--- | :--- |
| `force_update` | Boolean | `false` | When `true`, instantly triggers the **full-screen Force Update modal** regardless of version strings. (Aliases supported: `force_update_enabled`, `force_update_required`). |
| `min_required_version` | String | `1.0.0` | Minimum supported app version. Versions below this will trigger the **full-screen Force Update modal**. |
| `latest_version` | String | `1.0.0` | The newest published version on Google Play. Triggers a **dismissible Soft Update prompt** if `current < latest`. |
| `force_update_title` | String | `Update Required` | Title displayed on the blocking update dialog. |
| `force_update_message` | String | `A critical update for AI Vance is available. Please update to continue.` | Message explaining why the update is required. |
| `soft_update_title` | String | `New Update Available` | Title displayed on the dismissible recommendation dialog. |
| `soft_update_message` | String | `A newer version of AI Vance is available with optimizations and new capabilities.` | Message explaining the benefits of the update. |
| `update_url` | String | `https://play.google.com/store/apps/details?id=com.jaychauhan.aivance` | Direct URL to the Google Play Store listing. |
| `maintenance_mode` | Boolean | `false` | When `true`, displays the **full-screen Scheduled Maintenance view** with live status retry. (Aliases supported: `maintenance`). |
| `maintenance_message`| String | `AI Vance is currently undergoing scheduled maintenance. Please check back soon.` | Message shown during maintenance windows. |
| `announcement_banner_enabled` | Boolean | `false` | Set to `true` to show a broadcast banner at the top of the chat screen. |
| `announcement_banner_text` | String | `""` | Broadcast announcement content (e.g. "New Llama 3.2 1B model now downloadable!"). |
| `curated_models_json` | String | `""` | Optional JSON string to dynamically add curated models to the download catalog without publishing a new app release. |

---

## 4. Production Version Control Workflow

### Scenario A: Recommending a Regular Update (Soft Update)
When you publish version `1.1.0` to Google Play:
1. In Firebase Remote Config, update `latest_version` to `1.1.0`.
2. Keep `min_required_version` at `1.0.0`.
3. Click **Publish changes**.
4. Existing users on `1.0.0` will see a friendly dialog recommending the update, with a "Later" button allowing them to continue chatting.

### Scenario B: Enforcing a Breaking / Critical Update (Force Update)
If version `1.0.0` has a critical bug or API incompatibility:
1. In Firebase Remote Config, update `min_required_version` to `1.1.0`.
2. Update `latest_version` to `1.1.0`.
3. Click **Publish changes**.
4. Existing users on `1.0.0` will receive a non-dismissible modal with only an **Update Now** button linking to the Google Play Store.

### Scenario C: Instant In-App Announcement
To notify all users of a new recommended model:
1. Set `announcement_banner_enabled` to `true`.
2. Set `announcement_banner_text` to: `🚀 Llama 3.2 1B & 3B GGUF models are now available in the Download catalog!`.
3. Click **Publish changes**.
4. The announcement banner appears immediately below the top AppBar for all active users.

---

## 5. Security & Verification

- **Fetch Caching**: In debug mode, cache expiry is `0 seconds` for instant iteration. In release mode, cache expiry is `1 hour` to optimize battery and quota.
- **Offline Fallback**: If the device has no internet access during startup, `RemoteConfigService` catches the timeout and applies safe in-app defaults within 10 seconds.

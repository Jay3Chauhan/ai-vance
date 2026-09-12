# AI Vance — Master Google Play Store Release & Console Guide

This is the complete, official release guide for publishing and maintaining **AI Vance** (`com.jaychauhan.aivance`) on the **Google Play Store**.

---

## 1. Production Keystore Credentials (CRITICAL)

The app is signed using the official release keystore configured in `android/key.properties`:

| Parameter | Value | Notes |
|---|---|---|
| **Keystore File** | `android/app/aivance_release.jks` | Also mirrored in `android/aivance_release.jks` |
| **Keystore Format** | JKS / RSA 2048-bit | Industry standard signing |
| **Keystore Password** | `123456` | Master store password |
| **Key Alias** | `upload` | Certificate alias |
| **Key Password** | `123456` | Private key password |
| **Validity** | 10,000 days | Valid until **2054-01-28** |
| **Certificate Owner** | `CN=Jay Chauhan, OU=AI Vance, O=AI Vance Engineering, L=Surat, ST=Gujarat, C=IN` | Developer identity |

### Certificate Fingerprints:
- **SHA-1 Fingerprint** (for Firebase Console, Google Cloud & OAuth):
  ```
  62:2F:4C:D7:72:BF:C6:30:95:CE:C5:42:51:EC:B1:73:A0:7C:85:17
  ```
- **SHA-256 Fingerprint** (for Google Play App Signing & Integrity):
  ```
  9B:CF:1C:C7:4F:25:F7:54:55:65:EA:EA:3E:26:BF:6C:26:0B:D3:40:7C:7B:73:77:86:2C:53:1E:1D:A0:AE:0D
  ```

> [!CAUTION]
> **BACKUP INSTRUCTION**: Save a secure copy of `android/app/aivance_release.jks` to a secure cloud drive (Google Drive, Dropbox) or password manager. If you lose this keystore file, Google Play will **never** allow you to publish updates to AI Vance!

---

## 2. Production Android App Bundle (.aab)

Google Play strictly mandates the **Android App Bundle (.aab)** format for all new applications:

- **AAB File Location**:
  ```
  build/app/outputs/bundle/release/app-release.aab
  ```
- **File Size**: **~57.6 MB**
- **How to Rebuild Future Updates**:
  ```bash
  flutter build appbundle --release
  ```
  The build process automatically reads `android/key.properties` and signs the bundle with your `aivance_release.jks` keystore.

---

## 3. Google Play Console: "All Files Access" (MANAGE_EXTERNAL_STORAGE) Declaration

Because AI Vance allows downloading, importing, and executing multi-gigabyte GGUF model files from external device storage, Google Play requires an **All Files Access** declaration:

### Question 1: Describe one feature in your app that requires a permitted use of the all files access permission
*(Enter into the 500-character input box | 382 characters)*:
```text
AI Vance enables users to load, import, and manage offline GGUF language model files (1GB–8GB) from device storage and SD cards. The core on-device AI engine relies on native memory-mapping of these user-selected binary model weights to execute local AI chat completely offline without cloud servers. Users can organize, switch, and delete models across external directories.
```

### Question 2: Usage
*Why does your app need to use the all files access permission? Select all that apply.*
- [x] **Core functionality** *(Select ONLY this option)*
- [ ] Personalisation
- [ ] Security or fraud prevention
- [ ] Analytics
- [ ] Ads or monetisation

### Question 3: Technical reason
*Explain why your app can't make use of more privacy-friendly best practices, such as the storage access framework or the media store API.*
```text
1. MediaStore API Incompatibility: MediaStore is restricted to standard media types (images, video, audio) and standard documents. Large language model binaries (.gguf files) are non-media machine learning weight files that are not supported or indexed by MediaStore.

2. Storage Access Framework (SAF) Incompatibility: The on-device neural inference engine is powered by native C/C++ libraries (llama.cpp) that require direct POSIX filesystem paths for memory-mapping (mmap) multi-gigabyte model weights. SAF only provides virtual content:// URIs which cannot be memory-mapped by native POSIX C/C++ runtimes.

3. Storage Duplication Constraints: Copying 2GB–8GB model files from SAF content streams into internal app storage would cause immediate out-of-storage failures on mobile hardware and prevents users from keeping models on external SD cards. Direct filesystem access is structurally required for native C++ memory-mapping of user-supplied model files in place.
```

---

## 4. Google Play Console: Data Safety Form Answers

Complete the **App content > Data safety** questionnaire with these exact settings:

- **Does your app collect or share any user data?**
  - Select **Yes** *(technically required for Firebase instance tokens/diagnostics)*.
- **Is all of the user data collected by your app encrypted in transit?**
  - Select **Yes** *(HTTPS encrypted for Remote Config and model downloads)*.
- **Do you provide a way for users to request that their data be deleted?**
  - Select **Yes** *(Users can clear all chats/models in-app or clear app storage)*.

### Data Types:
1. **Device or other IDs**:
   - Data collected: **Device or other IDs**
   - Data shared: **No**
   - Ephemeral: **No**
   - Required: **Yes**
   - Purpose: **App functionality & Analytics / Diagnostic updates**
2. **Personal / User Data (Messages, Photos, Audio, Contacts)**:
   - Data collected: **No**
   - All chats, user prompts, and neural inferences execute **100% locally** and never leave the device.

---

## 5. Google Play Store Listing Assets & Text

### 5.1 Text Metadata
- **App Name** (max 30 characters):  
  `AI Vance - Private Offline AI`
- **Short Description** (max 80 characters):  
  `Run powerful AI models 100% offline directly on your phone. Private & fast.`
- **Full Description** (up to 4000 characters):
```text
Welcome to AI Vance — your personal, private, and fully offline AI assistant powered by state-of-the-art on-device language models.

Why AI Vance?
Unlike typical cloud-based AI services that send your queries, personal documents, and conversations to remote servers, AI Vance executes neural networks directly on your smartphone processor.

Key Features:
• 100% Private: Zero telemetry, zero server queries. Your chats never leave your device.
• Truly Offline: No Wi-Fi or cellular data needed once your model is loaded.
• Open GGUF Support: Powered by llama.cpp architecture. Compatible with Llama 3, Gemma, DeepSeek, Mistral, and more.
• Built-in Curated Models: Download optimized models tailored for your device RAM.
• Direct Model Import: Have your own GGUF weights? Easily load them directly from your storage.
• Complete Generation Control: Tweak temperature, top-k, top-p, context length, and prompt templates.
• Clean Modern UI: High contrast, dark/light mode, and smooth streaming responses.

Important Hardware Notes:
Running large language models locally requires adequate RAM:
- 4GB RAM: 1B - 2B parameter quantized models
- 6GB - 8GB RAM: 3B - 4B parameter models
- 12GB+ RAM: 7B - 8B parameter models
```

### 5.2 Privacy Policy URL
Enter this exact link into **App content > Privacy policy**:
```
https://app.notion.com/p/AI-Vance-3d9a57849d8e80dfa857c6c8b2ad9a91
```

### 5.3 Graphical Assets Specs
- **App Icon**: 512 x 512 px PNG (32-bit, alpha disabled).
- **Feature Graphic**: 1024 x 500 px JPEG or 24-bit PNG.
- **Phone Screenshots**: Minimum 2 (up to 8). Screenshots are saved under `docs/screenshots/`.

---

## 6. Play Console Step-by-Step Upload Flow

1. Open [Google Play Console](https://play.google.com/console).
2. Select your app: **AI Vance** (`com.jaychauhan.aivance`).
3. Complete **Store presence > Main store listing** using the text from Section 5.
4. Complete **App content > Policy status** (Data Safety, All files access declaration, Privacy policy).
5. Go to **Testing > Internal testing** (or **Production > Create new release**).
6. Drag and drop `build/app/outputs/bundle/release/app-release.aab`.
7. Release name: `1.0.0 (1)`.
8. Click **Save** -> **Review release** -> **Start rollout to Production**!

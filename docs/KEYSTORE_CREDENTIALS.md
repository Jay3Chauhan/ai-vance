# AI Vance — Release Keystore Credentials & Play Console Signing

This document contains the critical signing credentials and certificate fingerprints for **AI Vance** (`com.jaychauhan.aivance`).

> [!CAUTION]
> **CRITICAL BACKUP REQUIRED**: Keep a secure copy of `android/app/aivance_release.jks` and this document in a secure location (e.g. Google Drive, 1Password, or Bitwarden).
> If you lose this keystore file, Google Play will **NOT** allow you to publish updates to your app!

---

## 1. Keystore Details

| Parameter | Value |
|---|---|
| **Keystore File** | `android/app/aivance_release.jks` |
| **Keystore Format** | JKS / RSA 2048-bit |
| **Keystore Password** | `123456` |
| **Key Alias** | `upload` |
| **Key Password** | `123456` |
| **Validity** | 10,000 days (valid until 2054) |
| **Certificate Owner** | `CN=Jay Chauhan, OU=AI Vance, O=AI Vance Engineering, L=Surat, ST=Gujarat, C=IN` |

---

## 2. Certificate Fingerprints

### SHA-1 Fingerprint (For Firebase & Google APIs):
```
62:2F:4C:D7:72:BF:C6:30:95:CE:C5:42:51:EC:B1:73:A0:7C:85:17
```

### SHA-256 Fingerprint (For Google Play App Signing):
```
9B:CF:1C:C7:4F:25:F7:54:55:65:EA:EA:3E:26:BF:6C:26:0B:D3:40:7C:7B:73:77:86:2C:53:1E:1D:A0:AE:0D
```

---

## 3. How to Add to Firebase Console
If you use Firebase Authentication (Google Sign-In) or App Check in the future:
1. Open **Firebase Console** -> Project Settings -> **Your Apps** (`com.jaychauhan.aivance`).
2. Click **Add fingerprint**.
3. Paste the SHA-1 fingerprint:
   `62:2F:4C:D7:72:BF:C6:30:95:CE:C5:42:51:EC:B1:73:A0:7C:85:17`
4. Click Save.

---

## 4. Google Play Console Upload
When uploading your first `.aab` to Google Play Console:
1. Go to **Release** -> **Production** -> **Create new release**.
2. Upload `build/app/outputs/bundle/release/app-release.aab`.
3. Google Play App Signing will automatically register this key as your **Upload Key**.

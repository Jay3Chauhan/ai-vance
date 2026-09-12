# Privacy Policy for AI Vance

**Effective Date:** September 12, 2026  
**Last Updated:** September 12, 2026  
**Developer:** Jay Chauhan  
**Website:** [https://jaychauhan.tech](https://jaychauhan.tech)  
**Contact Email:** [contact@jaychauhan.tech](mailto:contact@jaychauhan.tech)  
**Application ID:** `com.jaychauhan.aivance`  
**Hosted Policy URL:** [https://app.notion.com/p/AI-Vance-3d9a57849d8e80dfa857c6c8b2ad9a91](https://app.notion.com/p/AI-Vance-3d9a57849d8e80dfa857c6c8b2ad9a91)

---

## 1. Introduction & Core Privacy Principles

Welcome to **AI Vance** ("we", "our", or "the App"), developed by **Jay Chauhan**. We believe privacy is a fundamental human right. AI Vance was engineered from the ground up as an **offline, edge-computing artificial intelligence application**. 

Unlike conventional cloud-based AI services that transmit your prompts, documents, and personal conversations to remote third-party data centers, AI Vance performs neural network inference directly on your smartphone hardware using optimized local engines (llama.cpp).

### Summary of Key Guarantees:
- **Zero Cloud Chat Transmission:** Your chat logs, prompts, queries, and assistant responses are processed **exclusively on your physical device**.
- **No Account Required:** You can use AI Vance without creating an account, providing an email, or logging in.
- **No Advertising or Profiling:** We do not track your activity across apps or websites, and we do not sell or monetize personal data.
- **Offline Functionality:** Once AI models are present on your device, the application is completely usable without an active internet connection.

---

## 2. Information We Collect and Process

### A. Information Processed Locally (Never Sent to Servers)
- **Chat Conversations & Prompts:** All text entered into AI Vance is sent directly to the locally loaded quantized model on your device CPU/GPU. These interactions remain in your device's private local storage.
- **GGUF Model Files:** Neural network weights stored on your device storage are loaded directly into RAM for on-device inference.

### B. Information Processed Remotely (Optional & Diagnostics Only)
- **Firebase Remote Config & App Update Checks:** When an internet connection is available, the app queries Google Firebase Remote Config to verify whether an essential app update or security patch is required. The data exchanged includes basic technical device parameters (app version, Android OS version, language locale). No personal identity or chat data is transmitted.
- **Model Downloads (User-Initiated):** When you choose to download an AI model from Hugging Face or public model repositories, the app establishes a standard HTTPS connection to the respective repository to retrieve the requested `.gguf` file. No personal details are associated with this transfer.

---

## 3. Device Permissions & Why We Need Them

To function properly on Android devices, AI Vance requests specific system permissions. Here is how each is used:

| Permission | Technical Name | Purpose in AI Vance |
| :--- | :--- | :--- |
| **All Files Access / Storage** | `MANAGE_EXTERNAL_STORAGE` / `READ_EXTERNAL_STORAGE` | **Strictly required** to allow users to import and load custom GGUF model files located in their device storage (e.g. `/sdcard/Download/`). Without this permission, the app cannot access model weights for inference. |
| **Internet Access** | `INTERNET` | Used **solely** for user-requested model downloads and retrieving app version updates via Firebase Remote Config. Internet is not required for chat once models are downloaded. |
| **Network State** | `ACCESS_NETWORK_STATE` | Verifies whether an internet connection is present before attempting to download model weights or check updates, avoiding unnecessary battery drain. |

> **Important:** AI Vance **never** accesses your personal photos, media files, contacts, or documents outside of the explicit `.gguf` model files you choose to import.

---

## 4. Third-Party Services & SDKs

AI Vance integrates minimal, essential SDKs strictly for application delivery and maintenance:
- **Google Play Services & Firebase Remote Config:** Used for dynamic version control, force update enforcement, and maintenance notifications. Google's Privacy Policy applies: [https://policies.google.com/privacy](https://policies.google.com/privacy).
- **Hugging Face / Model Mirrors:** When downloading models, files are fetched directly from public model hubs.

We do not embed third-party analytics trackers (such as Google Analytics or Meta Pixel), nor do we incorporate advertising networks.

---

## 5. Data Retention & Deletion

- **Local Storage:** All chats, settings, and downloaded models reside in your device's internal app storage.
- **User Control:** You can delete individual chats at any time via the drawer menu, delete saved models from the "Downloaded Models" screen, or clear all app data instantly via Android Settings > Apps > AI Vance > Storage > Clear Data.
- **Uninstalling:** Uninstalling AI Vance removes all associated chat histories and internal application data from your device.

---

## 6. Children\'s Privacy

AI Vance does not knowingly collect or solicit personal information from children under the age of 13. Because the application processes text locally without account registration or remote user profiles, no child data is ever harvested or stored by us.

---

## 7. Changes to This Privacy Policy

We may update our Privacy Policy occasionally to reflect application enhancements or regulatory changes. Any updates will be published with an updated "Effective Date" at the top of this document, and significant changes will be announced in-app via Firebase Remote Config.

---

## 8. Contact & Developer Information

If you have questions, feedback, or concerns regarding this Privacy Policy or the data handling practices of AI Vance, please contact:

- **Developer:** Jay Chauhan
- **Official Website:** [https://jaychauhan.tech](https://jaychauhan.tech)
- **Email:** [contact@jaychauhan.tech](mailto:contact@jaychauhan.tech)
- **GitHub:** [https://github.com/Jay3Chauhan](https://github.com/Jay3Chauhan)
- **Location:** Surat, Gujarat, India

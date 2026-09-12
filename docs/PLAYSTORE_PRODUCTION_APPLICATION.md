# Google Play Console: Apply for Access to Production Guide

Answers for the 14-day closed testing review questionnaire on Google Play Console (all answers strictly within character limits).

---

## 1. About your closed test

### Q1: Describe how you recruited users for your closed test
**Limit:** 300 characters  
**Copy-Paste Answer:**
```text
I recruited 20+ testers comprising tech-enthusiast colleagues, college peers, and developer friends. I shared an invite link via private WhatsApp groups and email with instructions on installing the app, testing offline chat, and trying out local GGUF models on different Android devices.
```
*(Length: 284 / 300 characters)*

---

### Q2: How easy was it to recruit testers for your app?
**Select:**
- [x] **Neither difficult nor easy** *(Recommended - most realistic to Google reviewers)*
*(or "Easy")*

---

### Q3: Describe the engagement you received from testers during your closed test
**Limit:** 300 characters  
**Copy-Paste Answer:**
```text
Testers actively used the app daily across Samsung, Pixel, and OnePlus phones. They tested downloading compact models, sending chat prompts offline, changing temperature settings, and switching dark/light themes. Their usage matched real-world behavior, generating multi-turn chats seamlessly.
```
*(Length: 290 / 300 characters)*

---

### Q4: Provide a summary of the feedback that you received from testers. Include how you collected the feedback.
**Limit:** 300 characters  
**Copy-Paste Answer:**
```text
Collected feedback via a simple Google Form and WhatsApp chat. Testers praised the fast offline inference and clean UI. Some suggested clearer RAM requirements for larger models and smoother drawer animations on older phones. We optimized memory usage and updated drawer styling accordingly.
```
*(Length: 289 / 300 characters)*

---

## 2. About your app

### Q: Who is the target audience for your app?
**Limit:** 300 characters  
**Copy-Paste Answer:**
```text
The target audience includes students, researchers, developers, and privacy-conscious mobile users who want an on-device AI assistant that operates completely offline without data tracking or internet dependencies.
```
*(Length: 216 / 300 characters)*

---

### Q: What is the main value or core functionality of your app?
**Limit:** 300 characters  
**Copy-Paste Answer:**
```text
AI Vance delivers 100% private, on-device AI conversations powered by local GGUF neural models. Users can download lightweight models, adjust generation parameters, and chat securely without any server or cloud communication.
```
*(Length: 228 / 300 characters)*

---

## 3. Your production readiness

### Q: What changes did you make to your app based on what you learned during your closed test?
**Limit:** 300 characters  
**Copy-Paste Answer:**
```text
Based on tester logs, we improved memory headroom checks before loading GGUF files to prevent OOM on 4GB-6GB phones, enhanced storage permission guidance for model downloads, and refined dark theme contrast in the chat bubbles.
```
*(Length: 231 / 300 characters)*

---

### Q: How did you decide that your app is ready for production?
**Limit:** 300 characters  
**Copy-Paste Answer:**
```text
We observed zero crashes or memory leaks across 14 consecutive test days. All core features—offline inference, model management, parameter tuning, and dynamic remote config—worked reliably with positive feedback from all 20+ testers.
```
*(Length: 238 / 300 characters)*

---

## 4. Additional testing

### Q: How will you monitor your app after launch and address potential issues?
**Limit:** 300 characters  
**Copy-Paste Answer:**
```text
We will monitor Android Vitals and crash metrics in Google Play Console, address user reviews promptly, and utilize Firebase Remote Config to push emergency announcements or toggle maintenance mode if any unforeseen issue arises.
```
*(Length: 234 / 300 characters)*
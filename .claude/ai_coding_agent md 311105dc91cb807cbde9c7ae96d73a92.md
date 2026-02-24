# ai_coding_agent.md

# Village Connect

## AI Coding Agent Implementation Guide

Project Type: Flutter + Firebase Application

Target Users: Rural Citizens, Government Officials, Village Committees

Languages: English, Sinhala, Tamil

---

# 1. Technical Stack

Frontend:

- Flutter (Stable)
- Riverpod (State Management)
- GoRouter (Navigation)
- Hive (Offline Storage)
- speech_to_text (Voice Input)

Backend:

- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- Cloud Functions
- Firebase Messaging
- Firebase Analytics
- Firebase App Check

---

# 2. Architecture Principles

- Offline-first architecture
- Role-Based Access Control (RBAC)
- Step-based forms only
- Maximum navigation depth: 2 levels
- Single-column mobile layout
- No dark mode
- Accessibility-first UI

---

# 3. Project Folder Structure

lib/
├── core/
│    ├── theme/
│    ├── localization/
│    ├── constants/
│
├── features/
│    ├── auth/
│    ├── documents/
│    ├── incidents/
│    ├── notifications/
│    ├── profile/
│    ├── chatbot/
│
├── shared/
│    ├── widgets/
│    ├── services/
│
└── main.dart

---

# 4. Roles

- citizen
- official
- committee
- super_admin

Use Firebase Custom Claims for role enforcement.

---

# 5. Firestore Collections

users/
applications/
incidents/
notifications/
audit_logs/

Each document must include:

- createdAt
- updatedAt
- divisionId
- status

---

# 6. Localization

Supported:

- English (en)
- Sinhala (si)
- Tamil (ta)

Use ARB files under:
lib/l10n/

Language selector must be visible at top of screen.

---

# 7. Document Application Flow

Step 1: Select document type

Step 2: Enter details

Step 3: Upload files

Step 4: Confirm & Submit

Requirements:

- Auto-save draft
- Progress indicator
- Inline validation
- Never reset on network failure
- After submission show:
    - Tracking ID
    - Timeline status
    - Responsible authority name

---

# 8. Incident Reporting

Fields:

- Category
- Description (voice enabled)
- Optional photo
- Location auto-detect

After submit:

- Tracking ID
- Estimated response time
- Status tracker

---

# 8.1 AI Chatbot (Multilingual Assistant)

Location: lib/features/chatbot/screens/chatbot_screen.dart

Navigation:

- Center notch FAB in bottom navigation (BottomAppBar + CircularNotchedRectangle)
- Help Screen "Chat with us" button
- Opens as full-screen push navigation

Languages:

- English (en)
- Sinhala (si) – සිංහල
- Tamil (ta) – தமிழ்

Features:

- Language selector chips in header
- Localized welcome message per language
- Quick suggestion chips (4 topics)
- Bot avatar with gradient background
- Typing indicator with animated dots
- Pattern-matching responses for:
  - Certificate/document applications
  - Request tracking & status
  - Office hours & contact info
  - Community issue reporting
- Language switching clears conversation and restarts
- Input area with rounded text field and send button

UI Components:

- Header: back button, bot avatar, localized title, online status
- Language bar: EN / සිංහල / தமிழ் toggle chips
- Message bubbles: bot (white, left) / user (blue, right) with avatars
- Quick suggestions: pastel blue chips with primary text
- Input: rounded text field + gradient send button

Future Enhancements:

- Connect to NLP/LLM API backend (Cloud Functions)
- Voice input via speech_to_text
- Conversation history persistence (Hive/Firestore)
- Context-aware responses based on user profile

---

# 9. Offline Mode

If offline:

- Show banner: “Offline Mode”
- Allow draft saving
- Auto sync when reconnected
- Replace technical errors with:
“Connection unstable. We will retry automatically.”

---

# 10. Analytics Events

Track:

- form_started
- form_step_completed
- incident_submitted
- status_viewed
- repeat_login

---

# 11. Security Requirements

- Firestore rules enforced per role
- Storage rules per ownership
- App Check enabled
- Audit log for:
    - document approval
    - profile access
    - status change

---

# 12. Performance Goals

- Form completion rate > 70%
- Incident submission < 2 minutes
- App load time < 3 seconds
- Offline reliability > 95%

---

End of AI Coding Agent Guide
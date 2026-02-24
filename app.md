# Village Connect App Documentation

## 1. App Overview
**Village Connect** is a mobile platform designed to digitally connect rural citizens with government authorities (Gram Niladhari). The app aims to streamline document requests, incident reporting, and official communication, reducing bureaucracy and increasing transparency.

**Target Audience:**
-   **Citizens**: Rural residents needing government services.
-   **Officials**: Government officers (Gram Niladhari) managing requests and notices.

**Current Status:**
-   The application is currently a **UI Prototype**.
-   It features high-fidelity screens and navigation flows but lacks backend integration.
-   Data is mocked within the application state.
-   State management and routing libraries (Riverpod, GoRouter) are listed as dependencies but not actively utilized in the current codebase; standard `setState` and `Navigator` are used instead.

## 2. Architecture
The project follows a **Feature-First** architecture, organizing code by domain features rather than technical layers.

**Directory Structure:**
-   `lib/core/`: Shared utilities, themes, constants.
-   `lib/features/`: Contains feature modules, each with its own `screens/` directory.
    -   `auth`: Authentication flow.
    -   `chatbot`: AI Assistant.
    -   `community`: Community feed (placeholder).
    -   `documents`: Document request and tracking.
    -   `help`: Support and FAQs.
    -   `home`: Main dashboard and navigation shell.
    -   `notices`: Official announcements.
    -   `notifications`: Alerts and updates.
    -   `official`: Dashboard for government officials.
    -   `profile`: User profile management.
-   `lib/shared/`: Reusable widgets across features.

## 3. Navigation
The app uses a standard `Navigator` for screen transitions and a custom `AppShell` for the main persistent navigation.

**Main Navigation (Citizen Flow):**
-   **AppShell**: The primary container for authenticated users. It features a Bottom Navigation Bar and a Floating Action Button (FAB).
    -   **Tabs**:
        1.  **Home**: `CitizenHomeScreen`
        2.  **Alerts**: `NotificationsScreen`
        3.  **Notices**: `NoticeBoardScreen`
        4.  **Help**: `HelpScreen`
    -   **FAB**: Opens the `ChatbotScreen` with a custom slide transition.

**Routes**:
-   **Splash Screen**: Initial entry point.
-   **Auth Flow**: Login -> Register -> AppShell.
-   **Sub-screens**: Pushed onto the navigation stack (e.g., `DocumentRequestScreen`, `ProfileScreen`).

## 4. Screens & Functionality

### 4.1 Authentication (`lib/features/auth`)
-   **Splash Screen**: Branding display on startup.
-   **Login Screen**:
    -   NIC (National Identity Card) and Password fields.
    -   Language Selector (English, Sinhala, Tamil) - updates UI state only.
    -   "Forgot Password" (UI only).
    -   Navigation to Registration.
-   **Registration Screen**:
    -   Fields for Full Name, NIC, Mobile Number, Password.
    -   "Register" button (UI only).
-   **Language Selector Screen**: Dedicated screen for language choice (if needed).

### 4.2 Home (`lib/features/home`)
-   **Citizen Home Screen**:
    -   **Hero Header**: Greetings with user name and profile picture (navigates to Profile).
    -   **Quick Stats**: Cards showing Pending, Approved, and Total requests.
    -   **Primary Actions**:
        -   **Apply for Document**: Navigates to `DocumentRequestScreen`.
        -   **Report an Incident**: Placeholder for incident reporting.
    -   **Secondary Actions**:
        -   **Track Application**: Navigates to `RequestTrackingScreen`.
        -   **Notice Board**: Navigates to `NoticeBoardScreen` (via tab or direct link).
        -   **Help & Support**: Navigates to `HelpScreen`.
    -   **Recent Activity**: List of recent document requests with status (Approved, In Review, Pending).

### 4.3 Documents (`lib/features/documents`)
-   **Document Request Screen**:
    -   Form to request official documents (e.g., Character Certificate, Income Certificate).
    -   Fields: Document Type, Purpose, Upload NIC (UI mock).
    -   Submission simulates a network request.
-   **Request Tracking Screen**:
    -   List of tracked applications with current status.
    -   Detailed view of a specific request's timeline.

### 4.4 Notices (`lib/features/notices`)
-   **Notice Board Screen**:
    -   List of official announcements from the Gram Niladhari.
    -   Filterable by category (e.g., General, Emergency, Event).
-   **Notice Detail Screen**:
    -   Full view of a notice with title, date, description, and attached images.

### 4.5 Notifications (`lib/features/notifications`)
-   **Notifications Screen**:
    -   List of alerts (e.g., "Document Approved", "New Notice Posted").
    -   Mark as read functionality (UI only).

### 4.6 Chatbot (`lib/features/chatbot`)
-   **Chatbot Screen**:
    -   **AI Assistant**: A mock chat interface.
    -   **Features**:
        -   Pre-defined welcome message.
        -   Suggestion chips (e.g., "Track my application").
        -   Typing indicator animation.
        -   Auto-response simulation after a delay.
        -   Clear chat history.
        -   Scroll-to-bottom button.

### 4.7 Profile (`lib/features/profile`)
-   **Profile Screen**:
    -   User details (Name, NIC, Address, Mobile).
    -   Edit profile option (UI only).
    -   Settings (Notifications, Language, etc.).
    -   Logout functionality.

### 4.8 Official Dashboard (`lib/features/official`)
*Note: This feature is present in the codebase but not currently linked to the main authentication flow.*

-   **Official Dashboard Screen**:
    -   **Stats Overview**: Pending, In Review, Approved, Rejected counts.
    -   **Quick Actions**: Review Requests, Post Notice, View Community.
    -   **Recent Pending Requests**: List of requests requiring action.
-   **Pending Requests Screen**: Detailed list of requests to be reviewed.
-   **Post Notice Screen**: Form to create and publish new notices.
-   **Request Review Screen**: Interface for officials to approve or reject a document request.

### 4.9 Help (`lib/features/help`)
-   **Help Screen**:
    -   FAQs (Frequently Asked Questions).
    -   Contact information for the Gram Niladhari office.
    -   Emergency numbers.

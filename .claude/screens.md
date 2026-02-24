# Village Connect - App Screens Overview

**Project:** Village Connect – Localized Social & Administrative Mobile Platform  
**Platform:** Flutter (Mobile-first, single-column, offline-first)  
**Navigation Constraints:**  

- Bottom navigation bar (max 4 items: Home, Requests / My Requests, Community / Notifications, Profile / Help)  
- Maximum navigation depth: 2 levels  
- Forms: Step-based wizards only with progress indicator  
- No dark mode, accessibility-first (48px tap targets, high contrast)  
- Role-based dashboards (citizen default; official/committee/admin after login + custom claims)

This document lists **all identified screens** with purpose, key elements, and references to proposal wireframes (where available).

## 1. Authentication & Onboarding

### Splash / Launch Screen

- Initial loading / branding screen
- Checks auth state, offline status, language
- Auto-redirects to login or home

### Language Selector

- Visible at app start or top bar
- Options: English (en), Sinhala (si), Tamil (ta)
- Persists choice (localization via ARB)

### Login Screen (Proposal p.8)

- Fields: NIC Number, Password
- Buttons: LOGIN (primary blue)
- Links: Register, Forgot Password
- Simple, trustworthy design

### Registration Screen

- Fields: NIC, Full Name, Address, Phone (optional), Division/Village
- Role defaults to citizen
- Password + confirm
- Terms/privacy checkbox

## 2. Citizen (Resident) Screens

Bottom nav: Home | Requests | Community | Profile (or similar)

### Home Dashboard (Proposal p.9 – User Dashboard)

- Large vertical cards (pastel backgrounds, rounded 12px):
  - Apply for Certificate / Document
  - Track Requests
  - Notice Board
  - Lost & Found / Community
  - Community Jobs / Opportunities
- My Latest Request overview card (type + status)
- Offline banner if disconnected

### Certificate / Document Request Form (Proposal p.10)

- Single screen or wizard (step-based preferred per AI guide)
- Fields: Certificate Type (dropdown), Full Name, NIC, Address, Reason, Upload Document
- Inline validation
- Submit (primary button)
- Auto-save draft support

### Request Tracking Screen (Proposal p.11 – My Requests list)

- List of submitted requests
- Card per request: Type, Submitted date, Status (Pending / In Review / Approved)
- Filter/sort by date/status

### Request Detail View (Proposal p.12)

- Full request data (type, name, NIC, address, reason)
- Status badge
- GN Remarks / Comments section
- Download Certificate button (when approved)

### Official Notice Board (Proposal p.13)

- List of verified GN announcements
- Card: Title, Description snippet, Date, Verified badge, Read More
- Filter/search bar

### Notice Detail Screen (Proposal p.14 implied)

- Full notice text
- Date, category
- Verified badge
- Attachments if any

### Community Feed Screen (Proposal p.15)

- Posts list (Lost & Found + Jobs/Opportunities)
- Filter by type
- Card: Title, Description, Contact, Location, Date, Photo placeholder

### Add Community Post Screen (Proposal p.16)

- Select type: Lost, Found, Job Opportunity
- Fields: Title, Description, Photo upload, Location, Contact Info
- Submit button

### Profile Screen (Proposal p.17)

- View/edit: Name, NIC, Address, Phone, Village/Division
- Language selector
- Logout button

## 3. Official (Grama Niladhari) Screens

Different home after role login

### GN Officer Dashboard (Proposal p.18)

- Pending certificate requests count
- Pending incidents/reports
- Quick actions: Review Requests, Post Notice, View Community Posts

### Pending Requests List

- List of citizen certificate applications
- Filter by type/date/status

### Request Review Detail

- View full submitted data + uploads
- Add remarks
- Buttons: Approve, Reject, Request More Info
- Status update → triggers citizen notification

### Post Official Notice Screen

- Create announcement: Title, Description, Category, Attachment
- Publish button

## 4. Committee & Admin Screens (Phase 2+)

### Committee Dashboard

- Assigned tasks/incidents
- Meeting calendar summary
- Polling overview

### Task Assignment / Workflow Screen

- View assigned issues
- Update progress, re-assign, close

### Meeting Minutes / Calendar

- Schedule/view meetings
- Record minutes
- Reminders

### Community Polling

- Create/view polls

### Resource Tracker

- Shared resources list (availability/booking)

### Super Admin Dashboard

- User/role management
- Analytics summary
- Audit log viewer

## 5. Shared / Utility Screens

### Notifications Screen

- In-app list (push + categorized: urgent red, government blue, etc.)
- Mark read

### Help / Support / Chatbot Interface (Proposal p.19)

- FAQs
- Simple chatbot (future / Phase 3)
- Contact GN

### Offline Mode Banner

- Persistent top banner when offline
- “Offline Mode” + soft yellow background

## Phase Notes & Gaps

- **Phase 1 priority**: Citizen auth → Home → Certificate flow → Tracking → Notices → Notifications
- **Phase 2**: Official dashboard, incident reporting (not heavily wired in proposal), Tamil support
- **Phase 3**: Voice input/assistance, SMS sync, Kiosk mode variant (larger buttons, audio, auto-logout)
- **Missing / future**: Incident reporting wizard, one-tap emergency, mass broadcast tool, digital signature UI
- No payment screens (explicitly excluded)

This list stays faithful to provided documents. Screens added only when strongly required by features (e.g., confirmation after submit, detail views). No multi-village scaling or national integration.

Last updated: based on proposal wireframes + PRD/AI guide.

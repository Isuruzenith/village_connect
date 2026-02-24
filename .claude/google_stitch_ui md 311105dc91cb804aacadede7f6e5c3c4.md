# google_stitch_ui.md

# Village Connect

## UI Generation Specification for Google Stitch

Platform: Flutter Mobile

Layout: Mobile-first, Single Column

Max Navigation Depth: 2 Levels

---

# 1. Design Tone

Calm

Trustworthy

Official

Structured

Human-centered

Not:

- Flashy
- Corporate startup
- Social media style

---

# 2. Color System

Primary:
Deep Government Blue
#1E3A8A

Background:
#F6F8FB

Secondary Surface:
#E8EEF9

Card:
#FFFFFF

Accent Pastels:
Green: #DFF5E1
Yellow: #FFF6D6
Red: #FFE2E2
Purple: #EEE6FF

Rules:

- No saturated backgrounds
- No dark mode
- Minimum contrast 4.5:1

---

# 3. Typography

H1: 22–24px semi-bold

H2: 18–20px medium

Body: 16–18px

Caption: 14px minimum

Line height: 1.5 minimum

No all-caps

No decorative fonts

---

# 4. Home Screen Layout

Large vertical cards with:

- Icon
- Label
- Soft pastel background
- Rounded corners (12px)

Order:

1. Apply for Document
2. Track Application
3. Report a Problem
4. Announcements
5. My Profile

Bottom Navigation (max 4 items):

- Home
- My Requests
- Notifications
- Help

No hamburger menu.

---

# 5. Buttons

Primary:

- Blue background
- White text
- 48px minimum height
- Rounded 12px

Secondary:

- Pastel background
- Blue border
- Blue text

Disabled:

- Muted gray

Never use ghost buttons for important actions.

---

# 6. Forms

Step-based wizard only.

Must include:

- “Step X of Y” indicator
- Large input fields
- Labels above inputs
- Inline validation
- Error in pastel red box
- Auto-save drafts

---

# 7. Notifications UI

Urgent → Pastel Red

Government → Pastel Blue

Health → Pastel Green

Events → Pastel Yellow

Readable in under 30 seconds.

---

# 8. Accessibility

- 48px tap targets
- No swipe-only interactions
- Text labels under icons
- High contrast

---

# 9. Offline Banner

Top banner:
“Offline Mode”

Soft yellow background.

---

# 10. Kiosk Mode Variant

- Extra large buttons
- High contrast
- Audio guidance
- Auto logout after 60 seconds
- Privacy warning modal

---

End of Google Stitch UI Specification
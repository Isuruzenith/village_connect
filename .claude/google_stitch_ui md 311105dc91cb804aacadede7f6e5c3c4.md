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

Bottom Navigation (4 items + center notch AI Bot FAB):

- Home
- Requests
- **AI Bot** (center notch FloatingActionButton, blue gradient, smart_toy icon)
- Notices
- Help

Center Notch FAB:

- 62px circular button with gradient (primary → primaryLight)
- CircularNotchedRectangle shape on BottomAppBar
- "AI Bot" label below the notch
- Opens ChatbotScreen on tap

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

# 10. AI Chatbot UI Specification

Layout: Full-screen push navigation from FAB or Help Screen

Header:
- Back button + Bot avatar (blue gradient, rounded 14px, smart_toy icon)
- Localized title ("Village Assistant" / "ගම්මාන සහායක" / "கிராம உதவியாளர்")
- Green online status indicator

Language Bar:
- Secondary surface background (#E8EEF9)
- 3 toggle chips: English / සිංහල / தமிழ்
- Selected: Primary blue background, white text
- Unselected: White background, secondary text, border

Chat Bubbles:
- Bot: White card, left-aligned, 16px rounded (bottom-left 4px), border, shadow
- User: Primary blue background, right-aligned, 16px rounded (bottom-right 4px)
- Bot avatar: 32px blue gradient square, smart_toy icon
- User avatar: 32px secondary surface square, person icon
- Text: 14px caption style, 1.5 line height

Quick Suggestions:
- Shown only on first visit (1 message in chat)
- Pastel blue chips (#DCE8FF) with primary text
- Rounded 20px, 14px horizontal + 10px vertical padding

Typing Indicator:
- 3 animated dots (8px circles, muted color)
- Fade animation, 800ms repeat
- Same bubble styling as bot messages

Input Area:
- Background card with top border divider
- Rounded text field (24px radius) with background color fill
- Localized hint text
- 48px gradient send button (primary → primaryLight, rounded circle)

Splash Screen AI Indicator:
- Bottom center of splash screen
- 56px circular container with white translucent background
- smart_toy icon (28px, white)
- "AI Assistant Ready" label (14px, white, semi-bold)
- "English · සිංහල · தமிழ்" subtitle (12px, white 65% opacity)
- Small loading spinner below

---

# 11. Kiosk Mode Variant

- Extra large buttons
- High contrast
- Audio guidance
- Auto logout after 60 seconds
- Privacy warning modal

---

End of Google Stitch UI Specification
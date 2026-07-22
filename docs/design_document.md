# RideGo — Complete Product Design Document
# وثيقة تصميم المنتج الكاملة

**Version / الإصدار:** 1.0  
**Date / التاريخ:** July 2026  
**Platform / المنصة:** Flutter (Android · iOS · Web)  
**Language / اللغة:** Arabic + English

---

## Table of Contents / فهرس المحتويات

1. [Competitor Analysis / تحليل المنافسين](#1-competitor-analysis)
2. [Design Philosophy / فلسفة التصميم](#2-design-philosophy)
3. [User Personas / شخصيات المستخدمين](#3-user-personas)
4. [User Journey / رحلة المستخدم](#4-user-journey)
5. [Information Architecture / هيكل المعلومات](#5-information-architecture)
6. [User Flows / مسارات المستخدم](#6-user-flows)
7. [Passenger App Screens / شاشات تطبيق الراكب](#7-passenger-app-screens)
8. [Driver App / تطبيق السائق](#8-driver-app)
9. [Admin Dashboard / لوحة التحكم](#9-admin-dashboard)
10. [Map Experience / تجربة الخريطة](#10-map-experience)
11. [Design System / نظام التصميم](#11-design-system)
12. [Motion Design / تصميم الحركة](#12-motion-design)
13. [Micro Interactions / التفاعلات الصغيرة](#13-micro-interactions)
14. [Lottie Specifications / مواصفات Lottie](#14-lottie-specifications)
15. [Rive Specifications / مواصفات Rive](#15-rive-specifications)
16. [Accessibility / إمكانية الوصول](#16-accessibility)
17. [Responsive Design / التصميم المتجاوب](#17-responsive-design)
18. [Developer Handoff / تسليم المطور](#18-developer-handoff)
19. [Innovative Ideas / أفكار مبتكرة](#19-innovative-ideas)

---

## 1. Competitor Analysis
## تحليل المنافسين

### 1.1 Uber

**Strengths / نقاط القوة:**
- Globally recognized brand with consistent UX
- Excellent ETA accuracy and surge pricing visualization
- Smooth animated map transitions
- Clean, minimal UI that reduces cognitive load

**Weaknesses / نقاط الضعف:**
- Cluttered home screen with too many service types
- Impersonal driver-passenger interaction
- Limited personality; feels sterile

**Map Experience / تجربة الخريطة:**
- Custom dark map style in night mode
- Smooth car animation following heading
- Route rendering with clear polylines

**Motion Design:**
- Subtle fade transitions between states
- Car marker smoothly rotates and moves
- Bottom sheet spring physics

**Learnable Ideas / أفكار قابلة للتطوير:**
- Surge area heat maps on the home screen
- Real-time ETA updates with micro-animations

---

### 1.2 Careem (Middle East Focus)

**Strengths / نقاط القوة:**
- Strong RTL (right-to-left) Arabic support
- Familiar brand in MENA region
- Captain (driver) personality shown via photo & name
- Scheduled rides feature

**Weaknesses / نقاط الضعف:**
- Heavy app size; performance issues on low-end devices
- Inconsistent design language across screens
- Motion design lacks polish

**Learnable Ideas:**
- Captain profile card with photo, rating, and trip count
- Bilingual (AR/EN) toggle seamlessly
- Promo code integration at payment step

---

### 1.3 Grab (Southeast Asia)

**Strengths / نقاط القوة:**
- Super-app model — rides, food, payments in one
- Excellent onboarding flow
- Dynamic map with real-time car density visualization
- GrabPay wallet deeply integrated

**Weaknesses / نقاط الضعف:**
- Overwhelming home screen (too many services)
- Slow cold-start time

**Motion Design:**
- Beautiful driver-accepted celebration animation
- Gradient wave on searching state
- Smooth shared element transitions between screens

**Learnable Ideas:**
- Wallet-first payment integration
- Driver acceptance animation celebration
- Smart ETA recalculation on traffic

---

### 1.4 Bolt

**Strengths / نقاط القوة:**
- Fast, lightweight app (smallest APK)
- Clean minimal UI with good whitespace
- Category-specific vehicle illustrations
- Fast booking flow (< 3 taps to confirm)

**Weaknesses / نقاط الضعف:**
- Limited motion design
- No personality — too generic
- Basic map experience

**Learnable Ideas:**
- 3-tap booking flow
- Vehicle category illustrations (not just icons)
- Lightweight architecture

---

### 1.5 DiDi

**Strengths / نقاط القوة:**
- Most advanced real-time map in the industry
- AI-powered matching (< 30 seconds)
- Safety center with real-time tracking share
- Driver behavior AI scoring

**Weaknesses / نقاط الضعف:**
- Complex UI — too many features visible at once
- Requires Chinese phone number for full features

**Motion Design:**
- Fluid car animations with physics-based movement
- Beautiful searching state with particle effects
- Route morphing animation when rerouting

**Learnable Ideas:**
- Safety center with one-tap emergency
- Route share with contacts
- AI driver matching animation

---

### 1.6 Amap / Gaode Maps

**Strengths / نقاط القوة:**
- Best-in-class map rendering
- 3D building mode during navigation
- Dynamic lighting (day/night cycle)
- Traffic layer with real-time updates
- Turn-by-turn voice guidance

**Weaknesses / نقاط الضعف:**
- Chinese market only
- Complex for non-Chinese users

**Learnable Ideas:**
- 3D building visualization during trip
- Dynamic map tilt based on speed
- Day/night automatic map theme switch

---

### 1.7 Meituan

**Strengths / نقاط القوة:**
- Driver ETA bubble directly on map
- High-density information without clutter
- Excellent Chinese typography handling

**Weaknesses / نقاط الضعف:**
- Not localized for global markets

**Learnable Ideas:**
- ETA bubble floating above driver marker
- Density-optimized map markers
- Quick rebooking from trip history

---

### 1.8 Recommended Design Direction
### اتجاه التصميم الموصى به

Combine the best of all platforms:

| Feature | Source |
|---|---|
| Booking speed (< 10s) | Bolt |
| Map quality & car animation | DiDi + Amap |
| Driver personality & safety | Careem + DiDi |
| Wallet integration | Grab |
| Motion & celebration | Grab + DiDi |
| RTL/AR support | Careem |
| 3D map & dynamic lighting | Amap |
| Minimal UI | Uber + Bolt |

---

## 2. Design Philosophy
## فلسفة التصميم

### Core Principle: "The App is Alive"
### المبدأ الأساسي: "التطبيق حي"

Every element of RideGo should feel alive — not just functional. Movement is meaning. When a driver is found, the screen celebrates. When a car moves on the map, it breathes. When you tap a button, it responds with physicality.

كل عنصر في RideGo يجب أن يبدو حيًا — ليس مجرد وظيفي. الحركة تحمل معنى. عندما يُعثر على سائق، الشاشة تحتفل. عندما تتحرك سيارة على الخريطة، تتنفس. عندما تضغط على زر، يستجيب بواقعية.

### Design Values / قيم التصميم

1. **Speed / السرعة** — Book in under 10 seconds. Every interaction is optimized for speed.
2. **Trust / الثقة** — Show the driver's face, rating, and plate number. Safety is visible.
3. **Delight / البهجة** — Micro-interactions reward every action. Motion creates joy.
4. **Clarity / الوضوح** — One primary action per screen. No cognitive overload.
5. **Inclusivity / الشمولية** — RTL Arabic support, WCAG AA contrast, min 44pt touch targets.

---

## 3. User Personas
## شخصيات المستخدمين

### Persona 1: Ahmed — The Daily Commuter
### أحمد — المتنقل اليومي

- **Age / العمر:** 28
- **Location / الموقع:** Riyadh, Saudi Arabia
- **Goals / الأهداف:** Get to work quickly without driving stress
- **Pain Points / نقاط الألم:** Surge pricing surprises, long wait times
- **Tech Comfort:** High — uses 5–8 apps daily
- **Key Need:** Fast booking, predictable pricing, real-time tracking

### Persona 2: Fatima — The Occasional Rider
### فاطمة — المستخدمة العرضية

- **Age / العمر:** 42
- **Location / الموقع:** Jeddah, Saudi Arabia
- **Goals / الأهداف:** Safe, reliable rides for shopping and appointments
- **Pain Points / نقاط الألم:** Confusing apps, safety concerns
- **Tech Comfort:** Medium — prefers simplicity
- **Key Need:** Clear driver info, safety features, easy payment

### Persona 3: Mohammed — The Driver
### محمد — السائق

- **Age / العمر:** 35
- **Location / الموقع:** Riyadh
- **Goals / الأهداف:** Maximize earnings during peak hours
- **Pain Points / نقاط الألم:** Poor navigation, unfair cancellations
- **Tech Comfort:** Medium-High
- **Key Need:** Clear navigation, trip earnings visibility, efficient matching

---

## 4. User Journey
## رحلة المستخدم

### 4.1 Passenger Journey (Full Flow)
### رحلة الراكب الكاملة

```
[App Open]
    ↓
[Splash (1.5s)] → Brand animation, car drives in
    ↓
[Onboarding (new user)] → 3 slides: Speed / Track / Pay
    ↓
[Login / Register] → Phone OTP or Social
    ↓
[Home Screen] → Map + bottom sheet + nearby cars
    ↓
[Set Destination] → Search or tap on map
    ↓
[Vehicle Selection] → See route + ETA + fare estimate
    ↓
[Payment Selection] → Cash / Card / Wallet
    ↓
[Promo Code (optional)] → Apply discount
    ↓
[Confirm Booking] → One tap
    ↓
[Searching Driver] → Pulse animation (max 2 min)
    ↓
[Driver Accepted] → Driver details + ETA countdown
    ↓
[Driver Arriving] → Live map, OTP shown
    ↓
[Driver Waiting] → Timer starts (3 free minutes)
    ↓
[Trip Started] → Map tracks journey, safety tools
    ↓
[Trip In Progress] → Live tracking, share route option
    ↓
[Trip Finished] → Summary screen
    ↓
[Payment Processed] → Receipt
    ↓
[Rate Driver] → Stars + tags + optional tip
    ↓
[Home Screen] → Ready for next trip
```

### 4.2 Driver Journey
### رحلة السائق

```
[Go Online] → Toggle status
    ↓
[Incoming Trip Request] → Sound + vibration + map preview
    ↓
[Accept / Reject] → 15-second window
    ↓
[Navigate to Pickup] → Turn-by-turn
    ↓
[Arrive at Pickup] → Notify passenger, verify OTP
    ↓
[Start Trip] → Timer begins
    ↓
[Navigate to Destination] → Live navigation
    ↓
[Complete Trip] → Fare shown
    ↓
[Return to Online] → Earnings updated
```

### 4.3 Emergency / Safety Flow
### تدفق الطوارئ / السلامة

```
[Trip In Progress]
    ↓ (SOS button)
[Emergency Options]
    ├── Share trip with contact
    ├── Call emergency services
    ├── Silent alert to RideGo safety team
    └── Record audio (with notice)
```

---

## 5. Information Architecture
## هيكل المعلومات

### Passenger App IA

```
RideGo Passenger
├── Home (Map)
│   ├── Set Pickup
│   ├── Set Destination
│   └── Quick Places (Home, Work, Recent)
├── Booking
│   ├── Vehicle Selection
│   ├── Fare Estimate
│   ├── Promo Code
│   └── Payment Method
├── Trip
│   ├── Searching Driver
│   ├── Driver Info
│   ├── Live Map
│   ├── Trip Progress
│   └── Trip Summary
├── Wallet
│   ├── Balance
│   ├── Top Up
│   ├── Payment Methods
│   └── Transactions
├── History
│   ├── Completed Trips
│   ├── Cancelled Trips
│   └── Scheduled Trips
├── Profile
│   ├── Personal Info
│   ├── Settings
│   ├── Notifications
│   ├── Language
│   └── Theme
└── Support
    ├── FAQs
    ├── Report Issue
    └── Live Chat
```

---

## 6. User Flows
## مسارات المستخدم

### 6.1 New User Registration Flow

```
[Landing] → [Enter Phone] → [OTP Verification] 
→ [Profile Setup (name, photo)] → [Permissions (location)] 
→ [Home]
```

### 6.2 Book a Ride (Happy Path)

```
[Home] → [Tap Search] → [Type/Select Destination]
→ [View Route on Map] → [Select Vehicle Type]
→ [Confirm Payment] → [Tap Book]
→ [Searching...] → [Driver Found]
→ [Track Driver] → [Trip Starts]
→ [Arrive] → [Pay] → [Rate] → [Home]
```

### 6.3 Cancel Ride Flow

```
[Active Booking] → [Tap Cancel]
→ [Cancellation Reasons List]
→ [Confirm] → [Fee Warning (if applicable)]
→ [Cancelled State] → [Home]
```

---

## 7. Passenger App Screens
## شاشات تطبيق الراكب

### 7.1 Splash Screen

**Goal:** Brand impression, app initialization  
**Layout:** Full-screen gradient, centered logo, animated car  
**Animation:**
- Background: Radial gradient expands (800ms, ease-out)
- Logo: Scale from 0.6 → 1.0 with elastic bounce (600ms)
- Car: Slides in from left (500ms, cubic-bezier decelerate)
- Duration: 2.5s total before auto-navigation

**States:** Single state (loading/animation only)

---

### 7.2 Onboarding Screen

**Goal:** Introduce 3 core value propositions  
**Layout:** PageView with bottom controls  
**Components:** Illustration + Title + Subtitle + Dot Indicator + CTA Button

**Animation per slide:**
- Enter: Scale illustration 0.8→1.0 + fade (400ms)
- Exit: Slide left + fade (300ms)
- Dot indicator: Expanding dot (250ms)

**Interactions:**
- Swipe horizontally to navigate
- Skip button (top-right) goes to Login
- CTA button label changes on last slide: "Get Started"

---

### 7.3 Login Screen

**Goal:** Authenticate returning users  
**Layout:** Scrollable single column  
**Components:**
- Phone/Email toggle tabs
- Country code picker + phone input
- OTP verification step
- Social auth (Google, Apple)
- Link to Register

**States:**
- Default: Empty fields
- Typing: Field focused with blue border + shadow
- Loading: Button spinner
- Error: Red border + error message under field
- Success: Navigate to Home

**Animation:**
- Fields stagger in with fade + slide-up (80ms each)
- Button: Scale press 0.96 (150ms)
- Error: Shake animation (400ms, 3 cycles)

---

### 7.4 Home Screen

**Goal:** Main hub — set destination, see nearby cars  
**Layout:** Full-screen map + floating UI + bottom sheet  

**Map Layers (bottom to top):**
1. OSM base tiles
2. Traffic layer (optional)
3. Surge area polygons (heat map)
4. Nearby driver markers (animated)
5. Current location marker (pulsing)

**Bottom Sheet States:**
- Collapsed (18%): Search bar only
- Half (32%): Search + Quick actions + Recent places
- Full (55%): Full search experience

**Nearby Car Animation:**
- Cars gently bob vertically (2px, 1s loop, ease-in-out)
- On rotation: smooth heading lerp (0.1 factor per frame)
- New car appearing: scale 0→1 with bounce (elasticOut, 400ms)

---

### 7.5 Search Destination Screen

**Goal:** Find where the user wants to go  
**Layout:** White screen with fixed header + scrollable list

**Components:**
- Route input card (pickup + destination)
- Saved places (Home, Work)
- Recent places
- Search suggestions (instant filter)
- POI categories

**Interactions:**
- Keyboard auto-opens on destination field
- Results filter as user types (debounce 300ms)
- Tap result → route preview on map → vehicle selection

---

### 7.6 Vehicle Selection Screen

**Goal:** Choose vehicle type, see fare, confirm payment  
**Layout:** Map (top 45%) + bottom sheet (55%)

**Vehicle Cards (horizontal scroll):**
- Economy · Comfort · Premium · XL
- Selected card: Colored border + glow shadow + scale 1.06
- ETA in minutes shown per vehicle

**Fare Estimate:**
- Base fare + per-km + per-minute breakdown
- Promo code field
- Total with discount applied

**Animation:**
- Route polyline draws on enter (1200ms, path dash animation)
- Vehicle cards stagger in (60ms each)
- Selected state: Spring scale (elasticOut 300ms)

---

### 7.7 Searching Driver Screen

**Goal:** Communicate active search, maintain trust  
**Layout:** Dark full-screen with centered pulse animation

**Components:**
- 3-ring pulse animation (accent gold, 2s loop)
- Car icon in center
- "Finding your driver..." with animated dots
- Linear progress bar (indeterminate)
- Trip summary card (bottom)
- Cancel button (top-right, appears at 5s)

**States:**
- Searching (0–120s): Pulse animation
- No drivers found (120s): Error state + retry option
- Driver found: Transition to Driver Accepted

---

### 7.8 Driver Accepted Screen

**Goal:** Show driver moving toward pickup, build confidence  
**Layout:** Full-screen map + bottom sheet (42%)

**Components:**
- Animated driver car marker (bouncing + pulsing glow)
- ETA bubble (floating chip above map)
- Driver card: Photo + Name + Rating + Trip count
- Vehicle info: Make, model, plate, color
- OTP code display (4 digits)
- Action buttons: Message / Call / Cancel

**Animation:**
- Car moves from driver location → pickup (smooth lerp)
- ETA countdown: Number flip animation
- Driver card: Slide up from bottom (400ms, spring)

---

### 7.9 Trip Progress Screen

**Goal:** Track active trip, show progress, provide safety tools  
**Layout:** Full-screen map + mini bottom sheet

**Components:**
- Live car marker moving along route
- Progress bar showing % of trip complete
- Remaining time chip
- Destination info
- Share trip button
- Emergency button (red, always visible)
- Driver compact card with call/message

**Animation:**
- Car smoothly interpolates between GPS positions (300ms lerp)
- Progress bar fills in real-time
- ETA updates with number roll animation

---

### 7.10 Trip Finished Screen

**Goal:** Confirm trip ended, show payment, prompt rating  
**Layout:** Scrollable white screen

**Components:**
- Success checkmark animation (green, elastic bounce)
- Trip stats: Distance / Duration / Speed
- Payment receipt card
- "Rate your trip" primary CTA
- "Back to Home" secondary action

**Animation:**
- Checkmark: Draw path + scale bounce (800ms, elasticOut)
- Stats appear with stagger (100ms each)
- Confetti particles (optional, Rive)

---

### 7.11 Rating Screen

**Goal:** Collect driver rating and feedback  
**Layout:** Scrollable white screen

**Components:**
- Driver avatar (large, centered)
- Star rating (5 stars, interactive)
- Quick feedback tags (What went well?)
- Comment text field
- Tip section (for high ratings)
- Submit button

**Animation:**
- Stars: Each fills with scale bounce when tapped
- Rating label changes with animated crossfade
- Tags appear when rating ≥ 4 (stagger slide-up)
- Submit: Spinner → Success → Navigate

---

### 7.12 Wallet Screen

**Goal:** Manage payment methods and view balance  
**Layout:** List with gradient balance card at top

**Components:**
- Balance card (gradient, SAR amount)
- Quick actions: Top Up / Send / History
- Payment methods list
- Transaction history

---

### 7.13 Trip History Screen

**Goal:** View past trips with filtering  
**Layout:** List with filter chips at top

**Components:**
- Status filter chips (All / Completed / Cancelled)
- Trip cards with: destination, fare, rating, date, rebook button
- Pull-to-refresh

---

## 8. Driver App
## تطبيق السائق

### 8.1 Dashboard
- Online/Offline toggle (prominent, full-width button)
- Today's earnings widget
- Trip count and rating summary
- Map showing current location + pending trips

### 8.2 Incoming Trip Request
**Duration:** 15 seconds to accept  
**Components:**
- Full-screen overlay (doesn't block map)
- Pickup location + distance + estimated earnings
- Accept (green, prominent) / Decline (ghost)
- Countdown ring animation

**Animation:**
- Request slides up from bottom (spring physics)
- Countdown: Circular progress ring depleting
- Urgent pulse if < 5s remain

### 8.3 Navigation Screen
- Turn-by-turn directions overlay
- Next maneuver at top
- Remaining distance + ETA
- Traffic color coding on route
- "Arrived" button

### 8.4 Earnings Screen
- Daily / Weekly / Monthly toggle
- Bar chart of earnings per day
- Per-trip breakdown
- Payout history
- Tips received

---

## 9. Admin Dashboard
## لوحة التحكم الإدارية

### 9.1 Overview
- Real-time trip count (live counter animation)
- Active drivers on map (heat map view)
- Revenue today / this week / this month
- Alert notifications panel

### 9.2 Live Trips Map
- All active trips plotted on map
- Color by status: Searching (yellow), In Progress (blue), Completing (green)
- Click trip for details panel

### 9.3 Driver Management
- Driver list with status indicators
- Filter: Online / Offline / On Trip / Suspended
- Driver detail: Profile, rating history, earnings, document status

### 9.4 Analytics
- KPIs: DAU, Rides/Day, Revenue, Completion Rate, Cancellation Rate
- Funnel: Searches → Booked → Completed
- Heatmap: Demand density by area and time
- Driver utilization rate

### 9.5 Fraud Detection
- Suspicious trip patterns flagged by AI
- GPS anomaly detection
- Fare manipulation alerts
- Account verification queue

---

## 10. Map Experience
## تجربة الخريطة

### 10.1 Camera Behavior

| State | Zoom | Tilt | Follow |
|---|---|---|---|
| Home / Idle | 14 | 0° | User location |
| Vehicle Selection | 13 | 0° | Show route bounds |
| Driver Arriving | 15 | 20° | Driver + pickup |
| Trip In Progress | 16 | 40° | Car heading |
| Trip Finished | 13 | 0° | Full route |

### 10.2 Map Styles

**Day Mode:**
- Background: `#F5F5F5`
- Roads: `#FFFFFF`
- Labels: `#333333`
- Water: `#B3D1FF`
- Parks: `#C8E6C9`

**Night Mode:**
- Background: `#1A1A2E`
- Roads: `#2D2D44`
- Labels: `#AAAAAA`
- Water: `#0A1628`
- Parks: `#1B2A1B`

### 10.3 Map Elements Design

**Current Location Marker:**
- Inner dot: 16px, `#1B4FFF`, white border 3px
- Outer ring: 48px, `#1B4FFF` at 15% opacity
- Outer ring pulsing: scale 0.8→1.1, loop 2s

**Driver Car Marker:**
- Base: 44px circle, white background, shadow
- Icon: 24px taxi, primary blue
- Heading: Smooth rotation lerp (300ms)
- Movement: 200ms lerp between GPS positions
- Glow when selected: Primary blue shadow (12px blur)

**Pickup Marker:**
- Pin icon: 36px, success green
- Shadow: Soft drop shadow

**Dropoff Marker:**
- Pin icon: 36px, error red
- Pulsing ring during searching state

**Route Polyline:**
- Width: 5px
- Color: Primary blue `#1B4FFF`
- Traveled section: Grey `#D1D5DB`
- Dashed: Alternative route

**ETA Bubble:**
- Floating chip above driver marker
- Background: Dark `#0A1628`
- Icon + minutes text
- Updates every 30 seconds with count-up animation

**Surge Areas:**
- Polygon: `#FF6B35` at 25% opacity
- Border: `#FF6B35` at 60% opacity, dashed
- Label chip: Price multiplier shown

---

## 11. Design System
## نظام التصميم

### 11.1 Color System

#### Brand Colors
| Token | Hex | Usage |
|---|---|---|
| `primary` | `#1B4FFF` | Primary actions, active states |
| `primaryDark` | `#0A1628` | Dark backgrounds, splash |
| `primaryLight` | `#4B7BFF` | Dark mode primary |
| `primaryLighter` | `#E8EEFF` | Light tints, chip backgrounds |
| `accent` | `#FFD60A` | Highlights, premium elements |
| `accentDark` | `#E6BF00` | Accent pressed state |

#### Semantic Colors
| Token | Hex | Usage |
|---|---|---|
| `success` | `#10B981` | Completed, confirmed |
| `warning` | `#F59E0B` | Caution, surge |
| `error` | `#EF4444` | Failed, cancelled |
| `info` | `#3B82F6` | Informational |

#### Neutral Scale
| Token | Hex |
|---|---|
| `grey900` | `#1A1A2E` |
| `grey700` | `#4A4A6A` |
| `grey600` | `#6B7280` |
| `grey500` | `#9CA3AF` |
| `grey400` | `#D1D5DB` |
| `grey300` | `#E5E7EB` |
| `grey200` | `#F3F4F6` |
| `grey100` | `#F9FAFB` |

---

### 11.2 Typography

**Font Family:** Inter (Google Fonts)  
**Scale:** Material Design 3 type scale

| Style | Size | Weight | Line Height |
|---|---|---|---|
| Display Large | 57px | 700 | 1.12 |
| Display Medium | 45px | 700 | 1.16 |
| Display Small | 36px | 600 | 1.22 |
| Headline Large | 32px | 700 | 1.25 |
| Headline Medium | 28px | 600 | 1.29 |
| Headline Small | 24px | 600 | 1.33 |
| Title Large | 22px | 600 | 1.27 |
| Title Medium | 16px | 600 | 1.50 |
| Title Small | 14px | 600 | 1.43 |
| Body Large | 16px | 400 | 1.50 |
| Body Medium | 14px | 400 | 1.43 |
| Body Small | 12px | 400 | 1.33 |
| Label Large | 14px | 600 | 1.43 |
| Label Medium | 12px | 600 | 1.33 |
| Label Small | 10px | 600 | 1.60 |

**Special Styles:**
- `priceTag`: 36px, 800 weight, -1 letter spacing
- `etaDisplay`: 48px, 900 weight, -2 letter spacing
- `buttonText`: 16px, 700 weight, 0.5 letter spacing

---

### 11.3 Spacing System (4pt Grid)

| Token | Value |
|---|---|
| `xs` | 4px |
| `sm` | 8px |
| `md` | 12px |
| `base` | 16px |
| `lg` | 20px |
| `xl` | 24px |
| `xl2` | 32px |
| `xl3` | 40px |
| `xl4` | 48px |
| `screenPadding` | 20px |
| `cardPadding` | 20px |
| `buttonHeight` | 56px |
| `bottomNavHeight` | 80px |

---

### 11.4 Border Radius

| Token | Value | Usage |
|---|---|---|
| `xs` | 4px | Tags, badges |
| `sm` | 8px | Small chips |
| `md` | 12px | Inputs, small cards |
| `base` | 14px | Default inputs |
| `lg` | 16px | Standard cards |
| `xl` | 20px | Large cards |
| `xl2` | 24px | Prominent cards |
| `xl3` | 28px | Bottom sheets |
| `full` | 100px | Pills, buttons |

---

### 11.5 Elevation & Shadows

| Level | Usage | CSS Equivalent |
|---|---|---|
| `xs` | Subtle cards | `0 1px 4px rgba(0,0,0,0.04)` |
| `sm` | Lifted cards | `0 2px 8px rgba(0,0,0,0.06)` |
| `md` | Floating buttons | `0 4px 16px rgba(0,0,0,0.08)` |
| `lg` | Modals, sheets | `0 8px 32px rgba(0,0,0,0.10)` |
| `xl` | Full-screen overlays | `0 16px 48px rgba(0,0,0,0.14)` |
| `primaryGlow` | CTA buttons | `0 8px 24px rgba(27,79,255,0.36)` |
| `accentGlow` | Tip/accent cards | `0 6px 20px rgba(255,214,10,0.40)` |

---

### 11.6 Component Specifications

#### Button
- Height: 56px (large), 48px (medium), 40px (small)
- Border radius: 16px
- Padding: 24px horizontal
- Press scale: 0.96
- Press duration: 150ms
- Variants: Primary / Secondary / Outline / Ghost / Danger

#### Input Field
- Height: 56px
- Border radius: 14px
- Focused: 1.5px primary border + shadow
- Error: 1.5px error border
- Background: `grey100` (unfocused), white (focused)

#### Bottom Sheet
- Top radius: 28px
- Handle: 40×4px, `grey300`, centered
- Shadow: `mapCard` (inward top shadow)

#### Chip
- Height: 32px
- Border radius: 100px (pill)
- Padding: 12px horizontal, 8px vertical

---

## 12. Motion Design
## تصميم الحركة

### 12.1 Duration Scale

| Name | Duration | Usage |
|---|---|---|
| Instant | 100ms | Immediate feedback |
| Fast | 150ms | Button press, toggle |
| Normal | 250ms | Chip selection, small state changes |
| Medium | 350ms | Card transitions |
| Slow | 500ms | Page elements entering |
| Slower | 700ms | Complex animations |
| Slowest | 1000ms | Full-screen state changes |
| Page Transition | 400ms | Screen-to-screen |
| Map Camera | 800ms | Camera moves |
| Route Draw | 1200ms | Polyline rendering |

---

### 12.2 Easing Curves

| Curve | Usage |
|---|---|
| `easeOutCubic` (emphasizedDecelerate) | Elements entering screen |
| `easeInCubic` (emphasizedAccelerate) | Elements leaving screen |
| `easeInOutCubic` | Elements moving on screen |
| `elasticOut` | Playful bounce: markers, cards |
| `Curves.decelerate` | Camera movements |

---

### 12.3 Page Transitions

**Push (forward navigation):**
- New screen: Slide from right (400ms, easeOutCubic)
- Old screen: Fade out (200ms)

**Pop (back navigation):**
- Old screen: Slide to right (300ms, easeInCubic)
- Underlying screen: Fade in (200ms)

**Fade (modal / bottom sheet):**
- Backdrop: Fade 0→0.54 (300ms)
- Sheet: Slide up + fade (350ms, spring physics)

---

### 12.4 State-Specific Animations

#### Searching Driver Animation
```
Ring 1: scale 0.85 → 1.15, opacity 0.6 → 0, period 2000ms, delay 0ms
Ring 2: scale 0.85 → 1.15, opacity 0.6 → 0, period 2000ms, delay 667ms
Ring 3: scale 0.85 → 1.15, opacity 0.6 → 0, period 2000ms, delay 1333ms
Center car: Subtle scale 0.95 ↔ 1.05, period 1500ms
```

#### Driver Accepted Celebration
```
1. Flash: White overlay, opacity 0 → 0.8 → 0, duration 500ms
2. Card slide up: translateY 100% → 0, duration 400ms, spring
3. Driver photo scale: 0.5 → 1.0, elasticOut, 600ms
4. Rating badge: scale 0 → 1, elasticOut, delay 200ms
```

#### Trip Finished Success
```
1. Circle draw: stroke-dashoffset 0 → full, 600ms, easeOut
2. Checkmark: scale 0 → 1, elasticOut, 500ms, delay 300ms
3. Stats stagger: each card fades in, 100ms apart
4. Confetti (Rive): burst from top, 800ms
```

#### Payment Success
```
1. Number counter: Amount counts up, 800ms, easeOut
2. Checkmark badge: scale 0 → 1.2 → 1.0, 400ms
3. Card: subtle glow pulse, 2 cycles
```

#### Error State (Shake)
```
translateX: 0 → -8 → 8 → -6 → 6 → -4 → 4 → 0
Duration: 400ms
Count: 3.5 cycles
```

---

## 13. Micro Interactions
## التفاعلات الصغيرة

### 13.1 Button Press
- onTapDown: scale 0.96, duration 150ms, easeIn
- onTapUp: scale 1.0, duration 100ms, easeOut
- HapticFeedback: lightImpact on tap

### 13.2 Star Rating
- Tap star: scale 0 → 1.3 → 1.0, 300ms, elasticOut
- Fill: Color sweeps left to right, 200ms
- HapticFeedback: selectionClick per star

### 13.3 Toggle (Online/Offline)
- Track: Color transition, 250ms
- Thumb: Spring slide, 300ms
- HapticFeedback: heavyImpact on toggle

### 13.4 Vehicle Selection Card
- Tap: scale 1.0 → 1.06, 300ms, elasticOut
- Border: Color appears, 250ms
- Glow: Shadow expands, 300ms

### 13.5 Bottom Sheet Drag
- Snap points: 18% / 32% / 55% of screen height
- Elastic overshoot: 8px beyond snap point
- Release: Spring physics (stiffness 500, damping 28)
- Swipe down beyond min: Dismiss with velocity check

### 13.6 Map Zoom
- Pinch gesture: Smooth linear scale
- Double tap zoom in: Smooth ease, 300ms
- Auto-center on location: easeOutQuart, 800ms

### 13.7 Search Input
- Focus: Border color transition, 200ms + shadow appears
- Clear button: Fade in/out, 150ms
- Results list: Items stagger in, 40ms apart

### 13.8 Loading State (Shimmer)
- Gradient moves left→right, 1200ms loop
- Colors: `grey200` → `grey300` → `grey200`
- Items appear in same layout as real content

### 13.9 Location Update on Map
- User dot: Smooth move, 200ms lerp
- Camera follow: Smooth pan, 800ms
- Accuracy ring: Size updates with ease, 300ms

### 13.10 Notification Toast
- Enter: Slide down from top + fade in, 300ms
- Display: 3000ms
- Exit: Slide up + fade out, 200ms
- Can be dismissed with swipe

---

## 14. Lottie Specifications
## مواصفات Lottie

Use Lottie for pre-rendered complex animations that would be expensive to recreate in code.

| Animation | File | Duration | Loop | Trigger |
|---|---|---|---|---|
| Onboarding 1 (Rocket) | `onboarding_1.json` | 2000ms | true | Page visible |
| Onboarding 2 (Map Pin) | `onboarding_2.json` | 2000ms | true | Page visible |
| Onboarding 3 (Wallet) | `onboarding_3.json` | 1800ms | true | Page visible |
| Searching Driver | `searching_driver.json` | 2000ms | true | State: searching |
| Trip Success | `trip_success.json` | 1500ms | false | Trip completed |
| Payment Success | `payment_success.json` | 1200ms | false | Payment processed |
| Empty State (No Trips) | `empty_trips.json` | 3000ms | true | No data |
| Error State | `error_state.json` | 1000ms | false | Error occurs |
| Loading Indicator | `loading.json` | 1200ms | true | API loading |
| Driver Found Celebration | `driver_found.json` | 1000ms | false | Driver accepted |

**Lottie Integration (Flutter):**
```dart
Lottie.asset(
  'assets/animations/trip_success.json',
  width: 200,
  height: 200,
  repeat: false,
  onLoaded: (composition) {
    controller.duration = composition.duration;
    controller.forward();
  },
)
```

---

## 15. Rive Specifications
## مواصفات Rive

Use Rive for interactive, state-machine driven animations.

| Component | States | Inputs |
|---|---|---|
| Live Vehicle | idle, moving, turning, braking, arriving | `speed`, `heading`, `braking` |
| Online Toggle | offline, transitioning, online | `isOnline` (bool) |
| Loading Spinner | loading, success, error | `state` (enum) |
| Star Button | empty, filling, filled | `rating` (0–5) |
| Driver Avatar | waiting, smiling, waving | `mood` (enum) |
| Map Car | parked, driving, turning_left, turning_right | `heading`, `moving` |

**Vehicle Rive State Machine:**

```
States:
  - idle: subtle bob animation (loop)
  - moving: speed blur effect on wheels
  - turning: lean into direction
  - braking: slight forward pitch
  - arriving: slow decelerate + glow effect

Inputs:
  - speed: Number (0–120)
  - heading: Number (0–360)  
  - braking: Boolean
  - arriving: Boolean
```

**Rive Integration (Flutter):**
```dart
RiveAnimation.asset(
  'assets/animations/vehicle.riv',
  stateMachines: const ['VehicleStateMachine'],
  onInit: (artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard, 'VehicleStateMachine');
    artboard.addController(controller!);
    _speedInput = controller.findInput<double>('speed') as SMINumber;
    _headingInput = controller.findInput<double>('heading') as SMINumber;
  },
)
```

---

## 16. Accessibility
## إمكانية الوصول

### WCAG 2.1 AA Compliance

**Color Contrast:**
- Primary text on white: `#1A1A2E` → ratio 17:1 ✅
- Body text on white: `#4A4A6A` → ratio 8.5:1 ✅
- Primary button text: White on `#1B4FFF` → ratio 5.2:1 ✅
- Disabled text: `#9CA3AF` → ratio 3.2:1 (acceptable for disabled)

**Touch Targets:**
- Minimum: 44×44px for all interactive elements
- Preferred: 48×48px
- Critical buttons (emergency): 56×56px minimum

**Screen Reader Support:**
- All interactive elements have `Semantics` wrapper
- Images have `semanticLabel` descriptions
- Loading states announced: "Loading, please wait"
- State changes: "Driver found" announced automatically

**Large Text Support:**
- App respects system font size multiplier
- Layouts tested at 1.0x, 1.4x, 2.0x scale
- No fixed-height containers that clip text

**Motion Reduction:**
- Check `MediaQuery.disableAnimations`
- When true: Replace all animations with instant transitions
- Pulse rings: Show static ring instead of animated

**Color Blind Support:**
- Never rely on color alone for status (always add icon + text)
- Status colors paired with icons: ✓ success, ✗ error, ⚠ warning
- Map route: Color + width differentiation

**RTL (Arabic) Support:**
- Directionality.of(context) checked throughout
- Icons mirrored: back arrows, chevrons
- Text alignment: `TextDirection.rtl` for Arabic content
- Map: No change needed (maps are direction-agnostic)

---

## 17. Responsive Design
## التصميم المتجاوب

### 17.1 Screen Size Breakpoints

| Device | Width Range | Layout |
|---|---|---|
| Small Android | 360–400px | Single column, compact spacing |
| Standard Android/iPhone | 400–430px | Standard (design baseline) |
| Large iPhone (Pro Max) | 430–480px | Wider cards, more content visible |
| Android Tablet (portrait) | 600–900px | Side panel unlocked |
| iPad / Tablet (landscape) | 900px+ | Split view: Map left, controls right |
| Foldable (unfolded) | 800px+ | Two-pane layout |

### 17.2 Adaptive Layouts

**Bottom Sheet on Tablet:**
- Max width: 480px, centered horizontally
- Floating card style instead of full-width sheet

**Map + Controls on Large Screen:**
```
┌─────────────┬────────────────────────────────┐
│             │                                │
│   Controls  │         Live Map               │
│  (360px)    │                                │
│             │                                │
└─────────────┴────────────────────────────────┘
```

**Vehicle Selection on Tablet:**
- Grid view (2 columns) instead of horizontal scroll

### 17.3 Safe Areas

```dart
SafeArea(
  top: true,    // iOS notch / Dynamic Island
  bottom: true, // Home indicator on iPhone
  left: false,  // No horizontal safe area needed
  right: false,
)
```

---

## 18. Developer Handoff
## تسليم المطور

### 18.1 Project Structure (Flutter)

```
lib/
├── core/
│   ├── theme/
│   │   ├── app_colors.dart       # All color tokens
│   │   ├── app_typography.dart   # All text styles
│   │   ├── app_spacing.dart      # Spacing, radius, shadows
│   │   └── app_theme.dart        # ThemeData (light + dark)
│   ├── constants/
│   │   ├── app_constants.dart    # App-wide constants
│   │   └── animation_constants.dart  # Duration, curves, physics
│   └── providers/
│       ├── app_provider.dart     # Theme, locale, auth state
│       ├── location_provider.dart # GPS, pickup/dropoff
│       └── trip_provider.dart    # Trip state machine
├── features/
│   ├── splash/
│   ├── onboarding/
│   ├── auth/screens/
│   ├── home/screens/
│   ├── search/screens/
│   ├── booking/screens/
│   ├── trip/screens/
│   ├── profile/screens/
│   ├── wallet/screens/
│   └── history/screens/
├── shared/widgets/
│   ├── app_button.dart          # AppButton + IconAppButton
│   ├── app_text_field.dart      # AppTextField + SearchField
│   ├── bottom_sheet_handle.dart # BottomSheetHandle + AppBottomSheet
│   └── pulse_ring_widget.dart   # PulseRingWidget + StarRatingWidget
├── app.dart                     # GoRouter + Routes
└── main.dart                    # Entry point + providers
```

### 18.2 Naming Conventions

| Asset Type | Convention | Example |
|---|---|---|
| Dart files | snake_case | `vehicle_selection_screen.dart` |
| Classes | PascalCase | `VehicleSelectionScreen` |
| Variables | camelCase | `selectedVehicleType` |
| Constants | camelCase | `AppColors.primary` |
| Routes | kebab-case | `/vehicle-selection` |
| Lottie files | snake_case | `searching_driver.json` |
| Rive files | snake_case | `vehicle_animation.riv` |
| Image assets | snake_case | `car_economy.png` |

### 18.3 Animation Token Usage

```dart
// ✅ Correct — use tokens
AnimatedContainer(
  duration: AnimationConstants.medium,
  curve: AnimationConstants.emphasizedDecelerate,
)

// ❌ Avoid — magic numbers
AnimatedContainer(
  duration: Duration(milliseconds: 350),
  curve: Curves.easeOutCubic,
)
```

### 18.4 Color Token Usage

```dart
// ✅ Correct
color: AppColors.primary

// ❌ Avoid
color: Color(0xFF1B4FFF)
```

### 18.5 Component Constraints

```dart
AppButton(
  label: 'Book Economy · SAR 12–15',
  onTap: _onBook,
  size: AppButtonSize.lg,      // default: 56px height
  fullWidth: true,              // default
  gradient: AppColors.primaryGradient,
)

AppTextField(
  hint: 'Where to?',
  controller: _destCtrl,
  keyboardType: TextInputType.streetAddress,
  prefix: Icon(Icons.search_rounded, color: AppColors.grey400),
)
```

### 18.6 Flutter Packages (pubspec.yaml)

```yaml
dependencies:
  flutter_map: ^7.0.2       # Maps (OpenStreetMap)
  latlong2: ^0.9.1           # LatLng coordinates
  flutter_animate: ^4.5.0   # Declarative animations
  lottie: ^3.1.3             # Lottie animations
  rive: ^0.13.16             # Rive interactive animations
  google_fonts: ^6.2.1      # Inter font
  go_router: ^14.0.0        # Navigation
  provider: ^6.1.2           # State management
  geolocator: ^13.0.4       # GPS location
  permission_handler: ^11.3.1 # Permissions
  smooth_page_indicator: ^1.2.0+3  # Onboarding dots
  shimmer: ^3.0.0            # Loading skeleton
  cached_network_image: ^3.4.1     # Network images
  shared_preferences: ^2.3.2       # Local storage
```

---

## 19. Innovative Ideas
## أفكار مبتكرة

### 19.1 Living Map Background
**الخريطة الحية في الخلفية**

Background cars on the home screen move naturally — speed varies based on real time of day (faster in morning rush, slower at night). Implementation: pre-programmed path animations using Rive, not real GPS data.

### 19.2 Dynamic Weather Effects
**تأثيرات الطقس الديناميكية**

- Rain: Particle overlay on map (light drops on screen)
- Night: Automatic switch to dark map theme after sunset
- Hot day: Slight heat shimmer at bottom of map
- All effects: Check weather API on app launch, apply overlay

### 19.3 Smart ETA Visualization
**تصور ذكي للوقت المتبقي**

Instead of showing "8 min" — show a visual arc that depletes in real-time like a countdown clock, color-shifting from green (on time) to amber (slightly delayed) to red (significantly delayed).

### 19.4 Haptic Rhythm Language
**لغة اهتزاز إيقاعية**

Different haptic patterns communicate different events:
- Driver found: 2 quick taps
- Trip started: 1 long tap
- Arrived: 3 ascending taps
- Cancel: 1 heavy tap

### 19.5 Dynamic Pricing Visualization
**تصور الأسعار الديناميكية**

Surge areas shown as heat map rings pulsing from high-demand zones. Color shifts from cool blue (no surge) → warm yellow → orange → red (3x+ surge). Rings animate outward to show demand spreading.

### 19.6 60–120 FPS Optimizations
**تحسينات 60–120 إطار في الثانية**

- All animations use `RepaintBoundary` to isolate paint areas
- Map tiles rendered on separate layer from UI
- Car movements driven by `AnimationController` (not `setState`)
- Use `const` constructors everywhere possible
- `flutter_animate` uses `Tween` + `AnimationController` (not periodic timers)

### 19.7 Ambient Audio Design
**التصميم الصوتي المحيطي**

Subtle, non-intrusive sounds (opt-in, off by default):
- Driver found: Short chime (C major chord, 200ms)
- Trip started: Whoosh sound
- Payment success: Gentle coin sound
- Error: Soft low tone

### 19.8 Predictive Destination
**الوجهة التنبؤية**

Use time of day + day of week + location history to pre-populate the most likely destination:
- Monday 8:30 AM → "Head to work?"
- Friday 1:00 PM → "Heading to Friday prayers?"
- Show as suggestion chip, one tap to confirm.

### 19.9 Social Safety Features
**ميزات السلامة الاجتماعية**

- Share trip link with family (updates in real-time)
- Trusted contacts get SMS when trip starts/ends
- Fake call button: App simulates incoming call for awkward situations
- Mask phone number: Both driver and passenger call through VoIP proxy

### 19.10 Driver Arrival Micro-Movie
**فيلم قصير عند وصول السائق**

When the driver is 200m away:
1. Map zooms in smoothly to driver + pickup
2. Walking directions appear for the passenger
3. "Your driver is almost here" card slides up with pulse animation
4. Car marker grows slightly as it approaches
5. OTP code highlights when car is within 50m

---

## Appendix A: Design System Export Checklist
## ملحق أ: قائمة تصدير نظام التصميم

- [ ] Figma tokens exported as JSON
- [ ] All components documented with all variants
- [ ] Interactive prototypes for all main flows
- [ ] Lottie files exported and compressed
- [ ] Rive state machines documented with all inputs
- [ ] Icon set exported as SVG (24×24 viewbox)
- [ ] Color palette exported (CSS, Dart, Figma)
- [ ] Typography scale verified on physical devices
- [ ] Accessibility audit completed (WCAG AA)
- [ ] RTL layout verified on Arabic device

---

## Appendix B: Performance Targets
## ملحق ب: أهداف الأداء

| Metric | Target |
|---|---|
| App cold start | < 2 seconds |
| Time to interactive (Home) | < 3 seconds |
| Booking confirmation time | < 500ms |
| Map frame rate | 60 FPS minimum |
| Map frame rate (120Hz devices) | 120 FPS |
| Animation jank | 0 dropped frames |
| APK size (release) | < 25 MB |
| Memory usage | < 180 MB peak |
| Battery drain per trip | < 3% per hour |

---

*Document prepared by RideGo Design Team · يوليو 2026*  
*For implementation support, refer to the Flutter codebase in `/lib/`*

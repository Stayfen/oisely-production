# Oisely Custom Design System

A soft, friendly UI design system for the Oisely pet adoption app, featuring pastel colors, rounded shapes, and a warm aesthetic.

## Design Philosophy

The Oisely design system embraces a **soft, friendly, and approachable** aesthetic perfect for a pet adoption platform. Key characteristics:

- **Soft pastel colors** for backgrounds and cards
- **Rounded shapes** throughout (20-30px border radius)
- **Warm orange/amber** as the primary action color
- **Clean typography** with ample whitespace
- **Subtle shadows** for depth without harshness
- **Circular elements** for icons and avatars

## Visual Identity

### Color Palette

#### Primary Colors
| Name | Hex | Usage |
|------|-----|-------|
| Primary Orange | #F5A623 | CTAs, buttons, accents |
| Primary Orange Light | #FFD9A0 | Button hover states |
| Primary Orange Dark | #D48A1A | Button pressed states |

#### Background Colors
| Name | Hex | Usage |
|------|-----|-------|
| Background Cream | #FAF8F5 | Main app background |
| Background White | #FFFFFF | Cards, sheets |
| Background Soft | #F5F2EE | Secondary backgrounds |

#### Pastel Card Colors
| Name | Hex | Usage |
|------|-----|-------|
| Soft Pink | #FFD6E0 | Pet cards, featured items |
| Soft Yellow | #FFF3D6 | Promo cards, highlights |
| Soft Blue | #D6E8FF | Info cards, secondary content |
| Soft Green | #D6F5E3 | Success states, available pets |
| Soft Purple | #E8D6FF | Category backgrounds |
| Soft Peach | #FFE8D6 | Alternative card backgrounds |

#### Text Colors
| Name | Hex | Usage |
|------|-----|-------|
| Text Primary | #1A1A1A | Headlines, primary text |
| Text Secondary | #4A4A4A | Body text |
| Text Tertiary | #8A8A8A | Captions, hints |
| Text White | #FFFFFF | Text on dark/colored backgrounds |

#### Semantic Colors
| Name | Hex | Usage |
|------|-----|-------|
| Success Green | #4CAF50 | Success states, checkmarks |
| Error Red | #EF5350 | Error states |
| Warning Amber | #FF9800 | Warnings |
| Info Blue | #2196F3 | Information |

#### Dark/UI Colors
| Name | Hex | Usage |
|------|-----|-------|
| Dark Navy | #1E1E2D | Dark buttons, icons |
| Dark Card | #2D2D3A | Dark elements |
| Star Yellow | #FFD700 | Ratings |

### Typography

#### Font Family
- **Primary**: Inter (Google Fonts)
- **Fallback**: system-ui, -apple-system, sans-serif

#### Type Scale

| Style | Size | Weight | Line Height | Usage |
|-------|------|--------|-------------|-------|
| H1 | 32px | Bold (700) | 1.2 | Screen titles |
| H2 | 24px | Bold (700) | 1.3 | Section headers |
| H3 | 20px | SemiBold (600) | 1.4 | Card titles |
| H4 | 18px | SemiBold (600) | 1.4 | Subsection titles |
| Body Large | 16px | Regular (400) | 1.5 | Primary body text |
| Body | 14px | Regular (400) | 1.5 | Secondary body text |
| Caption | 12px | Medium (500) | 1.4 | Labels, captions |
| Small | 11px | Medium (500) | 1.4 | Timestamps, hints |
| Button | 14px | SemiBold (600) | 1.0 | Button text |
| Price | 20px | Bold (700) | 1.2 | Prices |

### Spacing System

#### Base Unit: 8px

| Token | Value | Usage |
|-------|-------|-------|
| xs | 4px | Tight spacing, icon padding |
| sm | 8px | Compact spacing |
| md | 12px | Standard component padding |
| lg | 16px | Card padding, section gaps |
| xl | 20px | Large gaps |
| xxl | 24px | Section spacing |
| xxxl | 32px | Screen padding |
| xxxxl | 48px | Major section breaks |

### Border Radius

| Token | Value | Usage |
|-------|-------|-------|
| sm | 12px | Small buttons, chips |
| md | 16px | Input fields, small cards |
| lg | 20px | Standard cards |
| xl | 24px | Large cards, modals |
| xxl | 28px | Bottom sheets |
| pill | 999px | Pill buttons, tags |
| full | 50% | Circular elements |

### Shadows

| Token | Value | Usage |
|-------|-------|-------|
| sm | 0 2px 8px rgba(0,0,0,0.06) | Subtle elevation |
| md | 0 4px 16px rgba(0,0,0,0.08) | Cards |
| lg | 0 8px 24px rgba(0,0,0,0.10) | Modals, elevated cards |
| xl | 0 16px 40px rgba(0,0,0,0.12) | Bottom sheets |

## Component Specifications

### OiselyCard

**Variants:**
1. **PetCard** - Soft pastel background with image
2. **InfoCard** - White background with border
3. **PromoCard** - Colored background (yellow/pink)
4. **CategoryCard** - Circular with icon

**Specifications:**
- Border radius: 20px (lg)
- Padding: 16px (lg)
- Shadow: md
- Background: varies by variant

### OiselyButton

**Variants:**
1. **Primary** - Orange fill, white text, pill shape
2. **Secondary** - White fill, orange border, pill shape
3. **Tertiary** - Transparent, orange text
4. **Icon** - Circular, colored background
5. **Floating** - Circular with shadow

**Specifications:**
- Primary/Secondary: pill border radius (999px)
- Padding: 16px horizontal, 14px vertical
- Icon buttons: 48px circular

### OiselyChip

**Variants:**
1. **CategoryChip** - Icon + label, selectable
2. **FilterChip** - Rounded, togglable
3. **InfoChip** - Small, icon + text

**Specifications:**
- Border radius: 12px (sm) or pill
- Padding: 8px 12px
- Icon size: 20px

### OiselyTextField

**Specifications:**
- Border radius: 16px (md)
- Background: #F5F2EE
- Border: none (filled style)
- Padding: 16px
- Icon: leading, gray

### OiselyAvatar

**Specifications:**
- Sizes: sm (32px), md (40px), lg (56px), xl (80px)
- Border radius: full (circular)
- Border: optional white border

### OiselyAppBar

**Specifications:**
- Background: transparent or cream
- Elevation: 0
- Title: centered, H3 style
- Actions: circular icon buttons

### OiselyBottomSheet

**Specifications:**
- Border radius: 28px top corners (xxl)
- Background: white
- Handle indicator: 40px width, 4px height
- Padding: 24px

### OiselyEmptyState

**Specifications:**
- Icon: 80px, soft colored background
- Title: H3
- Subtitle: Body, centered
- Action: Primary button

### OiselyBadge

**Specifications:**
- Border radius: pill
- Background: orange or red
- Text: white, Caption style
- Padding: 4px 8px

### OiselyPetCard

**Specific component for pet listings:**
- Large image (rounded corners)
- Pastel background
- Name: H3
- Location: Body with icon
- Price or badge
- Favorite button (top-right)

## Screen-Specific Patterns

### Home Screen
- Welcome header with user avatar
- Search bar (rounded, filled)
- Horizontal category chips
- Promo banner card
- Horizontal scrolling pet cards
- "See all" links with arrow

### Pet Detail Screen
- Large hero image with gradient overlay
- Floating back button
- Favorite/bookmark action
- Name and rating
- Quick info pills (sex, age, weight)
- "About" section with expand
- Action buttons (call, message, adopt)

### Onboarding Screen
- Large illustration
- Bold headline
- Subtitle text
- Primary CTA button
- Skip option

## Animation Guidelines

### Durations
- Quick: 150ms (micro-interactions)
- Normal: 300ms (standard transitions)
- Slow: 500ms (page transitions)

### Curves
- Standard: Curves.easeInOut
- Enter: Curves.easeOut
- Exit: Curves.easeIn
- Bounce: Curves.elasticOut

## File Structure

```
lib/design_system/
├── tokens/
│   ├── oisely_colors.dart      # All color definitions
│   ├── oisely_typography.dart  # Text styles
│   ├── oisely_spacing.dart     # Spacing constants
│   └── oisely_shapes.dart      # Border radius, shadows
├── components/
│   ├── oisely_card.dart
│   ├── oisely_button.dart
│   ├── oisely_chip.dart
│   ├── oisely_text_field.dart
│   ├── oisely_avatar.dart
│   ├── oisely_app_bar.dart
│   ├── oisely_bottom_sheet.dart
│   └── oisely_pet_card.dart
├── theme/
│   └── oisely_theme.dart       # Complete ThemeData
└── utils/
    └── extensions.dart         # Helper extensions
```

## Implementation Notes

1. Use `ColorScheme` for Material integration but override extensively
2. Define all colors as const for performance
3. Use Flutter's `ThemeExtension` for custom tokens
4. Components should accept `Color?` for variant backgrounds
5. Always use `SafeArea` and responsive padding
6. Test on various screen sizes

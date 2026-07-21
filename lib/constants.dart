import 'package:flutter/material.dart';

// Text Colors
const kTextColor = Color(0xFF707070);
const kTextLightColor = Color(0xFF555555);
const kTextDarkColor = Color(0xFF1A1A2E);

// Brand Colors (Unified Palette)
const kPrimaryColor = Color(0xFF0080FF);      // Primary Blue
const kPrimaryLightColor = Color(0xFFCEE4FD); // Light Blue
const kAccentColor = Color(0xFF07E24A);       // Accent Green
const kAccentYellow = Color(0xFFFFB100);      // Secondary Accent

// Background Colors
const kBgLight = Color(0xFFF8FAFB);
const kBgLighter = Color(0xFFF0F4F8);

// Spacing
const kDefaultPadding = 20.0;

// Shadows (Unified)
final kDefaultShadow = BoxShadow(
  offset: const Offset(0, 8),
  blurRadius: 24,
  color: kPrimaryColor.withValues(alpha: 0.08),
);

final kDefaultCardShadow = BoxShadow(
  offset: const Offset(0, 8),
  blurRadius: 24,
  color: Colors.black.withValues(alpha: 0.08),
);

final kHoverShadow = BoxShadow(
  offset: const Offset(0, 12),
  blurRadius: 32,
  color: kPrimaryColor.withValues(alpha: 0.15),
);

// TextField design
final kDefaultInputDecorationTheme = InputDecorationTheme(
  border: kDefaultOutlineInputBorder,
  enabledBorder: kDefaultOutlineInputBorder,
  focusedBorder: kDefaultOutlineInputBorder,
);

final kDefaultOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: kPrimaryLightColor,
  ),
);

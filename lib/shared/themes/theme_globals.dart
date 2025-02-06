import 'package:flutter/material.dart';

import 'custom_fade_transition_builder.dart';

const appFontTextStyle = TextStyle(fontFamily: 'Inter');

// TEXT STYLES
final size10weight400 =
    appFontTextStyle.copyWith(fontSize: 10.0, fontWeight: FontWeight.w400);
final size10weight500 =
    appFontTextStyle.copyWith(fontSize: 10.0, fontWeight: FontWeight.w500);
final size10weight600 =
    appFontTextStyle.copyWith(fontSize: 10.0, fontWeight: FontWeight.w600);
final size10weight700 =
    appFontTextStyle.copyWith(fontSize: 10.0, fontWeight: FontWeight.w700);

final size11weight400 =
    appFontTextStyle.copyWith(fontSize: 11.0, fontWeight: FontWeight.w400);
final size11weight500 =
    appFontTextStyle.copyWith(fontSize: 11.0, fontWeight: FontWeight.w500);
final size11weight600 =
    appFontTextStyle.copyWith(fontSize: 11.0, fontWeight: FontWeight.w600);
final size11weight700 =
    appFontTextStyle.copyWith(fontSize: 11.0, fontWeight: FontWeight.w700);

final size12weight400 =
    appFontTextStyle.copyWith(fontSize: 12.0, fontWeight: FontWeight.w400);
final size12weight500 =
    appFontTextStyle.copyWith(fontSize: 12.0, fontWeight: FontWeight.w500);
final size12weight600 =
    appFontTextStyle.copyWith(fontSize: 12.0, fontWeight: FontWeight.w600);
final size12weight700 =
    appFontTextStyle.copyWith(fontSize: 12.0, fontWeight: FontWeight.w700);

final size13weight400 =
    appFontTextStyle.copyWith(fontSize: 13.0, fontWeight: FontWeight.w400);
final size13weight500 =
    appFontTextStyle.copyWith(fontSize: 13.0, fontWeight: FontWeight.w500);
final size13weight600 =
    appFontTextStyle.copyWith(fontSize: 13.0, fontWeight: FontWeight.w600);
final size13weight700 =
    appFontTextStyle.copyWith(fontSize: 13.0, fontWeight: FontWeight.w700);

final size14weight400 =
    appFontTextStyle.copyWith(fontSize: 14.0, fontWeight: FontWeight.w400);
final size14weight500 =
    appFontTextStyle.copyWith(fontSize: 14.0, fontWeight: FontWeight.w500);
final size14weight600 =
    appFontTextStyle.copyWith(fontSize: 14.0, fontWeight: FontWeight.w600);
final size14weight700 =
    appFontTextStyle.copyWith(fontSize: 14.0, fontWeight: FontWeight.w700);

final size15weight400 =
    appFontTextStyle.copyWith(fontSize: 15.0, fontWeight: FontWeight.w400);
final size15weight500 =
    appFontTextStyle.copyWith(fontSize: 15.0, fontWeight: FontWeight.w500);
final size15weight600 =
    appFontTextStyle.copyWith(fontSize: 15.0, fontWeight: FontWeight.w600);
final size15weight700 =
    appFontTextStyle.copyWith(fontSize: 15.0, fontWeight: FontWeight.w700);

final size16weight400 =
    appFontTextStyle.copyWith(fontSize: 16.0, fontWeight: FontWeight.w400);
final size16weight500 =
    appFontTextStyle.copyWith(fontSize: 16.0, fontWeight: FontWeight.w500);
final size16weight600 =
    appFontTextStyle.copyWith(fontSize: 16.0, fontWeight: FontWeight.w600);
final size16weight700 =
    appFontTextStyle.copyWith(fontSize: 16.0, fontWeight: FontWeight.w700);

final size17weight400 =
    appFontTextStyle.copyWith(fontSize: 17.0, fontWeight: FontWeight.w400);
final size17weight500 =
    appFontTextStyle.copyWith(fontSize: 17.0, fontWeight: FontWeight.w500);
final size17weight600 =
    appFontTextStyle.copyWith(fontSize: 17.0, fontWeight: FontWeight.w600);
final size17weight700 =
    appFontTextStyle.copyWith(fontSize: 17.0, fontWeight: FontWeight.w700);

final size18weight400 =
    appFontTextStyle.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400);
final size18weight500 =
    appFontTextStyle.copyWith(fontSize: 18.0, fontWeight: FontWeight.w500);
final size18weight600 =
    appFontTextStyle.copyWith(fontSize: 18.0, fontWeight: FontWeight.w600);
final size18weight700 =
    appFontTextStyle.copyWith(fontSize: 18.0, fontWeight: FontWeight.w700);

final size20weight400 =
    appFontTextStyle.copyWith(fontSize: 20.0, fontWeight: FontWeight.w400);
final size20weight500 =
    appFontTextStyle.copyWith(fontSize: 20.0, fontWeight: FontWeight.w500);
final size20weight600 =
    appFontTextStyle.copyWith(fontSize: 20.0, fontWeight: FontWeight.w600);
final size20weight700 =
    appFontTextStyle.copyWith(fontSize: 20.0, fontWeight: FontWeight.w700);

final size24weight400 =
    appFontTextStyle.copyWith(fontSize: 24.0, fontWeight: FontWeight.w400);
final size24weight500 =
    appFontTextStyle.copyWith(fontSize: 24.0, fontWeight: FontWeight.w500);
final size24weight600 =
    appFontTextStyle.copyWith(fontSize: 24.0, fontWeight: FontWeight.w600);
final size24weight700 =
    appFontTextStyle.copyWith(fontSize: 24.0, fontWeight: FontWeight.w700);

final size32weight400 =
    appFontTextStyle.copyWith(fontSize: 32.0, fontWeight: FontWeight.w400);
final size32weight500 =
    appFontTextStyle.copyWith(fontSize: 32.0, fontWeight: FontWeight.w500);
final size32weight600 =
    appFontTextStyle.copyWith(fontSize: 32.0, fontWeight: FontWeight.w600);
final size32weight700 =
    appFontTextStyle.copyWith(fontSize: 32.0, fontWeight: FontWeight.w700);

final size36weight400 =
    appFontTextStyle.copyWith(fontSize: 36.0, fontWeight: FontWeight.w400);
final size36weight500 =
    appFontTextStyle.copyWith(fontSize: 36.0, fontWeight: FontWeight.w500);
final size36weight600 =
    appFontTextStyle.copyWith(fontSize: 36.0, fontWeight: FontWeight.w600);
final size36weight700 =
    appFontTextStyle.copyWith(fontSize: 36.0, fontWeight: FontWeight.w700);

// Headings
final h1 = appFontTextStyle.copyWith(
  fontSize: 32,
  fontWeight: FontWeight.w700,
  height: 40,
  color: greyScale00,
);

final h2 = appFontTextStyle.copyWith(
  fontSize: 24,
  fontWeight: FontWeight.w700,
  height: 32,
);

final h3 = appFontTextStyle.copyWith(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  height: 22.5,
);

final h4 = appFontTextStyle.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  height: 20,
);

// Labels
final l1 = appFontTextStyle.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w700,
  height: 20,
);

final l2 = appFontTextStyle.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  height: 20,
);

final l3 = appFontTextStyle.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  height: 20,
);

final l4 = appFontTextStyle.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  height: 17.5,
);

final l5 = appFontTextStyle.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  height: 17.5,
);

final l6 = appFontTextStyle.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  height: 17.5,
);

final l7 = appFontTextStyle.copyWith(
  fontSize: 12,
  fontWeight: FontWeight.w700,
  height: 15,
);

final l8 = appFontTextStyle.copyWith(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  height: 15,
);

final l9 = appFontTextStyle.copyWith(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  height: 15,
);

// Paragraphs
final p1 = appFontTextStyle.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  height: 24,
);

final p2 = appFontTextStyle.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  height: 24,
);

final p3 = appFontTextStyle.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  height: 19.6,
);

final p4 = appFontTextStyle.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  height: 19.6,
);

// COLORS
const primaryColor = Color(0xff5454D1);
const mainBlueLight = Color(0xff009CDB);
const greenColor = Color(0xff2DAD40);
const redColor = Color(0xffCA2442);
const scaffoldBackgroundColor = Color(0xffF2F2F5);
const lightIconColor = Colors.black54;
const defaultTextColor = Color(0xff222B45);
const softGreyColor = Color(0xffEDF1F8);
const greyColor = Color(0xff808D9E);
const borderColor = Color(0xffDFE1E8);
const otpInputBorderColor = Color(0xffE2E8F0);
const textFieldBorderColor = Color(0xffE6E7EB);
const orangeColor = Color(0xffEBB000);
const sectionDividerColor = Color(0xffF3F6FC);
const incrementBackgroundColor = Color(0xff363944);
const blueColor = Color(0xff546FFA);
const badgeColor = Color(0xffCA2442);
const secondaryTextOnLightColor = Color(0xff808086);
const secondaryTextOnDarkColor = Colors.white70;
const secondaryBackgroundColor = Color(0xFFF2F2F5);
const dragColor = Color(0xffB0B0B6);

const mainBlueLightColor = Color(0xff009CDB);
const linkColor = Color(0xff2C64E3);
const otpBlue = Color(0xff2C64E3);
const headerBlue = Color(0xff2E55A5);
const backgroundBlueColor = Color(0xff38B2E2);
const lightRedColor = Color(0xffEEDDE3);

const info100Color = Color(0xffF2F8FF);
const info200Color = Color(0xffC7E2FF);
const info400Color = Color(0xff42AAFF);

const success500Color = Color(0xff00D68F);

const greyScale00 = Color(0xff151525);
const greyScale50 = Color(0xff797980);
const greyScale54 = Color(0xff83838A);
const greyScale72 = Color(0xffAEAEB7);
const greyScale92 = Color(0xffE6E6EB);
const greyScale96 = Color(0xffF2F2F4);

const basic100Color = Color(0xffE9E9EA);
const basic200Color = Color(0xffF7F9FC);
const basic300Color = Color(0xffA5A9AB);
const basic400Color = Color(0xff808D9E);
const basic500Color = Color(0xffC5CEE0);
const basic600Color = Color(0xff8F9BB3);
const basic700Color = Color(0xff2E3A59);

const danger100Color = Color(0xffFFF2F2);
const danger500Color = Color(0xffFF3D71);

const primary700 = Color(0xff60D1F0);

const otherIndicatorColor = Color(0xffE4E9F2);
const lightPurple = Color(0xffE4E4F7);
const greenMedium = Color(0xFF119425);
const lightGrey = Color(0xffF5F5FA);

const ghostPurple = Color(0xffF5F5FA);
const lightGreen = Color(0xffCBE4D1);

const roundedCardColor = Colors.white;
const primaryIconColor = primaryColor;
Color selectedOrderColor = primaryColor.withOpacity(.35);

const textFieldValueColor = Color(0xff151525);
const selectedTabColor = Color(0xffE4E4F7);
const unselectedTabColor = Color(0xffE6E6EB);

const selectedTabTextColor = primaryColor;
const unselectedTabTextColor = Color(0xff83838A);

const disabledTextFieldColor = greyScale92;
const enabledTextFieldColor = Colors.white;

// DURATIONS
const firstDelayDuration = Duration(milliseconds: 300);
const secondDelayDuration = Duration(milliseconds: 600);
const thirdDelayDuration = Duration(milliseconds: 900);

// TRANSITIONS
final pageTransitionsTheme = PageTransitionsTheme(
  builders: {
    TargetPlatform.android: const OpenUpwardsPageTransitionsBuilder(),
    TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
    TargetPlatform.macOS: CustomFadeTransitionBuilder(),
    TargetPlatform.linux: CustomFadeTransitionBuilder(),
    TargetPlatform.windows: CustomFadeTransitionBuilder(),
  },
);

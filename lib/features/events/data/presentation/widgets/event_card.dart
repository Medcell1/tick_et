import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_app_flutter/core/config/app_images.dart';
import 'package:ticket_app_flutter/shared/extensions/media_query_context_extension.dart';
import 'package:ticket_app_flutter/shared/extensions/sized_box_num_extension.dart';
import 'package:ticket_app_flutter/shared/themes/colors.dart';
import 'package:ticket_app_flutter/shared/themes/typography.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/eventDetail'),
      child: Container(
        width: context.screenWidth * 0.6,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.darkGrey, width: 3),
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            image: AssetImage(splash),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: context.screenWidth * 0.55,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xff2828284d),
                        const Color(0xff484848).withOpacity(0.5),
                      ],
                    ),
                    border: Border.all(color: Colors.white, width: 0.5),
                  ),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 1.0,
                        sigmaY: 1.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Splash & Chill',
                                      style: AppTypography.headline
                                          .copyWith(fontSize: 14),
                                    ),
                                    Text(
                                      'Eagle King ent.',
                                      style: AppTypography.subtitle.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '\$9.99',
                                  style: AppTypography.priceStyle,
                                )
                              ],
                            ),
                            4.spaceHeight(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cotonou',
                                  style: AppTypography.body.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  '22 December 2024',
                                  style: AppTypography.body.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

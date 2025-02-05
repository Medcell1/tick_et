import 'package:flutter/material.dart';
import 'package:ticket_app_flutter/shared/extensions/media_query_context_extension.dart';
import 'dart:ui';

import 'package:ticket_app_flutter/shared/themes/typography.dart';

class SeeMoreEventCard extends StatelessWidget {
  final String title;
  final String organizer;
  final String location;
  final String date;
  final String price;
  final String image;

  const SeeMoreEventCard({
    super.key,
    required this.title,
    required this.organizer,
    required this.location,
    required this.date,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: context.screenHeight *0.12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Image.asset(
                    image,
                    width: context.screenWidth * 0.25,
                    height: context.screenHeight *0.12,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: AppTypography.headline,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          // Text(
                          //   price,
                          //   style: AppTypography.priceStyle.copyWith(fontSize: 25),
                          //   overflow: TextOverflow.ellipsis,
                          //   maxLines: 1,
                          // ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$organizer • $location',
                        style: AppTypography.subtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$date',
                        style: AppTypography.body.copyWith(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ticket_app_flutter/core/utils/globals.dart';
import 'package:ticket_app_flutter/features/home/data/models/event.dart';
import 'package:ticket_app_flutter/shared/extensions/media_query_context_extension.dart';
import 'package:ticket_app_flutter/shared/extensions/sized_box_num_extension.dart';
import 'package:ticket_app_flutter/shared/themes/colors.dart';
import 'package:ticket_app_flutter/shared/themes/typography.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/events/${event.id}'),
      child: Container(
        width: context.screenWidth * 0.6,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.darkGrey, width: 3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: CachedNetworkImage(
                imageUrl: event.mediaUrls[0],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.white.withOpacity(0.5),
                  highlightColor: Colors.white.withOpacity(0.5),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                errorWidget: (context, url, error) => const Center(
                  child:
                      Icon(Icons.broken_image, color: Colors.white70, size: 50),
                ),
              ),
            ),
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
                        const Color(0xff484848).withOpacity(0.3),
                        const Color(0xff484848).withOpacity(0.9),
                      ],
                    ),
                    border: Border.all(color: Colors.white, width: 0.5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.headline
                                      .copyWith(fontSize: 14),
                                ),
                                Text(
                                  event.owner,
                                  style: AppTypography.subtitle.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            4.spaceHeight(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    event.location,
                                    style: AppTypography.body.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  Globals.formatDate(event.date),
                                  style: AppTypography.body.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
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

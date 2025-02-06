import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ticket_app_flutter/core/utils/globals.dart';
import 'package:ticket_app_flutter/features/home/data/models/event.dart';
import 'package:ticket_app_flutter/shared/extensions/media_query_context_extension.dart';
import 'package:ticket_app_flutter/shared/themes/typography.dart';

class SeeMoreEventCard extends StatelessWidget {
  final Event event;

  const SeeMoreEventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/events/${event.id}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: context.screenHeight * 0.12,
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
                    child: CachedNetworkImage(
                      imageUrl: event.mediaUrls[0],
                      width: context.screenWidth * 0.25,
                      height: context.screenHeight * 0.12,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.white.withOpacity(0.3),
                        highlightColor: Colors.white.withOpacity(0.6),
                        child: Container(
                          width: context.screenWidth * 0.25,
                          height: context.screenHeight * 0.12,
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
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
                              event.name,
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
                          '${event.owner} • ${event.location}',
                          style: AppTypography.subtitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          Globals.formatDate(event.date),
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
      ),
    );
  }
}

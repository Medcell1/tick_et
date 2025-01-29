import 'package:flutter/material.dart';
import 'package:ticket_app_flutter/core/config/app_icons.dart';
import 'package:ticket_app_flutter/features/events/data/presentation/widgets/event_card.dart';
import 'package:ticket_app_flutter/features/events/data/presentation/widgets/event_category_pill.dart';
import 'package:ticket_app_flutter/shared/extensions/media_query_context_extension.dart';
import 'package:ticket_app_flutter/shared/extensions/sized_box_num_extension.dart';
import 'package:ticket_app_flutter/shared/themes/typography.dart';
import 'package:ticket_app_flutter/shared/widgets/gradient_scaffold.dart';
import 'package:ticket_app_flutter/shared/widgets/svg_icon.dart';
import '../../../../../shared/themes/colors.dart';

class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Hey Mikky',
            style: AppTypography.headline.copyWith(fontSize: 17),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.primaryDark,
                      AppColors.primaryLight,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(3, 3),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 0.5,
                  ),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  color: Colors.transparent,
                  child: const Icon(
                    Icons.bookmark,
                    color: AppColors.accentPink,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.darkGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const SvgIcon(
                        assetPath: searchIcon,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle:
                                AppTypography.headline.copyWith(fontSize: 14),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              24.spaceHeight(),
              _buildSectionHeader('Categories '),
              12.spaceHeight(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Row(
                    children: [
                      EventCategoryPill(
                        text: '🎵 Music Fest',
                      ),
                      EventCategoryPill(
                        text: '🎭 StandUp Show',
                      ),
                      EventCategoryPill(
                        text: '🏊‍♂️ Swimming',
                      ),
                    ],
                  ),
                ),
              ),
              24.spaceHeight(),
              _buildSectionHeader('Trending'),
              12.spaceHeight(),
              SizedBox(
                height: context.screenHeight * 0.25,
                child: ListView.builder(
                  itemCount: 3,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const EventCard();
                  },
                ),
              ),
              24.spaceHeight(),
              _buildSectionHeader('Vibes near me'),
              12.spaceHeight(),
              SizedBox(
                height: context.screenHeight * 0.25,
                child: ListView.builder(
                  itemCount: 3,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const EventCard();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTypography.headline,
        ),
        Text(
          'See More',
          style: AppTypography.subtitle,
        ),
        // Text(
        //   'See More',
        //   style: AppTypography.subtitle,
        // ),
      ],
    ),
  );
}

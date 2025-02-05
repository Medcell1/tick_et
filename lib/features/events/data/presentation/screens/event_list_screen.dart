import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_app_flutter/core/config/app_icons.dart';
import 'package:ticket_app_flutter/features/events/data/presentation/widgets/event_card.dart';
import 'package:ticket_app_flutter/features/events/data/presentation/widgets/event_category_pill.dart';
import 'package:ticket_app_flutter/shared/extensions/media_query_context_extension.dart';
import 'package:ticket_app_flutter/shared/extensions/sized_box_num_extension.dart';
import 'package:ticket_app_flutter/shared/themes/typography.dart';
import 'package:ticket_app_flutter/shared/widgets/gradient_scaffold.dart';
import 'package:ticket_app_flutter/shared/widgets/svg_icon.dart';
import '../../../../../core/config/app_images.dart';
import '../../../../../shared/themes/colors.dart';

class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> dummyEvents = [
      {
        'title': 'Splash & Chill',
        'organizer': 'Eagle King ent.',
        'location': 'Cotonou',
        'date': '22 December 2024',
        'price': '\$9.99',
        'image': splash,
      },
      {
        'title': 'Music Fiesta',
        'organizer': 'Vibe Nation',
        'location': 'Lagos',
        'date': '5 January 2025',
        'price': '\$15.00',
        'image': splash,
      },
      {
        'title': 'Comedy Night',
        'organizer': 'Laugh Masters',
        'location': 'Accra',
        'date': '14 February 2025',
        'price': '\$8.00',
        'image': splash,
      },
    ];
    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Welcome,',
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
              _buildSectionHeader('Categories ', context, '/categories'),
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
              _buildSectionHeader('Trending', context, '/trending'),
              12.spaceHeight(),
              SizedBox(
                height: context.screenHeight * 0.25,
                child: ListView.builder(
                  itemCount: dummyEvents.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final event = dummyEvents[index];
                    return Hero(
                      tag: event['price']!,
                      child: EventCard(
                        title: event['title']!,
                        organizer: event['organizer']!,
                        location: event['location']!,
                        date: event['date']!,
                        price: event['price']!,
                        image: event['image']!,
                      ),
                    );
                  },
                ),
              ),
              24.spaceHeight(),
              _buildSectionHeader('Vibes near me', context, '/nearme'),
              12.spaceHeight(),
              SizedBox(
                height: context.screenHeight * 0.25,
                child: ListView.builder(
                  itemCount: 3,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final event = dummyEvents[index];
                    return EventCard(
                      title: event['title']!,
                      organizer: event['organizer']!,
                      location: event['location']!,
                      date: event['date']!,
                      price: event['price']!,
                      image: event['image']!,
                    );
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

Widget _buildSectionHeader(String title, BuildContext context, String route) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTypography.headline,
        ),
        GestureDetector(
          onTap: () => context.push(route),
          child: Text(
            'See More',
            style: AppTypography.subtitle,
          ),
        ),
      ],
    ),
  );
}

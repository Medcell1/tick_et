import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:ticket_app_flutter/core/config/app_icons.dart';
import 'package:ticket_app_flutter/features/home/data/presentation/widgets/event_card.dart';
import 'package:ticket_app_flutter/features/home/data/presentation/widgets/event_category_pill.dart';
import 'package:ticket_app_flutter/shared/extensions/media_query_context_extension.dart';
import 'package:ticket_app_flutter/shared/extensions/sized_box_num_extension.dart';
import 'package:ticket_app_flutter/shared/themes/typography.dart';
import 'package:ticket_app_flutter/shared/widgets/gradient_scaffold.dart';
import 'package:ticket_app_flutter/shared/widgets/svg_icon.dart';
import '../../../../../shared/themes/colors.dart';
import '../../providers/home_feed_provider.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<HomeFeedProvider>().loadHomeFeed(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(),
        body: Consumer<HomeFeedProvider>(
          builder: (context, provider, child) {
            if (provider.error != null) {
              return Center(
                child: Text(
                  'Error: ${provider.error}',
                  style: AppTypography.headline.copyWith(color: Colors.red),
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  24.spaceHeight(),
                  _buildCategoriesSection(provider),
                  24.spaceHeight(),
                  _buildTrendingSection(provider),
                  24.spaceHeight(),
                  _buildNearbySection(provider),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
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
                colors: [AppColors.primaryDark, AppColors.primaryLight],
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
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              color: Colors.transparent,
              child: const Icon(Icons.bookmark, color: AppColors.accentPink),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.darkGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SvgIcon(assetPath: searchIcon, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: AppTypography.headline.copyWith(fontSize: 14),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(HomeFeedProvider provider) {
    try {
      return Column(
        children: [
          _buildSectionHeader('Categories ', context, '/categories'),
          12.spaceHeight(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Row(
                children: provider.isLoading
                    ? List.generate(
                        10,
                        (index) => const Skeletonizer(
                          enabled: true,
                          enableSwitchAnimation: true,
                          child: EventCategoryPill(
                            text: 'Pool Party',
                            id: '',
                          ),
                        ),
                      )
                    : provider.homeFeed?.categories.map((category) {
                          return EventCategoryPill(
                            text: category.name,
                            id: category.id,
                          );
                        }).toList() ??
                        [],
              ),
            ),
          ),
        ],
      );
    } catch (e, stackTrace) {
      print('Error in categories section: $e');
      print('Stack trace: $stackTrace');
      return Center(child: Text('Error loading categories: $e'));
    }
  }

  Widget _buildTrendingSection(HomeFeedProvider provider) {
    try {
      return Column(
        children: [
          _buildSectionHeader('Trending', context, '/trending'),
          12.spaceHeight(),
          SizedBox(
            height: context.screenHeight * 0.25,
            child: provider.isLoading
                ? _buildShimmerEventList()
                : ListView.builder(
                    itemCount: provider.homeFeed?.nearby.length != null
                        ? (provider.homeFeed!.nearby.length > 5
                            ? 5
                            : provider.homeFeed!.nearby.length)
                        : 0,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final event = provider.homeFeed!.trending[index];

                      return Hero(
                        tag: event.id,
                        child: EventCard(
                          event: event,
                        ),
                      );
                    },
                  ),
          ),
        ],
      );
    } catch (e, stackTrace) {
      print('Error in trending section: $e');
      print('Stack trace: $stackTrace');
      return Center(
        child: Text('Error loading trending: $e'),
      );
    }
  }

  Widget _buildNearbySection(HomeFeedProvider provider) {
    return Column(
      children: [
        _buildSectionHeader('Vibes near me', context, '/nearme'),
        12.spaceHeight(),
        SizedBox(
          height: context.screenHeight * 0.25,
          child: provider.isLoading
              ? _buildShimmerEventList()
              : ListView.builder(
                  itemCount: provider.homeFeed?.nearby.length != null
                      ? (provider.homeFeed!.nearby.length > 5
                          ? 5
                          : provider.homeFeed!.nearby.length)
                      : 0,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final event = provider.homeFeed!.nearby[index];
                    return EventCard(
                      event: event,
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildShimmerEventList() {
    return ListView.builder(
      itemCount: 3,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.white.withOpacity(0.5),
        highlightColor: Colors.white.withOpacity(0.5),
        child: Container(
          margin: const EdgeInsets.only(left: 16),
          width: context.screenWidth * 0.6,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
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
        Text(title, style: AppTypography.headline),
        GestureDetector(
          onTap: () => context.push(route),
          child: Text('See More', style: AppTypography.subtitle),
        ),
      ],
    ),
  );
}

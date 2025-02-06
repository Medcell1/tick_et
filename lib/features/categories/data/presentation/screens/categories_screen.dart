import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:ticket_app_flutter/features/categories/data/provider/categories_provider.dart';

import '../../../../../shared/themes/colors.dart';
import '../../../../../shared/themes/typography.dart';
import '../../../../../shared/widgets/gradient_scaffold.dart';
import '../../../../see_more/data/presentation/widgets/see_more_event_card.dart';

class CategoriesScreen extends StatefulWidget {
  final String? selectedCategoryId;

  const CategoriesScreen({super.key, this.selectedCategoryId});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<EventCategoriesProvider>(context, listen: false);
      provider.loadCategories().then((_) {
        if (widget.selectedCategoryId != null) {
          provider.toggleCategory(widget.selectedCategoryId!);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Categories',
            style: AppTypography.headline.copyWith(fontSize: 17),
          ),
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),
        ),
        body: Consumer<EventCategoriesProvider>(
          builder: (context, provider, child) {
            if (provider.error != null) {
              return Center(
                child: Text(
                  provider.error!,
                  style: AppTypography.headline.copyWith(color: Colors.red),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeletonizer(
                  enabled: provider.isLoadingEvents,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: provider.categories
                          .map((category) => GestureDetector(
                                onTap: () =>
                                    provider.toggleCategory(category.id),
                                child: EventCategoryChips(
                                  text: category.name,
                                  isSelected: provider.selectedCategories
                                      .contains(category.id),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: Skeletonizer(
                    enabled: provider.isLoadingEvents,
                    child: ListView.builder(
                      itemCount: provider.events.length,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemBuilder: (context, index) {
                        final event = provider.events[index];
                        return SeeMoreEventCard(
                          event: event,
                          key: ValueKey(event.id),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class EventCategoryChips extends StatelessWidget {
  final String text;
  final bool isSelected;

  const EventCategoryChips({
    super.key,
    required this.text,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: isSelected
              ? [AppColors.primaryDark, AppColors.primaryLight]
              : [Colors.grey.shade700, Colors.grey.shade600],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: AppTypography.body.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_app_flutter/core/config/app_images.dart';
import '../../../../../shared/themes/typography.dart';
import '../../../../../shared/widgets/gradient_scaffold.dart';
import '../../../../../shared/themes/colors.dart';
import '../../../../see_more/presentation/widgets/see_more_event_card.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<String> categories = [
    'Music',
    'Sports',
    'Art',
    'Tech',
    'Food',
    'Comedy'
  ];

  final List<String> selectedCategories = [];

  final List<Map<String, String>> allEvents = [
    {
      'title': 'Summer Music Festival',
      'category': 'Music',
      'organizer': 'Local Music Org',
      'location': 'City Park',
      'date': 'Aug 15, 2024',
      'price': '\$50',
      'image': splash,
    },
    {
      'title': 'Tech Conference',
      'category': 'Tech',
      'organizer': 'Tech Innovators',
      'location': 'Convention Center',
      'date': 'Sept 20, 2024',
      'price': '\$100',
      'image': splash,
    },
    {
      'title': 'Comedy Night',
      'category': 'Comedy',
      'organizer': 'Laugh Factory',
      'location': 'Downtown Theater',
      'date': 'July 10, 2024',
      'price': '\$35',
      'image': splash,
    },
  ];

  List<Map<String, String>> get filteredEvents {
    return allEvents
        .where((event) => selectedCategories.contains(event['category']))
        .toList();
  }

  void _toggleCategory(String category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        if (selectedCategories.length > 1) {
          selectedCategories.remove(category);
        }
      } else {
        selectedCategories.add(category);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    selectedCategories.add(categories.first);
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
              onTap: () => context.pop(),
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: categories
                    .map((category) => GestureDetector(
                          onTap: () => _toggleCategory(category),
                          child: EventCategoryChips(
                            text: category,
                            isSelected: selectedCategories.contains(category),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: filteredEvents
                    .map((event) => SeeMoreEventCard(
                          title: event['title']!,
                          organizer: event['organizer']!,
                          location: event['location']!,
                          date: event['date']!,
                          price: event['price']!,
                          image: event['image']!,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCategoryChips extends StatelessWidget {
  final String text;
  final bool isSelected;

  const EventCategoryChips(
      {super.key, required this.text, this.isSelected = false});

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

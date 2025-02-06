import 'package:ticket_app_flutter/features/categories/data/models/event_category.dart';

import 'event.dart';

class HomeFeed {
  final List<Event> trending;
  final List<Event> nearby;
  final List<EventCategory> categories;

  HomeFeed({
    required this.trending,
    required this.nearby,
    required this.categories,
  });
}

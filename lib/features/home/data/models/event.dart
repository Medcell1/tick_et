import 'package:dartz/dartz.dart';
import 'package:ticket_app_flutter/core/utils/globals.dart';
import 'package:ticket_app_flutter/features/categories/data/models/event_category.dart';

import '../../../../shared/models/ticket_type.dart';
import '../../../../shared/models/user.dart';

class Event {
  final String id;
  final String name;
  final String owner;
  final String description;
  final String location;
  final DateTime date;
  final List<Either<String, EventCategory>> categories;
  final List<Either<String, TicketType>> ticketTypes;
  final Either<String, User> createdBy;
  final DateTime createdAt;
  final int bookmarks;
  final DateTime lastUpdated;
  final List<String> mediaUrls;

  Event({
    required this.id,
    required this.name,
    required this.owner,
    required this.description,
    required this.location,
    required this.date,
    required this.categories,
    required this.ticketTypes,
    required this.createdBy,
    required this.createdAt,
    required this.bookmarks,
    required this.lastUpdated,
    required this.mediaUrls,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'] as String,
      name: json['name'] as String,
      owner: json['owner'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      date: DateTime.parse(json['date']),
      categories: Globals.parseEitherList<EventCategory>(
        json['categories'] as List,
        EventCategory.fromJson,
      ),
      ticketTypes: Globals.parseEitherList<TicketType>(
        json['ticketTypes'] as List,
        TicketType.fromJson,
      ),
      createdBy: Globals.parseEither<User>(
        json['createdBy'],
        User.fromJson,
      ),
      createdAt: DateTime.parse(json['createdAt']),
      bookmarks: json['bookmarks'] as int,
      lastUpdated: DateTime.parse(json['lastUpdated']),
      mediaUrls: List<String>.from(json['mediaUrls']),
    );
  }
}

class EventsHomeFeedResponse {
  final List<Event> trending;
  final List<Event> nearby;
  final List<Event> feed;

  EventsHomeFeedResponse({
    required this.trending,
    required this.nearby,
    required this.feed,
  });

  factory EventsHomeFeedResponse.fromJson(Map<String, dynamic> json) {
    return EventsHomeFeedResponse(
      trending: (json['trending'] as List)
          .map((event) => Event.fromJson(event))
          .toList(),
      nearby: (json['nearby'] as List)
          .map((event) => Event.fromJson(event))
          .toList(),
      feed:
          (json['feed'] as List).map((event) => Event.fromJson(event)).toList(),
    );
  }
}

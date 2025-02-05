import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:ticket_app_flutter/features/categories/data/provider/categories_provider.dart';
import 'package:ticket_app_flutter/features/home/data/providers/home_feed_provider.dart';
import 'package:ticket_app_flutter/features/home/data/providers/view_event_provider.dart';

class Globals {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<HomeFeedProvider>(
      create: (_) => HomeFeedProvider(),
    ),
    ChangeNotifierProvider<EventCategoryProvider>(
      create: (_) => EventCategoryProvider(),
    ),  ChangeNotifierProvider<ViewEventProvider>(
      create: (_) => ViewEventProvider(),
    ),
  ];

  static String formatDate(DateTime inputDate) {
    try {
      DateFormat formatter = DateFormat('dd MMMM yyyy');
      return formatter.format(inputDate);
    } catch (e) {
      return 'Invalid date format';
    }
  }

  static Either<String, T> parseEither<T>(
    dynamic value,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (value is Map) {
      return Right(fromJson(value as Map<String, dynamic>));
    } else {
      return Left(value);
    }
  }

  static List<Either<String, T>> parseEitherList<T>(
    List<dynamic> list,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return list.map((item) => parseEither<T>(item, fromJson)).toList();
  }
}

import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:ticket_app_flutter/core/config/locator.dart';
import 'package:ticket_app_flutter/features/categories/data/models/event_category.dart';
import 'package:ticket_app_flutter/features/categories/data/repositories/category_repository.dart';
import 'package:ticket_app_flutter/features/home/data/models/home_feed.dart';
import '../../../../shared/models/failure.dart';
import '../repositories/events_repository.dart';

class HomeFeedProvider extends ChangeNotifier {
  final EventsRepository _repository = getIt<EventsRepositoryImpl>();
  HomeFeed? homeFeed;
  bool isLoading = false;
  String? error;

  Future<void> loadHomeFeed() async {
    isLoading = true;
    error = null;
    notifyListeners();

    final categoriesResult = await getEventCategories();
    final homeFeedResult = await _repository.getHomeFeed();

    categoriesResult.fold(
          (categoryFailure) {
        error = categoryFailure.message;
        isLoading = false;
        notifyListeners();
        return;
      },
          (categories) {
        homeFeedResult.fold(
              (homeFeedFailure) {
            error = homeFeedFailure.message;
            isLoading = false;
            notifyListeners();
          },
              (homeFeedResponse) {
            homeFeed = HomeFeed(
              trending: homeFeedResponse.trending,
              nearby: homeFeedResponse.nearby,
              categories: categories,
            );
            error = null;
            isLoading = false;
            notifyListeners();
          },
        );
      },
    );
  }
  Future<Either<Failure, List<EventCategory>>> getEventCategories() async {
    final categoriesRepo = getIt<EventCategoryRepositoryImpl>();
    return await categoriesRepo.getAllCategories();
  }
}

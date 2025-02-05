import 'package:flutter/material.dart';

import '../../../../core/config/locator.dart';
import '../models/event_category.dart';
import '../repositories/category_repository.dart';

class EventCategoryProvider extends ChangeNotifier {
  final EventCategoryRepository _repository = getIt<EventCategoryRepositoryImpl>();

  List<EventCategory> categories = [];
  List<EventCategory> featuredCategories = [];
  Map<String, EventCategory> categoryDetails = {};

  bool isLoading = false;
  String? error;

  Future<void> loadAllCategories() async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await _repository.getAllCategories();
    result.fold(
          (failure) => error = failure.message,
          (data) => categories = data,
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadFeaturedCategories() async {
    final result = await _repository.getFeaturedCategories();
    result.fold(
          (failure) => error = failure.message,
          (data) => featuredCategories = data,
    );

    notifyListeners();
  }

  Future<EventCategory?> getCategoryDetails(String id) async {
    if (categoryDetails.containsKey(id)) {
      return categoryDetails[id];
    }

    final result = await _repository.getCategoryById(id);
    return result.fold(
          (failure) {
        error = failure.message;
        notifyListeners();
        return null;
      },
          (category) {
        categoryDetails[id] = category;
        notifyListeners();
        return category;
      },
    );
  }
}

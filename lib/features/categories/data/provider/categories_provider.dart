import 'package:flutter/material.dart';
import 'package:ticket_app_flutter/core/config/locator.dart';
import 'package:ticket_app_flutter/features/categories/data/repositories/category_repository.dart';
import 'package:ticket_app_flutter/features/home/data/repositories/events_repository.dart';

import '../../../home/data/models/event.dart';
import '../models/event_category.dart';

class EventCategoriesProvider with ChangeNotifier {
  final EventsRepositoryImpl _eventsRepository = getIt<EventsRepositoryImpl>();
  final EventCategoryRepositoryImpl _categoriesRepo =
      getIt<EventCategoryRepositoryImpl>();

  List<EventCategory> _categories = [];
  List<EventCategory> get categories => _categories;

  List<Event> _events = [];
  List<Event> get events => _events;

  List<String> _selectedCategories = [];
  List<String> get selectedCategories => _selectedCategories;

  bool _isLoadingCategories = false;
  bool get isLoadingCategories => _isLoadingCategories;

  bool _isLoadingEvents = false;
  bool get isLoadingEvents => _isLoadingEvents;

  String? _error;
  String? get error => _error;

  Future<void> loadCategories() async {
    _isLoadingCategories = true;
    _events = [];
    _categories = [];
    notifyListeners();

    final result = await _categoriesRepo.getAllCategories();
    result.fold(
      (failure) {
        _error = failure.message;
      },
      (categories) {
        _categories = categories;
        if (_categories.isNotEmpty) {
          if (selectedCategories.isEmpty) {
            _selectedCategories.add(_categories.first.id);
          } else {
            toggleCategory(_selectedCategories);
          }
          loadEventsByCategory();
        }
      },
    );

    _isLoadingCategories = false;
    notifyListeners();
  }

  Future<void> loadEventsByCategory() async {
    _isLoadingEvents = true;
    notifyListeners();

    final result =
        await _eventsRepository.getEventsByCategory(_selectedCategories);
    result.fold(
      (failure) {
        _error = failure.message;
      },
      (events) {
        _events = events;
      },
    );

    _isLoadingEvents = false;
    notifyListeners();
  }

  void toggleCategory(dynamic categoryIds) {
    if (categoryIds is String) {
      // Handle single category ID
      if (_selectedCategories.contains(categoryIds)) {
        if (_selectedCategories.length > 1) {
          _selectedCategories.remove(categoryIds);
        }
      } else {
        _selectedCategories.add(categoryIds);
      }
    } else if (categoryIds is List<String>) {
      _selectedCategories = categoryIds;
    } else {
      throw ArgumentError('categoryIds must be a String or List<String>');
    }

    notifyListeners();
    loadEventsByCategory();
  }
}

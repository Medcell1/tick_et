import 'package:flutter/material.dart';
import 'package:ticket_app_flutter/core/config/locator.dart';
import 'package:ticket_app_flutter/features/home/data/models/event.dart';

import '../../../home/data/repositories/events_repository.dart';

class SeeMoreProvider extends ChangeNotifier {
  final EventsRepositoryImpl _repository = getIt<EventsRepositoryImpl>();
  bool isLoading = false;
  String? error;
  List<Event> events = [];

  Future<void> loadSeeMore(bool isTrending) async {
    isLoading = true;
    error = null;
    notifyListeners();
    final result = isTrending
        ? await _repository.getTrendingEvents()
        : await _repository.getNearbyEvents();
    result.fold((failure) {
      error = failure.message;
      isLoading = false;
      notifyListeners();
    }, (data) {
      events = data;
      isLoading = false;
      notifyListeners();
    });
  }
}

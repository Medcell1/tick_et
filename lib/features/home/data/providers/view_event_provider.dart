import 'package:flutter/material.dart';

import 'package:ticket_app_flutter/core/config/locator.dart';
import 'package:ticket_app_flutter/features/home/data/models/event.dart';
import '../repositories/events_repository.dart';

class ViewEventProvider extends ChangeNotifier {
  final EventsRepository _repository = getIt<EventsRepositoryImpl>();
  bool isLoading = false;
  String? error;
  Event? eventDetails;

  Future<void> loadEventDetails(String id) async {
    isLoading = true;
    error = null;
    notifyListeners();
eventDetails = null;
    final eventDetailsResult = await _repository.getEventDetailsById(id);
    eventDetailsResult.fold((failure) {
      error = failure.message;
      isLoading = false;
      notifyListeners();
      return;
    }, (details) {
      eventDetails = details;
      error = null;
      isLoading = false;
      notifyListeners();
    });
  }

  void clearEvent() {
    eventDetails = null;
    notifyListeners();
  }
}

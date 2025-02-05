import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/failure.dart';
import '../models/event.dart';


abstract class EventsRepository {
  Future<Either<Failure, List<Event>>> getTrendingEvents();
  Future<Either<Failure, List<Event>>> getNearbyEvents();
  Future<Either<Failure, EventsHomeFeedResponse>> getHomeFeed();
  Future<Either<Failure, List<Event>>> getEventsByCategory(String category);
  Future<Either<Failure, Event>> getEventDetailsById(String id);

}

class EventsRepositoryImpl implements EventsRepository {
  final DioService _dioService;

  EventsRepositoryImpl(this._dioService);

  @override
  Future<Either<Failure, List<Event>>> getTrendingEvents() async {
    return _handleRequest<List<Event>>(
          () async {
        final response = await _dioService.dio.get('/events/trending');
        final List<dynamic> data = response.data['events'];
        return data.map((json) => Event.fromJson(json)).toList();
      },
    );
  }

  @override
  Future<Either<Failure, List<Event>>> getNearbyEvents() async {
    return _handleRequest<List<Event>>(
          () async {
        final response = await _dioService.dio.get('/events/nearby');
        final List<dynamic> data = response.data['events'];
        return data.map((json) => Event.fromJson(json)).toList();
      },
    );
  }

  @override
  Future<Either<Failure, EventsHomeFeedResponse>> getHomeFeed() async {
    return _handleRequest<EventsHomeFeedResponse>(
          () async {
        final response = await _dioService.dio.get('/events/feed');
        return EventsHomeFeedResponse.fromJson(response.data);
      },
    );
  }

  @override
  Future<Either<Failure, List<Event>>> getEventsByCategory(String category) async {
    return _handleRequest<List<Event>>(
          () async {
        final response = await _dioService.dio.get(
          '/events/category',
          queryParameters: {'category': category},
        );
        final List<dynamic> data = response.data['events'];
        return data.map((json) => Event.fromJson(json)).toList();
      },
    );
  }
  @override
  Future<Either<Failure, Event>> getEventDetailsById(String id) async {
    return _handleRequest<Event>(
          () async {
        final response = await _dioService.dio.get(
          '/events/view/$id',
        );
        final Map<String, dynamic> data = response.data;
        return Event.fromJson(data);
      },
    );
  }

  Future<Either<Failure, T>> _handleRequest<T>(Future<T> Function() request) async {
    try {
      final result = await request();
      return right(result);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    }
  }

  Failure _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Failure('Connection timeout. Please try again.');
      case DioExceptionType.connectionError:
        return Failure('No internet connection.');
      default:
        return Failure('Something went wrong. Please try again.');
    }
  }


}

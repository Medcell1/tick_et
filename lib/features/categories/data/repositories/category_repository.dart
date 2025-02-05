import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/failure.dart';
import '../models/event_category.dart';

abstract class EventCategoryRepository {
  Future<Either<Failure, List<EventCategory>>> getAllCategories();
  Future<Either<Failure, EventCategory>> getCategoryById(String id);
  Future<Either<Failure, List<EventCategory>>> getFeaturedCategories();
}

const String eventUrl = '/events';

class EventCategoryRepositoryImpl implements EventCategoryRepository {
  final DioService _dioService;

  EventCategoryRepositoryImpl(this._dioService);

  @override
  Future<Either<Failure, List<EventCategory>>> getAllCategories() async {
    return _handleRequest<List<EventCategory>>(() async {
      final response = await _dioService.dio.get('$eventUrl/categories');
      final List<dynamic> data = response.data;
      return data.map((json) => EventCategory.fromJson(json)).toList();
    });
  }

  @override
  Future<Either<Failure, EventCategory>> getCategoryById(String id) async {
    return _handleRequest<EventCategory>(() async {
      final response = await _dioService.dio.get('$eventUrl/categories/$id');
      return EventCategory.fromJson(response.data);
    });
  }

  @override
  Future<Either<Failure, List<EventCategory>>> getFeaturedCategories() async {
    return _handleRequest<List<EventCategory>>(() async {
      final response = await _dioService.dio.get('$eventUrl/categories/featured');
      final List<dynamic> data = response.data['categories'];
      return data.map((json) => EventCategory.fromJson(json)).toList();
    });
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

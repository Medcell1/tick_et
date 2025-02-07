import 'package:get_it/get_it.dart';
import 'package:ticket_app_flutter/core/network/dio_client.dart';
import 'package:ticket_app_flutter/features/categories/data/repositories/category_repository.dart';
import 'package:ticket_app_flutter/features/checkout/data/repositories/checkout_repository.dart';

import '../../features/home/data/repositories/events_repository.dart';

final getIt = GetIt.instance;

void setUp() {
  getIt.registerSingleton<DioService>(DioService());
  getIt.registerLazySingleton<EventsRepositoryImpl>(
    () => EventsRepositoryImpl(getIt<DioService>()),
  );
  getIt.registerLazySingleton<EventCategoryRepositoryImpl>(
    () => EventCategoryRepositoryImpl(getIt<DioService>()),
  );  getIt.registerLazySingleton<CheckoutRepository>(
    () => CheckoutRepository(getIt<DioService>()),
  );
}

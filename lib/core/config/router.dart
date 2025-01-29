import 'package:go_router/go_router.dart';
import 'package:ticket_app_flutter/features/checkout/data/presentation/screens/checkout_screen.dart';
import 'package:ticket_app_flutter/features/events/data/presentation/screens/event_details_screen.dart';
import 'package:ticket_app_flutter/features/events/data/presentation/screens/event_list_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'events',
      builder: (context, state) => const EventListScreen(),
    ),
    GoRoute(
      path: '/eventDetail',
      name: 'event_detail',
      builder: (context, state) => const EventDetailsScreen(),
    ),
    GoRoute(
      path: '/checkout',
      name: 'checkout',
      builder: (context, state) => const CheckoutScreen(),
    ),
  ],
);

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app_flutter/features/categories/data/presentation/screens/categories_screen.dart';
import 'package:ticket_app_flutter/features/checkout/data/presentation/screens/checkout_screen.dart';

import 'package:ticket_app_flutter/features/see_more/presentation/screens/see_more_screen.dart';
import 'package:ticket_app_flutter/shared/extensions/page_transition_extension.dart';

import '../../features/home/data/presentation/screens/event_details_screen.dart';
import '../../features/home/data/presentation/screens/event_list_screen.dart';
import '../../features/home/data/providers/view_event_provider.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'events',
      builder: (context, state) => const EventListScreen(),
    ),
    GoRoute(
      path: '/events/:id',
      name: 'event_detail',
      pageBuilder: (context, state) {
        final eventId = state.pathParameters['id']!;
        return EventDetailsScreen(eventId: eventId, ).pageTransition(state: state);
      },
    ),
    GoRoute(
      path: '/checkout',
      name: 'checkout',
      pageBuilder: (context, state) => const CheckoutScreen().pageTransition(state: state),
    ),
    GoRoute(
      path: '/categories',
      name: 'categories',
      pageBuilder: (context, state) => const CategoriesScreen().pageTransition(state: state),

    ),
    GoRoute(
      path: '/trending',
      name: 'trending',
      pageBuilder: (context, state) => const SeeMoreScreen().pageTransition(state: state),

    ),
    GoRoute(
      path: '/nearme',
      name: 'near_me',
      pageBuilder: (context, state) => const SeeMoreScreen().pageTransition(state: state),

    ),
  ],
);



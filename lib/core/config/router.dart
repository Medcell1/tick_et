import 'package:go_router/go_router.dart';
import 'package:ticket_app_flutter/features/categories/data/presentation/screens/categories_screen.dart';
import 'package:ticket_app_flutter/features/checkout/data/presentation/screens/checkout_screen.dart';
import 'package:ticket_app_flutter/features/checkout/data/presentation/screens/status/failure_screen.dart';
import 'package:ticket_app_flutter/shared/extensions/page_transition_extension.dart';

import '../../features/checkout/data/presentation/screens/status/success_screen.dart';
import '../../features/checkout/data/providers/checkout_provider.dart';
import '../../features/home/data/models/event.dart';
import '../../features/home/data/presentation/screens/event_details_screen.dart';
import '../../features/home/data/presentation/screens/event_list_screen.dart';
import '../../features/see_more/data/presentation/screens/see_more_screen.dart';
import '../../shared/models/ticket_type.dart';

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
        return EventDetailsScreen(
          eventId: eventId,
        ).pageTransition(state: state);
      },
    ),
    GoRoute(
      path: '/checkout',
      name: 'checkout',
      pageBuilder: (context, state) {
        final status = state.uri.queryParameters['status'];
        final extra = state.extra as Map<String, dynamic>?;

        if (status == 'success') {
          final checkoutState = extra?['checkoutState'] as CheckoutState;
          print('idgaf===>${checkoutState.status.toString()}');
          return SuccessScreen(
            checkoutState: checkoutState,
          ).pageTransition(
            state: state,
          );
        } else if (status == 'failed') {
          final extra = state.extra as Map<String, dynamic>;
          final event = extra['event'] as Event;
          final ticketType = extra['ticketType'] as TicketType;
          return FailureScreen(
            event: event,
            ticketType: ticketType,
          ).pageTransition(state: state);
        }

        final eventId = state.uri.queryParameters['eventId']!;
        final eventJson = extra?['event'] as Map<String, dynamic>;
        final event = Event.fromJson(eventJson);
        final ticketTypeId = state.uri.queryParameters['ticketTypeId']!;
        final ticketTypeJson = extra?['ticketType'] as Map<String, dynamic>;
        final ticketType = TicketType.fromJson(ticketTypeJson);

        return CheckoutScreen(
          eventId: eventId,
          event: event,
          ticketTypeId: ticketTypeId,
          ticketType: ticketType,
        ).pageTransition(state: state);
      },
    ),
    GoRoute(
      path: '/categories',
      name: 'categories',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final selectedCategory = extra?['selectedCategory']!;
        return CategoriesScreen(
          selectedCategoryId: selectedCategory,
        ).pageTransition(
          state: state,
        );
      },
    ),
    GoRoute(
      path: '/trending',
      name: 'trending',
      pageBuilder: (context, state) {
        String currentPath =
            GoRouter.of(context).routeInformationProvider.value.uri.toString();
        bool isTrendingRoute = currentPath == "/trending";
        return SeeMoreScreen(
          isTrending: isTrendingRoute,
        ).pageTransition(state: state);
      },
    ),
    GoRoute(
      path: '/nearme',
      name: 'near_me',
      pageBuilder: (context, state) {
        String currentPath =
            GoRouter.of(context).routeInformationProvider.value.uri.toString();
        bool isTrendingRoute = currentPath == "/trending";
        return SeeMoreScreen(
          isTrending: isTrendingRoute,
        ).pageTransition(state: state);
      },
    ),
  ],
);

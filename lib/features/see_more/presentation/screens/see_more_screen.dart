import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_app_flutter/core/config/app_images.dart';
import '../../../../../shared/themes/typography.dart';
import '../../../../../shared/widgets/gradient_scaffold.dart';
import '../../../../main.dart';
import '../widgets/see_more_event_card.dart';

class SeeMoreScreen extends StatefulWidget {
  const SeeMoreScreen({super.key});

  @override
  _SeeMoreScreenState createState() => _SeeMoreScreenState();
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  @override
  Widget build(BuildContext context) {
    String currentPath =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();
    bool isTrendingRoute = currentPath == "/trending";
    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            isTrendingRoute ? "Trending" : "Vibes near me",
            style: AppTypography.headline.copyWith(fontSize: 17),
          ),
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const SeeMoreEventCard(
                      title: 'Music Festival',
                      organizer: 'Local Music Org',
                      location: 'City Park',
                      date: 'Aug 15, 2024',
                      price: '\$50',
                      image: splash,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

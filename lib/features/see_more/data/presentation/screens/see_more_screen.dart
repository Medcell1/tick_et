import 'package:skeletonizer/skeletonizer.dart';
import 'package:ticket_app_flutter/features/see_more/data/providers/see_more_provider.dart';

import '../../../../home/home.dart';
import '../widgets/see_more_event_card.dart';

class SeeMoreScreen extends StatefulWidget {
  final bool isTrending;
  const SeeMoreScreen({super.key, required this.isTrending});

  @override
  _SeeMoreScreenState createState() => _SeeMoreScreenState();
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<SeeMoreProvider>().loadSeeMore(widget.isTrending),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            widget.isTrending ? "Trending" : "Vibes near me",
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
        body: Consumer<SeeMoreProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Skeletonizer(
                      enabled: provider.isLoading,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.events.length,
                        itemBuilder: (context, index) {
                          final event = provider.events[index];
                          return SeeMoreEventCard(
                            event: event,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

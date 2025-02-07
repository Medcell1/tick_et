import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ticket_app_flutter/features/home/home.dart';
import 'package:ticket_app_flutter/shared/models/ticket_type.dart';
import 'package:ticket_app_flutter/shared/widgets/custom_cached_network_image.dart';

import '../../../../../home/data/models/event.dart';
import '../../../providers/checkout_provider.dart';

class FailureScreen extends StatelessWidget {
  final Event event;
  final TicketType ticketType;

  const FailureScreen(
      {super.key, required this.event, required this.ticketType});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 30,
                        ),
                        child: Column(
                          children: [
                            SvgIcon(
                              assetPath: error,
                              size: context.screenHeight * 0.08,
                              color: Colors.red,
                            ),
                            Text(
                              'Payment Failed!',
                              style: AppTypography.headline,
                            ),
                            Text(
                              'There was an error processing your payment.',
                              style: AppTypography.subtitle
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    event.mediaUrls[0],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event!.name,
                                  style: AppTypography.headline.copyWith(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  ticketType!.name,
                                  style: AppTypography.subtitle,
                                ),
                                Text(
                                  ticketType!.price.toString(),
                                  style: AppTypography.priceStyle
                                      .copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        20.spaceHeight(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xffF5D2D2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Error Details',
                                style: AppTypography.headline.copyWith(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'The payment could not be processed. This could be due to insufficient funds, network issues, or an expired card. Please try again or use a different payment method.',
                                style: AppTypography.subtitle.copyWith(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                20.spaceHeight(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Payment Failed',
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
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 0.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  margin: EdgeInsets.only(
                    left: context.screenWidth * 0.02,
                  ),
                  color: Colors.transparent,
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

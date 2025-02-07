import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lottie/lottie.dart';

import 'package:screenshot/screenshot.dart';
import 'package:ticket_app_flutter/core/config/app_animations.dart';
import 'package:ticket_app_flutter/core/utils/globals.dart';
import 'package:ticket_app_flutter/features/checkout/data/providers/checkout_provider.dart';
import 'package:ticket_app_flutter/features/home/home.dart';
import 'package:ticket_app_flutter/shared/extensions/date_time_extensions.dart';
import 'package:ticket_app_flutter/shared/widgets/custom_cached_network_image.dart';

import 'package:ticket_app_flutter/shared/widgets/widgets.dart';

class SuccessScreen extends StatefulWidget {
  final CheckoutState checkoutState;

  const SuccessScreen({super.key, required this.checkoutState});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final purchaseResponse = widget.checkoutState.purchaseResponse;
    final event =
        purchaseResponse?.ticket.event.fold(((id) => null), (event) => event);
    final ticket = purchaseResponse?.ticket.ticketType
        .fold((id) => null, (ticket) => ticket);
    final ticketType = purchaseResponse!.ticket.ticketType
        .fold((id) => '', (ticketType) => ticketType);
    Future<void> _captureAndSaveTicket() async {
      try {
        final Uint8List? imageBytes =
            await screenshotController.captureFromWidget(
          SingleChildScrollView(
            child: Material(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                                  event!.mediaUrls[0],
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
                                ticket!.name,
                                style: AppTypography.subtitle,
                              ),
                              Text(
                                'F${ticket!.price.toString()}',
                                style: AppTypography.priceStyle
                                    .copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      20.spaceHeight(),
                      Row(
                        children: [
                          const SvgIcon(
                            assetPath: calendar,
                            color: Colors.black,
                            size: 15,
                          ),
                          5.spaceWidth(),
                          Text(
                            Globals.formatDate(
                              event!.date,
                            ),
                            style: AppTypography.body.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          20.spaceWidth(),
                          const SvgIcon(
                            assetPath: clock,
                            color: Colors.black,
                            size: 15,
                          ),
                          5.spaceWidth(),
                          Text(
                            event.date.asFormattedTime,
                            style: AppTypography.body.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: CustomCachedNetworkImage(
                          imageUrl: purchaseResponse.qrCodeUrl,
                          fit: BoxFit.cover,
                          height: 200,
                          width: 200,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Ticket ID',
                        style: AppTypography.headline.copyWith(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        purchaseResponse.ticket.ticketNumber,
                        style: AppTypography.body.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Attendee',
                        style: AppTypography.headline.copyWith(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        purchaseResponse.ticket.issuedTo.name,
                        style: AppTypography.subtitle.copyWith(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        purchaseResponse.ticket.issuedTo.email,
                        style: AppTypography.subtitle.copyWith(
                          color: Colors.black,
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Text(
                        purchaseResponse.ticket.issuedTo.phone,
                        style: AppTypography.subtitle.copyWith(
                          color: Colors.black,
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          context: context,
          targetSize:
              Size(context.screenWidth * 0.9, context.screenHeight * 0.7),
          pixelRatio: 3.0,
        );

        if (imageBytes != null) {
          final result = await ImageGallerySaver.saveImage(
            imageBytes,
            name: 'Ticket_${DateTime.now().millisecondsSinceEpoch}',
            quality: 100,
          );

          if (mounted) {
            if (result['isSuccess']) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Ticket saved to gallery!',
                    style: AppTypography.body.copyWith(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'FAILED',
                    style: AppTypography.body.copyWith(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            }
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to save ticket: ${e.toString()}',
                style: AppTypography.body.copyWith(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }

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
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: context.screenHeight * 0.1,
                              child: Lottie.asset(
                                success,
                                repeat: false,
                              ),
                            ),
                            Text(
                              'Thank You!',
                              style: AppTypography.headline,
                            ),
                            Text(
                              'Your ticket has been confirmed.',
                              style: AppTypography.body,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white.withOpacity(0.1),
                                        Colors.white.withOpacity(0.2),
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
                                      vertical: 8,
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          const SvgIcon(
                                            assetPath: email,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                          8.spaceWidth(),
                                          Text(
                                            "Check your email - we've sent your ticket there too!",
                                            style: AppTypography.body.copyWith(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
                      mainAxisSize: MainAxisSize.min,
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
                                    event!.mediaUrls[0],
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
                                  ticket!.name,
                                  style: AppTypography.subtitle,
                                ),
                                Text(
                                  'F${ticket!.price.toString()}',
                                  style: AppTypography.priceStyle
                                      .copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        20.spaceHeight(),
                        Row(
                          children: [
                            const SvgIcon(
                              assetPath: calendar,
                              color: Colors.black,
                              size: 15,
                            ),
                            5.spaceWidth(),
                            Text(
                              Globals.formatDate(
                                event!.date,
                              ),
                              style: AppTypography.body.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            20.spaceWidth(),
                            const SvgIcon(
                              assetPath: clock,
                              color: Colors.black,
                              size: 15,
                            ),
                            5.spaceWidth(),
                            Text(
                              event.date.asFormattedTime,
                              style: AppTypography.body.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: CustomCachedNetworkImage(
                            imageUrl: purchaseResponse.qrCodeUrl,
                            fit: BoxFit.cover,
                            height: 200,
                            width: 200,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Ticket ID',
                          style: AppTypography.headline.copyWith(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          purchaseResponse.ticket.ticketNumber,
                          style: AppTypography.body.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Attendee',
                          style: AppTypography.headline.copyWith(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          purchaseResponse.ticket.issuedTo.name,
                          style: AppTypography.subtitle.copyWith(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          purchaseResponse.ticket.issuedTo.email,
                          style: AppTypography.subtitle.copyWith(
                            color: Colors.black,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Text(
                          purchaseResponse.ticket.issuedTo.phone,
                          style: AppTypography.subtitle.copyWith(
                            color: Colors.black,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                20.spaceHeight(),
                CustomButton(
                  onPressed: _captureAndSaveTicket,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SvgIcon(
                        assetPath: download,
                        color: Colors.white,
                      ),
                      8.spaceWidth(),
                      Text(
                        'Save Ticket',
                        style: AppTypography.headline,
                      ),
                    ],
                  ),
                ),
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
        'Payment Successful',
        style: AppTypography.headline.copyWith(fontSize: 17),
      ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
        child: GestureDetector(
          onTap: () => context.go('/'),
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

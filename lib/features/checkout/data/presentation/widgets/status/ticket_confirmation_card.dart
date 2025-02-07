import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:ticket_app_flutter/features/home/home.dart';
import 'dart:typed_data';


class TicketCard extends StatelessWidget {
  final ScreenshotController screenshotController;

  const TicketCard({
    super.key,
    required this.screenshotController,
  });

  Future<Uint8List?> captureTicket() async {
    return await screenshotController.captureFromWidget(
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
              // Event Details
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VR Gaming Tournament',
                        style: AppTypography.headline.copyWith(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Gamer Pass',
                        style: AppTypography.subtitle,
                      ),
                      Text(
                        'CFA15.99',
                        style: AppTypography.priceStyle.copyWith(fontSize: 12),
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
                    '15 Nov 2025',
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
                    '12:00',
                    style: AppTypography.body.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // QR Code
              Center(
                child: QrImageView(
                  data: 'VR-2025-1234',
                  version: QrVersions.auto,
                  size: 180,
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
                'VR-2025-1234',
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
                'Muhammed',
                style: AppTypography.subtitle.copyWith(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              Text(
                'adeolasoremi5@gmail.com',
                style: AppTypography.subtitle.copyWith(
                  color: Colors.black,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                ),
              ),
              Text(
                '+229',
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
      targetSize: const Size(1080, 1920),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
            // Event Details
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VR Gaming Tournament',
                      style: AppTypography.headline.copyWith(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Gamer Pass',
                      style: AppTypography.subtitle,
                    ),
                    Text(
                      'CFA15.99',
                      style: AppTypography.priceStyle.copyWith(fontSize: 12),
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
                  '15 Nov 2025',
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
                  '12:00',
                  style: AppTypography.body.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // QR Code
            Center(
              child: QrImageView(
                data: 'VR-2025-1234',
                version: QrVersions.auto,
                size: 180,
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
              'VR-2025-1234',
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
              'Muhammed',
              style: AppTypography.subtitle.copyWith(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            Text(
              'adeolasoremi5@gmail.com',
              style: AppTypography.subtitle.copyWith(
                color: Colors.black,
                fontSize: 12,
                decoration: TextDecoration.underline,
              ),
            ),
            Text(
              '+229',
              style: AppTypography.subtitle.copyWith(
                color: Colors.black,
                fontSize: 12,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


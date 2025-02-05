import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_app_flutter/core/config/app_icons.dart';
import 'package:ticket_app_flutter/shared/extensions/media_query_context_extension.dart';
import 'package:ticket_app_flutter/shared/extensions/sized_box_num_extension.dart';
import 'package:ticket_app_flutter/shared/themes/typography.dart';
import 'package:ticket_app_flutter/shared/widgets/custom_button.dart';
import 'package:ticket_app_flutter/shared/widgets/gradient_scaffold.dart';
import 'package:ticket_app_flutter/shared/widgets/svg_icon.dart';
import '../../../../../core/config/app_images.dart';
import '../../../../../shared/themes/colors.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  int? selectedTicketIndex;

  final List<TicketOption> ticketOptions = [
    TicketOption(
      title: 'Regular Access',
      description: 'Standard entry to all pool activities',
      price: 9.99,
    ),
    TicketOption(
      title: 'VIP Experience',
      description: 'Premium seating, complimentary drinks',
      price: 24.99,
    ),
    TicketOption(
      title: 'Cabana Package',
      description: 'Private cabana, full service, premium drinks',
      price: 49.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
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
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      color: Colors.transparent,
                      child: const SvgIcon(
                        assetPath: bookmark,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: '\$9.99',
                  child: Container(
                    width: double.infinity,
                    height: context.screenHeight * 0.35,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.darkGrey, width: 5),
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: AssetImage(splash),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                10.spaceHeight(),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: context.screenWidth * 0.2,
                    child: const Divider(
                      color: AppColors.primaryLight,
                      height: 5,
                      thickness: 4,
                    ),
                  ),
                ),
                20.spaceHeight(),
                Text(
                  'Splash & Chill',
                  style: AppTypography.headline.copyWith(
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Eagle King ent.',
                  style: AppTypography.subtitle
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                15.spaceHeight(),
                Text(
                  'Welcome to the most fun filled hangout. Brace yourself for an extraordinary experience. There will be swimming, BBQ, Snooker, etc...',
                  style: AppTypography.subtitle
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                20.spaceHeight(),
                _buildInfoRow(
                  context,
                  location,
                  'Venue',
                  'Stella Maris Hotel, Quatier Jak, Cotonou',
                ),
                15.spaceHeight(),
                _buildInfoRow(
                  context,
                  calendar,
                  'Date',
                  '22 December 2024',
                ),
                25.spaceHeight(),
                Text(
                  'Select Ticket Type',
                  style: AppTypography.headline.copyWith(
                    fontSize: 20,
                  ),
                ),
                15.spaceHeight(),
                ...ticketOptions.asMap().entries.map((entry) {
                  return _buildTicketOption(context, entry.key);
                }),
                20.spaceHeight(),
                CustomButton(
                  content: Text(
                    'BOOK NOW',
                    style: AppTypography.headline,
                  ),
                  onPressed: () => context.push(
                    '/checkout',
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

  Widget _buildInfoRow(
      BuildContext context, String iconPath, String label, String value) {
    return Row(
      children: [
        Container(
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
                  ),
                  color: Colors.transparent,
                  child: Center(
                    child: SvgIcon(
                      assetPath: iconPath,
                    ),
                  )),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.subtitle
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                value,
                style: AppTypography.body.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTicketOption(BuildContext context, int index) {
    final ticket = ticketOptions[index];
    final isSelected = selectedTicketIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTicketIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.15)
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? AppColors.accentPink
                      : Colors.white.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Radio(
                    value: index,
                    groupValue: selectedTicketIndex,
                    onChanged: (value) {
                      setState(() {
                        selectedTicketIndex = value as int;
                      });
                    },
                    activeColor: AppColors.accentPink,
                    fillColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return AppColors.accentPink;
                        }
                        return Colors.grey;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ticket.title,
                            style:
                                AppTypography.headline.copyWith(fontSize: 14)),
                        Text(
                          ticket.description,
                          style: AppTypography.subtitle,
                        ),
                      ],
                    ),
                  ),
                  Text('\$${ticket.price}',
                      style: AppTypography.headline.copyWith(
                        fontSize: 18,
                        color: AppColors.accentPink,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TicketOption {
  final String title;
  final String description;
  final double price;

  TicketOption({
    required this.title,
    required this.description,
    required this.price,
  });
}

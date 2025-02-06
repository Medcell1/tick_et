import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ticket_app_flutter/core/config/app_icons.dart';
import 'package:ticket_app_flutter/features/home/data/models/event.dart';
import 'package:ticket_app_flutter/shared/extensions/media_query_context_extension.dart';
import 'package:ticket_app_flutter/shared/extensions/sized_box_num_extension.dart';
import 'package:ticket_app_flutter/shared/themes/typography.dart';
import 'package:ticket_app_flutter/shared/widgets/custom_button.dart';
import 'package:ticket_app_flutter/shared/widgets/gradient_scaffold.dart';
import 'package:ticket_app_flutter/shared/widgets/svg_icon.dart';
import '../../../../../core/utils/globals.dart';
import '../../../../../shared/models/ticket_type.dart';
import '../../../../../shared/themes/colors.dart';
import '../../providers/view_event_provider.dart';

class EventDetailsScreen extends StatefulWidget {
  final String eventId;
  final Event? event;

  const EventDetailsScreen({super.key, required this.eventId, this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  int? selectedTicketIndex;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<ViewEventProvider>().loadEventDetails(widget.eventId));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewEventProvider>(
      builder: (context, provider, child) {
        final bool showLoading = provider.eventDetails == null;

        return GradientScaffold(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: _buildAppBar(context, provider),
            body: showLoading
                ? _buildLoadingContent(context)
                : provider.error != null
                    ? _buildErrorContent(provider.error!)
                    : _buildEventDetailsContent(provider.eventDetails!),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, ViewEventProvider provider) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      leading: _buildBackButton(context, provider),
      actions: [
        _buildBookmarkButton(context),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context, ViewEventProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
      child: GestureDetector(
        onTap: () {
          context.pop();
        },
        child: Container(
          margin: const EdgeInsets.only(left: 5),
          decoration: _buildGlassyButtonDecoration(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
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

  Widget _buildBookmarkButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        decoration: _buildGlassyButtonDecoration(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: const SvgIcon(
                assetPath: bookmark,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildGlassyButtonDecoration() {
    return BoxDecoration(
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
    );
  }

  Widget _buildLoadingContent(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShimmerContainer(
              height: context.screenHeight * 0.35,
              width: double.infinity,
              borderRadius: 16,
            ),
            10.spaceHeight(),
            Center(
              child: _buildShimmerContainer(
                height: 4,
                width: context.screenWidth * 0.2,
                borderRadius: 2,
              ),
            ),
            20.spaceHeight(),
            _buildShimmerContainer(
              height: 24,
              width: context.screenWidth * 0.7,
              borderRadius: 4,
            ),
            10.spaceHeight(),
            _buildShimmerContainer(
              height: 16,
              width: context.screenWidth * 0.5,
              borderRadius: 4,
            ),
            15.spaceHeight(),
            _buildShimmerContainer(
              height: 16,
              width: double.infinity,
              borderRadius: 4,
            ),
            20.spaceHeight(),
            _buildShimmerInfoRow(context),
            15.spaceHeight(),
            _buildShimmerInfoRow(context),
            25.spaceHeight(),
            _buildShimmerContainer(
              height: 24,
              width: context.screenWidth * 0.6,
              borderRadius: 4,
            ),
            15.spaceHeight(),
            ...List.generate(3, (index) => _buildShimmerTicketOption()),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerContainer({
    required double height,
    required double width,
    required double borderRadius,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.white.withOpacity(0.5),
      highlightColor: Colors.white.withOpacity(0.5),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  Widget _buildShimmerInfoRow(BuildContext context) {
    return Row(
      children: [
        _buildShimmerContainer(
          height: 40,
          width: 40,
          borderRadius: 10,
        ),
        12.spaceWidth(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShimmerContainer(
              height: 16,
              width: 80,
              borderRadius: 4,
            ),
            4.spaceHeight(),
            _buildShimmerContainer(
              height: 14,
              width: 120,
              borderRadius: 4,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildShimmerTicketOption() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Shimmer.fromColors(
        baseColor: Colors.white.withOpacity(0.4),
        highlightColor: Colors.white.withOpacity(0.4),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorContent(String errorMessage) {
    return Center(
      child: Text(
        errorMessage,
        style: AppTypography.headline.copyWith(color: Colors.red),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildEventDetailsContent(Event event) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: context.screenHeight * 0.35,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.darkGrey, width: 5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: event.mediaUrls[0],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.white.withOpacity(0.3),
                    highlightColor: Colors.white.withOpacity(0.6),
                    child: Container(
                      width: double.infinity,
                      height: context.screenHeight * 0.35,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
            10.spaceHeight(),
            Center(
              child: SizedBox(
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
              event.name,
              style: AppTypography.headline.copyWith(fontSize: 20),
            ),
            Text(
              event.owner,
              style:
                  AppTypography.subtitle.copyWith(fontWeight: FontWeight.bold),
            ),
            15.spaceHeight(),
            Text(
              event.description,
              style:
                  AppTypography.subtitle.copyWith(fontWeight: FontWeight.bold),
            ),
            20.spaceHeight(),
            _buildInfoRow(
              context,
              location,
              'Venue',
              event.location,
            ),
            15.spaceHeight(),
            _buildInfoRow(
              context,
              calendar,
              'Date',
              Globals.formatDate(event.date),
            ),
            25.spaceHeight(),
            Text(
              'Select Ticket Type',
              style: AppTypography.headline.copyWith(fontSize: 20),
            ),
            15.spaceHeight(),
            ...event.ticketTypes.asMap().entries.map((entry) {
              final ticketTypeEither = entry.value;
              return ticketTypeEither.fold(
                  (error) => Container(),
                  (ticketType) =>
                      _buildTicketOption(context, entry.key, ticketType));
            }),
            20.spaceHeight(),
            CustomButton(
                content: Text(
                  'BOOK NOW',
                  style: AppTypography.headline,
                ),
                onPressed: () {
                  selectedTicketIndex != null
                      ? context.push('/checkout')
                      : null;
                }),
            20.spaceHeight(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String iconPath,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Container(
          decoration: _buildGlassyButtonDecoration(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgIcon(assetPath: iconPath),
              ),
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

  Widget _buildTicketOption(
      BuildContext context, int index, TicketType ticket) {
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
                    ? Colors.white.withOpacity(0.05)
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
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ticket.name,
                          style: AppTypography.headline.copyWith(fontSize: 14),
                        ),
                        Text(
                          ticket.description,
                          style: AppTypography.subtitle,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${ticket.price}',
                    style: AppTypography.headline.copyWith(
                      fontSize: 18,
                      color: AppColors.accentPink,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

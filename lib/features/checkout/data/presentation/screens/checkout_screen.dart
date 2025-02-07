import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:ticket_app_flutter/features/checkout/data/providers/checkout_provider.dart';
import 'package:ticket_app_flutter/main.dart';
import 'package:ticket_app_flutter/shared/extensions/date_time_extensions.dart';
import 'package:ticket_app_flutter/shared/extensions/double_extensions.dart';
import 'package:ticket_app_flutter/shared/extensions/media_query_context_extension.dart';
import 'package:ticket_app_flutter/shared/extensions/sized_box_num_extension.dart';
import 'package:ticket_app_flutter/shared/models/ticket_type.dart';
import 'package:ticket_app_flutter/shared/themes/colors.dart';
import 'package:ticket_app_flutter/shared/widgets/widgets.dart';
import '../../../../../shared/constants/common_form_control_names.dart';
import '../../../../../shared/themes/typography.dart';
import '../../../../home/data/models/event.dart';
import '../../models/payment_transaction.dart';

class CheckoutScreen extends StatelessWidget {
  final String eventId;
  final Event event;
  final String ticketTypeId;
  final TicketType ticketType;

  const CheckoutScreen({
    super.key,
    required this.eventId,
    required this.event,
    required this.ticketTypeId,
    required this.ticketType,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutProvider>(
      builder: (context, checkoutProvider, child) {
        final checkoutState = checkoutProvider.state;

        return GradientScaffold(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: _buildAppBar(context),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ReactiveForm(
                        formGroup: checkoutProvider.form,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildEventDetails(context),
                            24.spaceHeight(),
                            _buildPersonalDetails(checkoutProvider),
                            24.spaceHeight(),
                            _buildPaymentMethods(checkoutProvider),
                            24.spaceHeight(),
                            Text(checkoutState.status.toString()),
                            _buildCheckoutButton(
                                context, checkoutProvider, checkoutState),
                            24.spaceHeight(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Checkout',
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

  Widget _buildEventDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 5,
            offset: Offset(3, 3),
          ),
        ],
        border: Border.all(color: const Color(0xFAFAFAFA)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: context.screenWidth * 0.225,
            height: context.screenHeight * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: CachedNetworkImageProvider(event.mediaUrls.first),
                fit: BoxFit.cover,
              ),
            ),
          ),
          16.spaceWidth(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.name,
                  style: AppTypography.headline.copyWith(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                4.spaceHeight(),
                Text(
                  ticketType.name,
                  style: AppTypography.subtitle,
                ),
                4.spaceHeight(),
                Text(
                  event.date.asFriendlyDateTime(),
                  style: AppTypography.subtitle,
                ),
                4.spaceHeight(),
                Text(
                  ticketType.price.asCurrencyFormat('XOF'),
                  style: AppTypography.priceStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalDetails(CheckoutProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Details',
          style: AppTypography.headline.copyWith(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        12.spaceHeight(),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.transparent,
                blurRadius: 5,
                offset: Offset(3, 3),
              ),
            ],
            border: Border.all(color: const Color(0xFAFAFAFA)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Name',
                style: AppTypography.headline.copyWith(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              10.spaceHeight(),
              const StyledTextField.noLabel(
                name: CommonFormControlNames.fullName,
                backgroundColor: Colors.transparent,
                outline: true,
                borderColor: Colors.white,
                hintColor: Colors.white,
                textColor: Colors.white,
              ),
              14.spaceHeight(),
              Text(
                'Email Address',
                style: AppTypography.headline.copyWith(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              10.spaceHeight(),
              const StyledTextField.noLabel(
                name: CommonFormControlNames.email,
                textCapitalization: TextCapitalization.none,
                backgroundColor: Colors.transparent,
                outline: true,
                borderColor: Colors.white,
                hintColor: Colors.white,
                textColor: Colors.white,
              ),
              14.spaceHeight(),
              Text(
                'Phone Number',
                style: AppTypography.headline.copyWith(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              10.spaceHeight(),
              PhoneNumberField(
                controller: provider.phoneNumberController,
                countryText: 'Country',
                cancelText: 'Cancel',
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods(CheckoutProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: AppTypography.headline.copyWith(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        16.spaceHeight(),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.transparent,
                blurRadius: 5,
                offset: Offset(3, 3),
              ),
            ],
            border: Border.all(color: const Color(0xFAFAFAFA)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildPaymentOption(provider, PaymentProvider.mtn),
              const Divider(color: Colors.white24),
              _buildPaymentOption(provider, PaymentProvider.moov),
              const Divider(color: Colors.white24),
              _buildPaymentOption(provider, PaymentProvider.celtiis),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(
    CheckoutProvider provider,
    PaymentProvider paymentProvider,
  ) {
    return RadioListTile<PaymentProvider>(
      title: Text(
        paymentProvider.name,
        style: const TextStyle(color: Colors.white),
      ),
      value: paymentProvider,
      groupValue: provider.selectedPaymentMethod,
      onChanged: (PaymentProvider? newValue) {
        provider.setPaymentMethod(newValue);
      },
      activeColor: AppColors.accentPink,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildCheckoutButton(
    BuildContext context,
    CheckoutProvider provider,
    CheckoutState checkoutState,
  ) {
    return CustomButton(
      isLoading: checkoutState.status == CheckoutStatus.loading,
      onPressed: provider.isFormValid
          ? () async {
              await provider.buyTicket(
                context: context,
                eventId: eventId,
                ticketTypeId: ticketTypeId,
                ticketPrice: ticketType.price,
                eventName: event.name,
                event: event,
                ticketType: ticketType,
              );
            }
          : null,
      content: Text(
        'CHECKOUT',
        style: AppTypography.headline,
      ),
    );
  }
}

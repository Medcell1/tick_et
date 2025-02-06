import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart'; // Import the package
import 'package:ticket_app_flutter/features/checkout/data/models/payment_transaction.dart';
import 'package:ticket_app_flutter/shared/extensions/date_time_extensions.dart';
import 'package:ticket_app_flutter/shared/extensions/double_extensions.dart';
import 'package:ticket_app_flutter/shared/extensions/media_query_context_extension.dart';
import 'package:ticket_app_flutter/shared/extensions/sized_box_num_extension.dart';
import 'package:ticket_app_flutter/shared/models/ticket_type.dart';
import 'package:ticket_app_flutter/shared/themes/colors.dart';
import 'package:ticket_app_flutter/shared/widgets/widgets.dart';

import '../../../../../shared/constants/common_form_control_names.dart';
import '../../../../../shared/constants/common_values.dart';
import '../../../../../shared/models/phone_country/src/phonenumber.dart';
import '../../../../../shared/themes/typography.dart';
import '../../../../home/data/models/event.dart';
import '../../models/ticket.dart';
import '../../models/ticket_owner.dart';

class CheckoutScreen extends StatefulWidget {
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
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late final FormGroup form;
  late final PhoneNumberController phoneNumberController;

  PaymentProvider? selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    phoneNumberController = PhoneNumberController(
      PhoneNumber.parse(CommonValues.defaultCountryDialCode),
    );
    form = FormGroup({
      CommonFormControlNames.fullName: FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(3),
        ],
      ),
      CommonFormControlNames.email: FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
    });

    form.control(CommonFormControlNames.fullName).value = 'Saint';
    form.control(CommonFormControlNames.email).value = 'mikkyboy2005@gmail.com';
    phoneNumberController.value = PhoneNumber.parse('+2290199249702');
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
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ReactiveForm(
                    formGroup: form, // Bind the form group
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            border: Border.all(
                              color: const Color(0xFAFAFAFA),
                            ),
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
                                    image: CachedNetworkImageProvider(
                                      widget.event.mediaUrls.first,
                                    ),
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
                                      widget.event.name,
                                      style: AppTypography.headline.copyWith(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    4.spaceHeight(),
                                    Text(
                                      widget.ticketType.name,
                                      style: AppTypography.subtitle,
                                    ),
                                    4.spaceHeight(),
                                    Text(
                                      widget.event.date.asFriendlyDateTime(),
                                      style: AppTypography.subtitle,
                                    ),
                                    4.spaceHeight(),
                                    Text(
                                      widget.ticketType.price
                                          .asCurrencyFormat('XOF'),
                                      style: AppTypography.priceStyle
                                          .copyWith(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        24.spaceHeight(),
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
                            border: Border.all(
                              color: const Color(0xFAFAFAFA),
                            ),
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
                              const StyledTextField(
                                name: CommonFormControlNames.fullName,
                                hintText: 'Full Name',
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
                              const StyledTextField(
                                name: CommonFormControlNames.email,
                                hintText: 'Email Address',
                                textCapitalization: TextCapitalization.none,
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
                                controller: phoneNumberController,
                                countryText: 'Country',
                                cancelText: 'Cancel',
                                backgroundColor: Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                        24.spaceHeight(),
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
                            border: Border.all(
                              color: const Color(0xFAFAFAFA),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              _buildPaymentOption(PaymentProvider.mtn),
                              const Divider(color: Colors.white24),
                              _buildPaymentOption(PaymentProvider.moov),
                              const Divider(color: Colors.white24),
                              _buildPaymentOption(PaymentProvider.celtiis),
                            ],
                          ),
                        ),
                        24.spaceHeight(),
                        ReactiveFormConsumer(
                          builder: (context, form, __) {
                            return CustomButton(
                              onPressed: (form.valid &&
                                      selectedPaymentMethod != null &&
                                      phoneNumberController.value != null)
                                  ? () {
                                      print('lol');
                                      final ticketRequest = TicketRequest(
                                        event: widget.eventId,
                                        ticketType: widget.ticketTypeId,
                                        issuedTo: TicketOwner(
                                          name: form
                                              .control(CommonFormControlNames
                                                  .fullName)
                                              .value,
                                          email: form
                                              .control(
                                                  CommonFormControlNames.email)
                                              .value,
                                          phone: phoneNumberController.value
                                              .toString(),
                                        ),
                                        issuedAt: DateTime.now(),
                                        ticketNumber: 'STR-00000000',
                                      );

                                      final paymentRequest = PaymentTransaction(
                                        gateway: PaymentGateway.sckaler,
                                        provider: selectedPaymentMethod!,
                                        country: Country.BJ,
                                        tel: phoneNumberController.value
                                            .toString(),
                                        amount: widget.ticketType.price,
                                        description:
                                            'BuyTicket ${widget.event.name}',
                                        currency: 'XOF',
                                        createdAt: DateTime.now(),
                                      );

                                      final TicketBuyRequest ticketBuyRequest =
                                          TicketBuyRequest(
                                        ticketRequest: ticketRequest,
                                        paymentTransaction: paymentRequest,
                                      );

                                      //
                                    }
                                  : null,
                              content: Text(
                                'CHECKOUT',
                                style: AppTypography.headline,
                              ),
                            );
                          },
                        ),
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
  }

  Widget _buildPaymentOption(PaymentProvider paymentProvider) {
    return RadioListTile<PaymentProvider>(
      title: Text(
        paymentProvider.name,
        style: const TextStyle(color: Colors.white),
      ),
      value: paymentProvider,
      groupValue: selectedPaymentMethod,
      onChanged: (PaymentProvider? newValue) {
        setState(() {
          selectedPaymentMethod = newValue;
        });
      },
      activeColor: AppColors.accentPink,
      contentPadding: EdgeInsets.zero,
    );
  }
}

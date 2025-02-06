import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_app_flutter/core/config/app_images.dart';
import 'package:ticket_app_flutter/shared/extensions/media_query_context_extension.dart';
import 'package:ticket_app_flutter/shared/extensions/sized_box_num_extension.dart';
import 'package:ticket_app_flutter/shared/themes/colors.dart';
import 'package:ticket_app_flutter/shared/widgets/custom_button.dart';
import 'package:ticket_app_flutter/shared/widgets/gradient_scaffold.dart';

import '../../../../../shared/themes/typography.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPaymentMethod = 'mtn';

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
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
                              color: AppColors.primaryLight.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: context.screenWidth * 0.2,
                                height: context.screenHeight * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                    image: AssetImage(splash),
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
                                      'Splash & Chill',
                                      style: AppTypography.headline.copyWith(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    4.spaceHeight(),
                                    Text(
                                      'VIP Experience',
                                      style: AppTypography.subtitle,
                                    ),
                                    4.spaceHeight(),
                                    Text(
                                      '22 December 2024',
                                      style: AppTypography.subtitle,
                                    ),
                                    4.spaceHeight(),
                                    Text(
                                      '\$24.99',
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
                              color: AppColors.primaryLight.withOpacity(0.2),
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
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'John Doe',
                                  hintStyle: AppTypography.subtitle,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: AppColors.primaryLight
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.all(12),
                                ),
                                style:
                                    AppTypography.body.copyWith(fontSize: 14),
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
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Email Address',
                                  hintStyle: AppTypography.subtitle,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: AppColors.primaryLight
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.all(12),
                                ),
                                style:
                                    AppTypography.body.copyWith(fontSize: 14),
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
                              color: AppColors.primaryLight.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              _buildPaymentOption('MTN Mobile Money', 'mtn'),
                              const Divider(color: Colors.white24),
                              _buildPaymentOption('Moov Money', 'moov'),
                              const Divider(color: Colors.white24),
                              _buildPaymentOption('Celtis', 'celtis'),
                            ],
                          ),
                        ),
                        24.spaceHeight(),
                        CustomButton(
                          onPressed: () {},
                          content: Text(
                            'Pay Now',
                            style: AppTypography.headline,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, String value) {
    return RadioListTile<String>(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      value: value,
      groupValue: selectedPaymentMethod,
      onChanged: (String? newValue) {
        setState(() {
          selectedPaymentMethod = newValue!;
        });
      },
      activeColor: AppColors.accentPink,
      contentPadding: EdgeInsets.zero,
    );
  }
}

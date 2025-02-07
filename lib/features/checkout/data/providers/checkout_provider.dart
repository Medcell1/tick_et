import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:ticket_app_flutter/core/config/locator.dart';
import 'package:ticket_app_flutter/features/checkout/data/models/payment_transaction.dart';
import 'package:ticket_app_flutter/features/checkout/data/models/ticket.dart';
import 'package:ticket_app_flutter/features/checkout/data/models/ticket_purchase_successful_response.dart';
import 'package:ticket_app_flutter/features/checkout/data/repositories/checkout_repository.dart';

import '../../../../shared/constants/common_form_control_names.dart';
import '../../../../shared/constants/common_values.dart';
import '../../../../shared/models/phone_country/src/phonenumber.dart';
import '../../../../shared/models/ticket_type.dart';
import '../../../../shared/widgets/phone_number_field/phone_number_field_controller.dart';
import '../../../home/data/models/event.dart';
import '../models/ticket_owner.dart';

enum CheckoutStatus { initial, loading, success, failure }

class CheckoutState {
  final CheckoutStatus status;
  final String? errorMessage;
  final TicketPurchaseSuccessfulResponse? purchaseResponse;
  final PaymentTransactionResponse? transactionResponse;

  CheckoutState({
    this.status = CheckoutStatus.initial,
    this.errorMessage,
    this.purchaseResponse,
    this.transactionResponse,
  });

  CheckoutState copyWith({
    CheckoutStatus? status,
    String? errorMessage,
    TicketPurchaseSuccessfulResponse? purchaseResponse,
    PaymentTransactionResponse? transactionResponse,
  }) {
    return CheckoutState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      purchaseResponse: purchaseResponse ?? this.purchaseResponse,
      transactionResponse: transactionResponse ?? this.transactionResponse,
    );
  }
}

class CheckoutProvider extends ChangeNotifier {
  bool isLoading = false;
  final CheckoutRepository _repository = getIt<CheckoutRepository>();
  CheckoutState _state = CheckoutState();
  late final FormGroup form;
  late final PhoneNumberController phoneNumberController;
  PaymentProvider? _selectedPaymentMethod;

  CheckoutProvider() {
    _initializeForm();
  }

  void _initializeForm() {
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
  }

  CheckoutState get state => _state;

  PaymentProvider? get selectedPaymentMethod => _selectedPaymentMethod;

  bool get isFormValid =>
      form.valid &&
      _selectedPaymentMethod != null &&
      phoneNumberController.value != null;

  void setPaymentMethod(PaymentProvider? method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  Future<void> buyTicket({
    required BuildContext context,
    required String eventId,
    required String ticketTypeId,
    required double ticketPrice,
    required String eventName,
    required Event event,
    required TicketType ticketType,
  }) async {
    try {
      _state = _state.copyWith(status: CheckoutStatus.loading);
      notifyListeners();

      final ticketRequest = TicketRequest(
        event: eventId,
        ticketType: ticketTypeId,
        issuedTo: TicketOwner(
          name: form.control(CommonFormControlNames.fullName).value,
          email: form.control(CommonFormControlNames.email).value,
          phone: phoneNumberController.value.toString().substring(1),
        ),
        issuedAt: DateTime.now(),
        ticketNumber: 'STR-00000000',
      );

      final paymentRequest = PaymentTransaction(
        gateway: PaymentGateway.sckaler,
        provider: _selectedPaymentMethod!,
        country: Country.BJ,
        tel: phoneNumberController.value.toString().substring(1),
        amount: ticketPrice,
        description: 'BuyTicket $eventName',
        currency: 'XOF',
        createdAt: DateTime.now(),
      );

      final ticketBuyRequest = TicketBuyRequest(
        ticketRequest: ticketRequest,
        paymentTransaction: paymentRequest,
      );

      final result = await _repository.buyTicket(ticketBuyRequest: ticketBuyRequest);

      result.fold(
            (paymentTransactionResponse) {
          _state = _state.copyWith(
            status: CheckoutStatus.failure,
            transactionResponse: paymentTransactionResponse,
            errorMessage: 'Payment transaction failed',
          );
          notifyListeners();

          context.pushNamed(
            'checkout',
            queryParameters: {'status': 'failed'},
            extra: {
              'event': event,
              'ticketType': ticketType,
            },
          );
        },
            (purchaseSuccessfulResponse) {
          _state = _state.copyWith(
            status: CheckoutStatus.success,
            purchaseResponse: purchaseSuccessfulResponse,
          );
          notifyListeners();

          context.pushNamed(
            'checkout',
            queryParameters: {'status': 'success'},
            extra: {'checkoutState': _state},
          );
        },
      );
    } catch (e) {
      _state = _state.copyWith(
        status: CheckoutStatus.failure,
        errorMessage: e.toString(),
      );
      notifyListeners();

      if (!context.mounted) return;
      context.pushNamed(
        'checkout',
        queryParameters: {'status': 'failed'},
        extra: {
          'event': event,
          'ticketType': ticketType,
        },
      );
    }
  void reset() {
    _state = CheckoutState();
    form.reset();
    _selectedPaymentMethod = null;
    phoneNumberController = PhoneNumberController(
      PhoneNumber.parse(CommonValues.defaultCountryDialCode),
    );
    notifyListeners();
  }

}}

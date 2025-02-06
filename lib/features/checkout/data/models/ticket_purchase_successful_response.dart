import 'package:ticket_app_flutter/features/checkout/data/models/payment_transaction.dart';
import 'package:ticket_app_flutter/features/checkout/data/models/ticket.dart';

class TicketPurchaseSuccessfulResponse {
  final String message;
  final Ticket ticket;
  final PaymentTransactionResponse paymentInfo;
  final String emailInfo;

  TicketPurchaseSuccessfulResponse({
    required this.message,
    required this.ticket,
    required this.paymentInfo,
    required this.emailInfo,
  });

  factory TicketPurchaseSuccessfulResponse.fromJson(Map<String, dynamic> json) {
    return TicketPurchaseSuccessfulResponse(
      message: json['message'] as String,
      ticket: Ticket.fromJson(json['ticket'] as Map<String, dynamic>),
      paymentInfo: PaymentTransactionResponse.fromJson(
          json['paymentInfo'] as Map<String, dynamic>),
      emailInfo: json['emailInfo'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'ticket': ticket.toJson(),
      'paymentInfo': paymentInfo.toJson(),
      'emailInfo': emailInfo,
    };
  }

  TicketPurchaseSuccessfulResponse copyWith({
    String? message,
    Ticket? ticket,
    PaymentTransactionResponse? paymentInfo,
    String? emailInfo,
  }) {
    return TicketPurchaseSuccessfulResponse(
      message: message ?? this.message,
      ticket: ticket ?? this.ticket,
      paymentInfo: paymentInfo ?? this.paymentInfo,
      emailInfo: emailInfo ?? this.emailInfo,
    );
  }
}

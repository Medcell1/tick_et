import 'package:dartz/dartz.dart';
import 'package:ticket_app_flutter/features/checkout/data/models/payment_transaction.dart';
import 'package:ticket_app_flutter/features/checkout/data/models/ticket_owner.dart';
import 'package:ticket_app_flutter/shared/models/ticket_type.dart';

import '../../../../core/utils/globals.dart';
import '../../../home/data/models/event.dart';

class Ticket {
  final String id;
  Either<String, Event> event;
  Either<String, TicketType> ticketType;
  TicketOwner issuedTo;
  DateTime issuedAt;
  String ticketNumber;

  Ticket({
    required this.id,
    required this.event,
    required this.ticketType,
    required this.issuedTo,
    required this.issuedAt,
    required this.ticketNumber,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['_id'] as String,
      event: Globals.parseEither<Event>(json['event'], Event.fromJson),
      ticketType: Globals.parseEither<TicketType>(
          json['ticketType'], TicketType.fromJson),
      issuedTo: TicketOwner.fromJson(json['issuedTo'] as Map<String, dynamic>),
      issuedAt: json['issuedAt'] != null
          ? DateTime.parse(json['issuedAt'] as String)
          : DateTime.now(),
      ticketNumber: json['ticketNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'event': event.fold((l) => l, (r) => r),
      'ticketType': ticketType.fold((l) => l, (r) => r),
      'issuedTo': issuedTo.toJson(),
      'issuedAt': issuedAt.toString(),
      'ticketNumber': ticketNumber,
    };
  }
}

class TicketRequest {
  String event;
  String ticketType;
  TicketOwner issuedTo;
  DateTime issuedAt;
  String ticketNumber;

  TicketRequest({
    required this.event,
    required this.ticketType,
    required this.issuedTo,
    required this.issuedAt,
    required this.ticketNumber,
  });

  factory TicketRequest.fromJson(Map<String, dynamic> json) {
    return TicketRequest(
      event: json['event'] as String,
      ticketType: json['ticketType'] as String,
      issuedTo: TicketOwner.fromJson(json['issuedTo'] as Map<String, dynamic>),
      issuedAt: json['issuedAt'] != null
          ? DateTime.parse(json['issuedAt'] as String)
          : DateTime.now(),
      ticketNumber: json['ticketNumber'] == null
          ? 'STR-00000000'
          : json['ticketNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event': event,
      'ticketType': ticketType,
      'issuedTo': issuedTo.toJson(),
      'issuedAt': issuedAt.toString(),
      'ticketNumber': ticketNumber,
    };
  }

  TicketRequest copyWith({
    String? event,
    String? ticketType,
    TicketOwner? issuedTo,
    DateTime? issuedAt,
    String? ticketNumber,
  }) {
    return TicketRequest(
      event: event ?? this.event,
      ticketType: ticketType ?? this.ticketType,
      issuedTo: issuedTo ?? this.issuedTo,
      issuedAt: issuedAt ?? this.issuedAt,
      ticketNumber: ticketNumber ?? this.ticketNumber,
    );
  }

  factory TicketRequest.sampleData() {
    return TicketRequest(
      event: 'Sample Event',
      ticketType: '67a2826a02d7d945dd000000',
      issuedTo: TicketOwner.sampleData(),
      issuedAt: DateTime.now(),
      ticketNumber: 'STR-00000000',
    );
  }
}

class TicketBuyRequest {
  TicketRequest ticketRequest;
  PaymentTransaction paymentTransaction;

  TicketBuyRequest({
    required this.ticketRequest,
    required this.paymentTransaction,
  });

  factory TicketBuyRequest.fromJson(Map<String, dynamic> json) {
    return TicketBuyRequest(
      ticketRequest: TicketRequest.fromJson(
        json['ticketRequest'] as Map<String, dynamic>,
      ),
      paymentTransaction: PaymentTransaction.fromJson(
        json['paymentRequest'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketRequest': ticketRequest.toJson(),
      'paymentRequest': paymentTransaction.toJson(),
    };
  }

  TicketBuyRequest copyWith({
    TicketRequest? ticketRequest,
    PaymentTransaction? paymentTransaction,
  }) {
    return TicketBuyRequest(
      ticketRequest: ticketRequest ?? this.ticketRequest,
      paymentTransaction: paymentTransaction ?? this.paymentTransaction,
    );
  }

  factory TicketBuyRequest.sampleData() {
    return TicketBuyRequest(
      ticketRequest: TicketRequest.sampleData(),
      paymentTransaction: PaymentTransaction.sampleData(),
    );
  }
}

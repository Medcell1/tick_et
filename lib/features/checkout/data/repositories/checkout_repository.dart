import 'package:dartz/dartz.dart';
import 'package:ticket_app_flutter/core/network/dio_client.dart';

import '../models/payment_transaction.dart';
import '../models/ticket.dart';
import '../models/ticket_purchase_successful_response.dart';

class CheckoutRepository {
  final DioService _dioService;

  CheckoutRepository(this._dioService);

  Future<Either<PaymentTransactionResponse, TicketPurchaseSuccessfulResponse>>
  buyTicket({
    required TicketBuyRequest ticketBuyRequest,
  }) async {
    try {
      final response = await _dioService.dio.post(
        '/tickets/buy',
        data: ticketBuyRequest.toJson(),
      );
      print('coddddeeeeee===>${response.statusCode}');
      if (response.statusCode == 201) {
        print('====> Ticket purchase successful <====');
        final data = response.data as Map<String, dynamic>;
        final purchaseResponse =
        TicketPurchaseSuccessfulResponse.fromJson(data);
        return Right(purchaseResponse);
      } else {
        print('====> Ticket purchase failed <====');
        final data = response.data as Map<String, dynamic>;
        final transactionResponse = PaymentTransactionResponse.fromJson(data);
        return Left(transactionResponse);
      }
    } catch (e) {
      print(e);
      return Left(
        PaymentTransactionResponse.sample(),
      );
    }
  }
}

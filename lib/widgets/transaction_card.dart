import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import 'package:play_together_mobile/models/transaction_model.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class TransactionCard extends StatefulWidget {
  final TransactionModel transactionModel;
  const TransactionCard({Key? key, required this.transactionModel})
      : super(key: key);

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    String date =
        DateFormat('dd/MM/yyyy').format(widget.transactionModel.dateTime);
    String startTime =
        DateFormat('hh:mm a').format(widget.transactionModel.dateTime);
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  createTransactionTitle(widget.transactionModel.type,
                      widget.transactionModel.operation),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    date + ', ' + startTime,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              convertOperation(widget.transactionModel.operation),
            ],
          ),
          const Divider(
            thickness: 0.1,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  Widget createTransactionTitle(String type, String operation) {
    if (type == 'Deposit') {
      return Text(
        'Nạp tiền từ MOMO',
        style: TextStyle(fontSize: 18),
      );
    }

    if (type == 'Withdraw') {
      return Text(
        'Rút tiền vào MOMO',
        style: TextStyle(fontSize: 18),
      );
    }

    if (type == 'Order - Refund') {
      return Text(
        'Hoàn tiền từ giao dịch',
        style: TextStyle(fontSize: 18),
      );
    }

    if (type == 'Order' && operation == '+') {
      return Text(
        'Nhận tiền từ giao dịch',
        style: TextStyle(fontSize: 18),
      );
    }

    if (type == 'Order' && operation == '-') {
      return Text(
        'Trừ tiền từ giao dịch',
        style: TextStyle(fontSize: 18),
      );
    }

    if (type == 'Donate') {
      return Text(
        'Gửi từ thiện',
        style: TextStyle(fontSize: 18),
      );
    }

    return Text(
      type,
      style: TextStyle(fontSize: 15, color: Colors.black),
    );
  }

  Widget convertOperation(String operation) {
    if (operation == '-') {
      return Text(
        '− ' + widget.transactionModel.money.toStringAsFixed(0).toVND() + 'đ',
        style: const TextStyle(fontSize: 18, color: Colors.black),
      );
    } else {
      return Text(
        '+ ' + widget.transactionModel.money.toStringAsFixed(0).toVND() + 'đ',
        style: const TextStyle(fontSize: 18, color: Colors.black),
      );
    }
  }
}

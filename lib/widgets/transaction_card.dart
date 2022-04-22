import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/transaction_model.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

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
    String date = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(widget.transactionModel.createdDate));
    String startTime = DateFormat('hh:mm a')
        .format(DateTime.parse(widget.transactionModel.createdDate));
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
                  createTransactionTitle(
                      widget.transactionModel.typeOfTransaction,
                      widget.transactionModel.operation),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    date + ', ' + startTime,
                    style: GoogleFonts.montserrat(
                        fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  convertOperation(widget.transactionModel.operation),
                ],
              ),
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
        style: GoogleFonts.montserrat(fontSize: 18),
      );
    }

    if (type == 'Withdraw') {
      return Text(
        'Rút tiền về MOMO',
        style: GoogleFonts.montserrat(fontSize: 18),
      );
    }

    if (type == 'Order - Refund') {
      return Text(
        'Hoàn tiền từ giao dịch',
        style: GoogleFonts.montserrat(fontSize: 18),
      );
    }

    if (type == 'Order' && operation == 'Add') {
      return Text(
        'Nhận tiền từ giao dịch',
        style: GoogleFonts.montserrat(fontSize: 18),
      );
    }

    if (type == 'Order' && operation == 'Sub') {
      return Text(
        'Trừ tiền từ giao dịch',
        style: GoogleFonts.montserrat(fontSize: 18),
      );
    }

    if (type == 'Donate') {
      return Text(
        'Gửi từ thiện',
        style: GoogleFonts.montserrat(fontSize: 18),
      );
    }

    return Text(
      type,
      style: GoogleFonts.montserrat(fontSize: 15, color: Colors.black),
    );
  }

  Widget convertOperation(String operation) {
    if (operation == 'Sub') {
      return Text(
        '−' + widget.transactionModel.money.toStringAsFixed(0).toVND(),
        style: GoogleFonts.montserrat(
            fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
      );
    } else {
      return Text(
        '+' + widget.transactionModel.money.toStringAsFixed(0).toVND(),
        style: GoogleFonts.montserrat(
            fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/transaction_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/transaction_service.dart';
import 'package:play_together_mobile/widgets/transaction_card.dart';

class TransactionPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;
  const TransactionPage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool checkDeposit = false;
  bool checkWithdraw = false;
  bool checkDonate = false;
  bool checkIncome = false; //income tính luôn cái vụ refund - thối tiền
  bool checkOutcome = false;
  bool checkAll = true;
  List<TransactionModel>? listAllTransaction;
  List<TransactionModel>? listDepositTransaction;
  List<TransactionModel>? listWithdrawTransaction;
  List<TransactionModel>? listIncomeTransaction;
  List<TransactionModel>? listOutcomeTransaction;
  List<TransactionModel>? listDonateTransaction;
  bool checkExistTransaction = false;
  bool checkExistDeposit = false;
  bool checkExistWithdraw = false;
  bool checkExistDonate = false;
  bool checkExistIncome = false; //income tính luôn cái vụ refund - thối tiền
  bool checkExistOutcome = false;
  String type = '';
  String operation = '';

  Future loadListAllTransaction() {
    listAllTransaction ??= [];
    Future<List<TransactionModel>?> listAllTransactionModelFuture =
        TransactionService()
            .getAllTransaction(type, operation, widget.tokenModel.message);
    listAllTransactionModelFuture.then((_transactionList) {
      listAllTransaction = _transactionList;
    });
    return listAllTransactionModelFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: FlatButton(
              child: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Lịch sử giao dịch',
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          GridView.count(
              shrinkWrap: true,
              childAspectRatio: (120 / 50),
              crossAxisCount: 3,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff8980FF),
                      ),
                      color: checkAll
                          ? Color(0xff8980FF).withOpacity(1)
                          : Color(0xff8980FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (!checkAll) {
                            checkAll = true;
                            checkDeposit = false;
                            checkDonate = false;
                            checkIncome = false;
                            checkOutcome = false;
                            checkWithdraw = false;
                            type = '';
                            operation = '';
                          }
                        });
                      },
                      child: Text(
                        'Tất cả',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff8980FF),
                      ),
                      color: checkIncome
                          ? Color(0xff8980FF).withOpacity(1)
                          : Color(0xff8980FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          setState(() {
                            if (!checkIncome) {
                              checkAll = false;
                              checkDeposit = false;
                              checkDonate = false;
                              checkIncome = true;
                              checkOutcome = false;
                              checkWithdraw = false;
                              type = 'Order';
                              operation = '+';
                            } else {
                              type = '';
                              operation = '';
                              checkAll = true;
                              checkDeposit = false;
                              checkDonate = false;
                              checkIncome = false;
                              checkOutcome = false;
                              checkWithdraw = false;
                            }
                          });
                        });
                      },
                      child: Text(
                        'Nhận tiền',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff8980FF),
                      ),
                      color: checkOutcome
                          ? Color(0xff8980FF).withOpacity(1)
                          : Color(0xff8980FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (!checkOutcome) {
                            checkAll = false;
                            checkDeposit = false;
                            checkDonate = false;
                            checkIncome = false;
                            checkOutcome = true;
                            checkWithdraw = false;
                            type = 'Order';
                            operation = '-';
                          } else {
                            type = '';
                            operation = '';
                            checkAll = true;
                            checkDeposit = false;
                            checkDonate = false;
                            checkIncome = false;
                            checkOutcome = false;
                            checkWithdraw = false;
                          }
                        });
                      },
                      child: Text(
                        'Trừ tiền',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff8980FF),
                      ),
                      color: checkDeposit
                          ? Color(0xff8980FF).withOpacity(1)
                          : Color(0xff8980FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (!checkDeposit) {
                            checkAll = false;
                            checkDeposit = true;
                            checkDonate = false;
                            checkIncome = false;
                            checkOutcome = false;
                            checkWithdraw = false;
                            type = 'Deposit';
                            operation = '';
                          } else {
                            type = '';
                            operation = '';
                            checkAll = true;
                            checkDeposit = false;
                            checkDonate = false;
                            checkIncome = false;
                            checkOutcome = false;
                            checkWithdraw = false;
                          }
                        });
                      },
                      child: Text(
                        'Nạp tiền',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff8980FF),
                      ),
                      color: checkWithdraw
                          ? Color(0xff8980FF).withOpacity(1)
                          : Color(0xff8980FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (!checkWithdraw) {
                            checkAll = false;
                            checkDeposit = false;
                            checkDonate = false;
                            checkIncome = false;
                            checkOutcome = false;
                            checkWithdraw = true;
                            type = 'Withdraw';
                            operation = '';
                          } else {
                            type = '';
                            operation = '';
                            checkAll = true;
                            checkDeposit = false;
                            checkDonate = false;
                            checkIncome = false;
                            checkOutcome = false;
                            checkWithdraw = false;
                          }
                        });
                      },
                      child: Text(
                        'Rút tiền',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff8980FF),
                      ),
                      color: checkDonate
                          ? Color(0xff8980FF).withOpacity(1)
                          : Color(0xff8980FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (!checkDonate) {
                            checkAll = false;
                            checkDeposit = false;
                            checkDonate = true;
                            checkIncome = false;
                            checkOutcome = false;
                            checkWithdraw = false;
                            type = 'Donate';
                            operation = '';
                          } else {
                            type = '';
                            operation = '';
                            checkAll = true;
                            checkDeposit = false;
                            checkDonate = false;
                            checkIncome = false;
                            checkOutcome = false;
                            checkWithdraw = false;
                          }
                        });
                      },
                      child: Text(
                        'Donate',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ]),
          Divider(
            indent: 10,
            endIndent: 10,
            thickness: 1,
          ),
          SingleChildScrollView(
              child: FutureBuilder(
                  future: loadListAllTransaction(),
                  builder: (context, snapshot) {
                    if (listAllTransaction!.length == 0) {
                      checkExistTransaction = true;
                    } else {
                      checkExistTransaction = false;
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Column(
                            children: List.generate(
                                listAllTransaction == null
                                    ? 0
                                    : listAllTransaction!.length,
                                (index) => buildListTransaction(
                                    listAllTransaction![index])),
                          ),
                          Visibility(
                              visible: checkExistTransaction,
                              child: Text('Không có dữ liệu'))
                        ],
                      ),
                    );
                  })),
        ],
      )),
    );
  }

  Widget buildListTransaction(TransactionModel model) =>
      TransactionCard(transactionModel: model);
}

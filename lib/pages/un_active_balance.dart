import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_balance_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/personal_page.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:intl/intl.dart';

class UnActiveBalancePage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const UnActiveBalancePage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  State<UnActiveBalancePage> createState() => _UnActiveBalancePageState();
}

class _UnActiveBalancePageState extends State<UnActiveBalancePage> {
  List<UnActiveBalanceModel> listUnActiveBalance = [];

  Future getAllUnActiveBalance() {
    Future<ResponseListModel<UnActiveBalanceModel>?>
        getAllUnActiveBalanceFuture =
        UserService().getListUnActiveBalance(widget.tokenModel.message);
    getAllUnActiveBalanceFuture.then((value) {
      if (value != null) {
        listUnActiveBalance = value.content;
      }
    });
    return getAllUnActiveBalanceFuture;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllUnActiveBalance(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 1,
                leading: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextButton(
                    style: TextButton.styleFrom(primary: Colors.black),
                    child: const Icon(
                      Icons.arrow_back_ios,
                    ),
                    onPressed: () {
                      Future<ResponseModel<UserBalanceModel>?>
                          getUserBalanceFuture = UserService().getUserBalance(
                              widget.userModel.id, widget.tokenModel.message);
                      getUserBalanceFuture.then((value) {
                        if (value != null) {
                          helper.pushInto(
                              context,
                              PersonalPage(
                                tokenModel: widget.tokenModel,
                                userModel: widget.userModel,
                                activeBalance: value.content.activeBalance,
                                balance: value.content.balance,
                              ),
                              false);
                        }
                      });
                    },
                  ),
                ),
                centerTitle: true,
                title: Text(
                  'Số dư khả dụng',
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: buildListEmpty(listUnActiveBalance),
            )),
          );
        });
  }

  Widget buildUnActive(UnActiveBalanceModel unActiveBalanceModel) {
    String date = "";
    String time = "";
    date = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(unActiveBalanceModel.dateActive));
    time = DateFormat('hh:mm a')
        .format(DateTime.parse(unActiveBalanceModel.dateActive));
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                    '+ ' +
                        unActiveBalanceModel.money.toStringAsFixed(0).toVND(),
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                    )),
                const Spacer(),
                const Text(
                  'Chưa xử lý',
                  style: TextStyle(color: Colors.amber),
                ),
              ],
            ),
            Text(
              date + ', ' + time,
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ]),
    );
  }

  Widget buildListEmpty(List<UnActiveBalanceModel> listUnActive) {
    if (listUnActive.isNotEmpty) {
      return Column(
          children: List.generate(listUnActive.length,
              (index) => buildUnActive(listUnActive[index])));
    } else {
      return Container(
        alignment: Alignment.center,
        child: Text('Không có dữ liệu',
            style: GoogleFonts.montserrat(fontSize: 15)),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/transaction_page.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;

class DepositPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;
  const DepositPage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  late MomoVn _momoPay;
  late PaymentResponse _momoPaymentResult;
  late String _paymentStatus;

  final displayController = TextEditingController();
  String money = "";
  String message = "";
  double convertMoney = 0;
  var formatter = NumberFormat('###,###,###');

  @override
  void initState() {
    super.initState();
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _paymentStatus = "";
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {});
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
            title: Text(
              'Thanh toán qua MOMO',
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  width: 350,
                  child: TextField(
                    inputFormatters: [ThousandsFormatter()],
                    controller: displayController,
                    onChanged: (value) {
                      setState(() {
                        money = value;
                        print(money);
                      });
                    },
                    style: GoogleFonts.montserrat(fontSize: 20),
                    decoration: InputDecoration(
                        counter: Container(),
                        hintText: " Nhập số tiền",
                        hintStyle: GoogleFonts.montserrat()),
                    maxLength: 11,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Text('đ',
                    style: GoogleFonts.montserrat(
                        fontSize: 15, color: Colors.black)),
              ],
            ),
          ],
        )),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: AcceptProfileButton(
                  text: 'Nạp tiền',
                  onPress: () async {
                    if (money == null || money.isEmpty || money == "") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Vui lòng nhập số tiền!"),
                      ));
                    } else {
                      money = displayController.text.replaceAll(",", "");
                      convertMoney = double.parse(money);
                      MomoPaymentInfo options = MomoPaymentInfo(
                          merchantName: "Play Together",
                          appScheme:
                              "MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAhy6gKyTqR",
                          merchantCode: 'MOMOVLRE20220224',
                          partnerCode: 'MOMOVLRE20220224',
                          amount: convertMoney.round(),
                          orderId:
                              'MOMOVLRE20220224' + DateTime.now().toString(),
                          orderLabel: 'Nạp tiền vào app Play Together',
                          merchantNameLabel: "NẠP TIỀN VÀO APP PLAY TOGETHER",
                          fee: 0,
                          description: 'Nạp tiền Play Together',
                          username: '',
                          partner: 'merchant',
                          extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
                          isTestMode: true);
                      try {
                        _momoPay.open(options);
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    }
                  })),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _momoPay.clear();
  }

  void _setState() {
    _paymentStatus = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess == true) {
      money = money.replaceAll(",", "");
      convertMoney = double.parse(money);
      DepositModel depositModel = DepositModel(
          money: convertMoney,
          momoTransactionId: _momoPaymentResult.token.toString());
      Future<bool?> makeDonateFuture =
          UserService().depositMoney(widget.tokenModel.message, depositModel);
      makeDonateFuture.then((_depositMoney) {
        if (_depositMoney == true) {
          helper.pushInto(
              context,
              TransactionPage(
                tokenModel: widget.tokenModel,
                userModel: widget.userModel,
              ),
              true);
        }
      });
      print(_momoPaymentResult.status.toString() + "Status");
      print(_momoPaymentResult.extra.toString() + "Extra");
      print(_momoPaymentResult.isSuccess.toString() + "isSuccess");
      print(_momoPaymentResult.message.toString() + "message");
      print(_momoPaymentResult.phoneNumber.toString() + "phoneNumber");
      print(_momoPaymentResult.token.toString() + "token");
      _paymentStatus += "\nTình trạng: Thành công.";
      _paymentStatus +=
          "\nSố điện thoại: " + _momoPaymentResult.phoneNumber.toString();
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra!;
      _paymentStatus += "\nToken: " + _momoPaymentResult.token.toString();
    } else {
      _paymentStatus += "\nTình trạng: Thất bại.";
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra.toString();
      _paymentStatus += "\nMã lỗi: " + _momoPaymentResult.status.toString();
    }
  }

  void _handlePaymentSuccess(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(
        msg: "NẠP TIỀN THÀNH CÔNG",
        textColor: Colors.white,
        backgroundColor: const Color.fromRGBO(137, 128, 255, 1),
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(
        msg: "NẠP TIỀN THẤT BẠI",
        textColor: Colors.white,
        backgroundColor: const Color.fromRGBO(137, 128, 255, 1),
        toastLength: Toast.LENGTH_SHORT);
  }
}

import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({Key? key}) : super(key: key);

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
            title: const Text(
              'Thanh toán qua MOMO',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
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
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        counter: Container(), hintText: " Nhập số tiền"),
                    maxLength: 11,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Text('đ', style: TextStyle(fontSize: 15, color: Colors.black)),
              ],
            ),
            Row(
              children: [
                Text(_paymentStatus.isEmpty
                    ? "CHƯA THANH TOÁN"
                    : _paymentStatus),
              ],
            )
          ],
        )),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: AcceptProfileButton(
                  text: 'Nạp tiền',
                  onPress: () async {
                    if (money.length < 2) {
                      print("Không đủ điều kiện");
                    } else {
                      money = displayController.text.replaceAll(",", "");
                      convertMoney = double.parse(money);
                      print("Đủ điều kiện: " + convertMoney.toString());
                      print(convertMoney.round());
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
        msg: "THÀNH CÔNG: " + response.phoneNumber.toString(),
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(
        msg: "THẤT BẠI: " + response.message.toString(),
        toastLength: Toast.LENGTH_SHORT);
  }
}

import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/report_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/history_page.dart';
import 'package:play_together_mobile/services/report_service.dart';
import 'package:play_together_mobile/widgets/second_main_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;

class ReportPage extends StatefulWidget {
  final OrderModel? orderModel;
  final UserModel? userModel;
  final TokenModel tokenModel;

  const ReportPage(
      {Key? key, this.orderModel, this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String reportMessage = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: FlatButton(
              child: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: const Text(
            'Tố cáo',
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
              height: 20,
            ),
            SizedBox(
              height: 150,
              width: 150,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    widget.orderModel!.user!.id == widget.userModel!.id
                        ? widget.orderModel!.user!.avatar
                        : widget.orderModel!.toUser!.avatar),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.orderModel!.user!.id == widget.userModel!.id
                  ? widget.orderModel!.user!.name
                  : widget.orderModel!.toUser!.name,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 25, 10, 20),
              child: Container(
                height: 300,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  maxLength: 1000,
                  onChanged: (newValue) => reportMessage = newValue,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                    counterText: "",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: "Nhập lý do tố cáo của bạn...",
                    hintText: "Nhập vào lý do tố cáo",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: SecondMainButton(
                text: 'Gửi',
                onpress: () {
                  ReportCreateModel reportCreateModel = ReportCreateModel(
                      reportMessage:
                          reportMessage != "" ? reportMessage : reportMessage);
                  Future<bool?> reportFuture = ReportService().createReport(
                      widget.orderModel!.id,
                      widget.tokenModel.message,
                      reportCreateModel);
                  reportFuture.then((rate) {
                    if (rate == true) {
                      setState(() {
                        helper.pushInto(
                            context,
                            HistoryPage(
                              tokenModel: widget.tokenModel,
                              userModel: widget.userModel!,
                            ),
                            true);
                      });
                    }
                  });
                },
                height: 50,
                width: 200),
          )),
    );
  }
}

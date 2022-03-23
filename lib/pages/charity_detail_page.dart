import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/charity_detail_model.dart';
import 'package:play_together_mobile/pages/donate_charity_page.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';

class CharityDetailPage extends StatefulWidget {
  final CharityDetailModel charityDetailModel;
  const CharityDetailPage({Key? key, required this.charityDetailModel})
      : super(key: key);

  @override
  State<CharityDetailPage> createState() => _CharityDetailPageState();
}

class _CharityDetailPageState extends State<CharityDetailPage> {
  final descriptionController = TextEditingController();
  String description = "";
  @override
  Widget build(BuildContext context) {
    description = widget.charityDetailModel.description;
    descriptionController.text = description;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: FlatButton(
              child: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage(widget.charityDetailModel.avatar),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.charityDetailModel.name,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Text(
              "Giới thiệu",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
            child: Container(
              height: 150,
              //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextFormField(
                style: TextStyle(fontSize: 15),
                enabled: false,
                controller: descriptionController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                maxLength: 1000,
                onSaved: (newValue) => description = newValue!,
                onChanged: (value) {
                  description = value;
                },
                decoration: const InputDecoration(
                  counterText: "",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Giới thiệu sơ lược",
                  hintText: "Giới thiệu bản thân bạn ...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Text(
              "Thông tin liên hệ",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Địa chỉ:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.charityDetailModel.address,
                    style: TextStyle(fontSize: 15),
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        "Điện thoại: ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.charityDetailModel.phone,
                        style: TextStyle(fontSize: 15),
                        maxLines: 2,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "website: ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.charityDetailModel.website,
                        style: TextStyle(fontSize: 15),
                        maxLines: 2,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Email: ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.charityDetailModel.email,
                        style: TextStyle(fontSize: 15),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ],
              )),
        ],
      )),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: AcceptProfileButton(
                text: 'Gửi tiền từ thiện',
                onpress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DonateCharityPage(
                              charityDetailModel: demoCharityDetailModel,
                            )),
                  );
                })),
      ),
    );
  }
}

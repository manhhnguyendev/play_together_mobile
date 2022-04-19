import 'package:flutter/material.dart';
import 'package:play_together_mobile/helpers/api_url.dart';
import 'package:play_together_mobile/models/chat_model.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/chat_service.dart';

class ChatPage extends StatefulWidget {
  final UserModel userModel;
  final OrderModel orderModel;
  final TokenModel tokenModel;
  const ChatPage(
      {Key? key,
      required this.userModel,
      required this.orderModel,
      required this.tokenModel})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var msgController = new TextEditingController();
  List<ChatModel> allChats = [];
  Future getAllChats() {
    Future<ResponseListModel<ChatModel>?> getAllChatsFuture = ChatService()
        .getAllChats(widget.userModel.id, widget.tokenModel.message);
    getAllChatsFuture.then((value) {
      if (value != null) {
        allChats = value.content;
        allChats = allChats.reversed as List<ChatModel>;
      }
    });
    return getAllChatsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllChats(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(137, 128, 255, 1),
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        widget.orderModel.user!.id == widget.userModel.id
                            ? widget.orderModel.user!.avatar
                            : widget.orderModel.toUser!.avatar),
                  ),
                  SizedBox(width: 10 * 0.75),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.orderModel.user!.id == widget.userModel.id
                            ? widget.orderModel.user!.name
                            : widget.orderModel.toUser!.name,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Column(
                    children: List.generate(allChats.length,
                        (index) => buildChatMessage(allChats[index])),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20 / 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 32,
                        color: Color(0xFF087949).withOpacity(0.08),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(137, 128, 255, 1)
                                .withOpacity(0.05),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                    Icons.sentiment_satisfied_alt_outlined,
                                    color: Color.fromRGBO(137, 128, 255, 1)
                                        .withOpacity(0.64)),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: msgController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: "Type message",
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {},
                                  onSubmitted: (Value) {},
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.send_rounded,
                                    color: Color.fromRGBO(137, 128, 255, 1)
                                        .withOpacity(0.64)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget buildChatMessage(ChatModel chatModel) {
    if (chatModel.user!.id == widget.userModel.id) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            color: Color.fromRGBO(137, 128, 255, 1),
            padding: EdgeInsets.symmetric(
              horizontal: 20 * 0.75,
              vertical: 20 / 2,
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(137, 128, 255, 1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              chatModel.message,
              maxLines: null,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ); //return row gửi
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(
                  widget.orderModel.user!.id == widget.userModel.id
                      ? widget.orderModel.user!.avatar
                      : widget.orderModel.toUser!.avatar)),
          SizedBox(width: 20 / 2),
          Container(
            color: Colors.grey,
            padding: EdgeInsets.symmetric(
              horizontal: 20 * 0.75,
              vertical: 20 / 2,
            ),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              chatModel.message,
              maxLines: null,
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ); // return row nhận
    }
  }
}

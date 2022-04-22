import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/chat_model.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/chat_service.dart';
import 'package:google_fonts/google_fonts.dart';

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
  var msgController = TextEditingController();
  List<ChatModel> allChats = [];
  late Iterable<ChatModel> displayChat;
  bool checkSendMsg = true;
  bool checkFirstTime = true;

  Future getAllChats() {
    Future<ResponseListModel<ChatModel>?> getAllChatsFuture = ChatService()
        .getAllChats(
            widget.orderModel.user!.id == widget.userModel.id
                ? widget.orderModel.toUser!.id
                : widget.orderModel.user!.id,
            widget.tokenModel.message);
    getAllChatsFuture.then((value) {
      if (value != null) {
        if (!mounted) return;
        setState(() {
          allChats = value.content;
        });
      }
    });
    return getAllChatsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllChats(),
        builder: (context, snapshot) {
          displayChat = allChats.reversed;
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(137, 128, 255, 1),
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
                            ? widget.orderModel.toUser!.avatar
                            : widget.orderModel.user!.avatar),
                  ),
                  const SizedBox(width: 10 * 0.75),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.orderModel.user!.id == widget.userModel.id
                            ? widget.orderModel.toUser!.name
                            : widget.orderModel.user!.name,
                        style: GoogleFonts.montserrat(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      children: List.generate(
                          displayChat.length,
                          (index) =>
                              buildChatMessage(displayChat.elementAt(index))),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20 / 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 32,
                        color: const Color(0xFF087949).withOpacity(0.08),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(137, 128, 255, 1)
                                .withOpacity(0.05),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                    Icons.sentiment_satisfied_alt_outlined,
                                    color:
                                        const Color.fromRGBO(137, 128, 255, 1)
                                            .withOpacity(0.64)),
                              ),
                              Expanded(
                                child: TextField(
                                  style: GoogleFonts.montserrat(),
                                  controller: msgController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: "Type message",
                                    hintStyle: GoogleFonts.montserrat(),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SendMessageModel sendMessageModel =
                                      SendMessageModel(
                                          message: msgController.text);
                                  Future<bool?> sendMessageFuture =
                                      ChatService().createChat(
                                          widget.orderModel.user!.id ==
                                                  widget.userModel.id
                                              ? widget.orderModel.toUser!.id
                                              : widget.orderModel.user!.id,
                                          sendMessageModel,
                                          widget.tokenModel.message);
                                  sendMessageFuture.then((value) {
                                    setState(() {
                                      if (value == true) {
                                        checkSendMsg = false;
                                        msgController.text = "";
                                      }
                                    });
                                  });
                                },
                                icon: Icon(Icons.send_rounded,
                                    color:
                                        const Color.fromRGBO(137, 128, 255, 1)
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
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20 * 0.75,
                  vertical: 20 / 2,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(137, 128, 255, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  chatModel.message,
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.montserrat(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    widget.orderModel.user!.id == widget.userModel.id
                        ? widget.orderModel.toUser!.avatar
                        : widget.orderModel.user!.avatar)),
            const SizedBox(width: 20 / 2),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20 * 0.75,
                  vertical: 20 / 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  chatModel.message,
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.montserrat(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:play_together_mobile/models/charity_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/services/charity_service.dart';
import 'package:play_together_mobile/widgets/bottom_bar.dart';
import 'package:play_together_mobile/constants/my_color.dart' as my_colors;
import 'package:play_together_mobile/widgets/charity_card.dart';

class CharityPage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;
  const CharityPage({
    Key? key,
    required this.userModel,
    required this.tokenModel,
  }) : super(key: key);

  @override
  State<CharityPage> createState() => _CharityPageState();
}

class _CharityPageState extends State<CharityPage> {
  late String search;
  var _controller = TextEditingController();
  List<CharityModel>? _listCharity;

  Future loadList() {
    _listCharity ??= [];
    Future<List<CharityModel>?> listCharityModelFuture =
        CharityService().getAllCharities(widget.tokenModel.message);
    listCharityModelFuture.then((_charityList) {
      setState(() {
        _listCharity = _charityList;
        if (_listCharity!.length == 0) {
          for (var item in _listCharity!) {
            Future<CharityModel?> charityFuture = CharityService()
                .getCharityById(item.id, widget.tokenModel.message);
            charityFuture.then((value) {
              if (value != null) {
                _listCharity!.add(value);
              }
            });
          }
        }
      });
    });
    return listCharityModelFuture;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        bottomOpacity: 0,
        toolbarOpacity: 1,
        toolbarHeight: 65,
        title: Container(
          margin: const EdgeInsets.only(top: 10, left: 10),
          child: Row(children: [
            const CircleAvatar(
              radius: 27,
              backgroundColor: Colors.white,
              backgroundImage:
                  AssetImage("assets/images/play_together_logo_no_text.png"),
            ),
            SizedBox(
              width: size.width / 25,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: size.width * 0.7,
                decoration: BoxDecoration(
                  color: my_colors.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: _controller,
                  onChanged: (value) {
                    search = value;
                    setState(() {});
                  },
                  onSubmitted: (value) {
                    if (search.length != 0 && value.length != 0) {
                      setState(() {});
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 30 / 375 * size.width,
                        vertical: 9 / 512 * size.height),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Tìm kiếm hội từ thiện",
                    prefixIcon: const Icon(
                      Icons.search,
                      color: my_colors.secondary,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                            height: 812,
                            child: FutureBuilder(
                                future: loadList(),
                                builder: (context, snapshot) {
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: _listCharity == null
                                        ? 0
                                        : _listCharity!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CharityCard(
                                        charityModel: _listCharity![index],
                                        tokenModel: widget.tokenModel,
                                        userModel: widget.userModel,
                                      );
                                    },
                                  );
                                })),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ],
            )),
      ),
      bottomNavigationBar: BottomBar(
        userModel: widget.userModel,
        tokenModel: widget.tokenModel,
        bottomBarIndex: 2,
      ),
    );
  }

  // Widget buildListSearch(CharityModel charityModel) => CharityCard(
  //     charityModel: charityModel,
  //     tokenModel: widget.tokenModel,
  //     userModel: widget.userModel);
}

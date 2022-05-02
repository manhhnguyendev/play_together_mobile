import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:play_together_mobile/models/hobbies_model.dart';
import 'package:play_together_mobile/models/login_google_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/home_page.dart';
import 'package:play_together_mobile/pages/login_page.dart';
import 'package:play_together_mobile/pages/take_user_categories_page.dart';
import 'package:play_together_mobile/services/hobbies_service.dart';
import 'package:play_together_mobile/services/login_google_service.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:play_together_mobile/services/user_service.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginGooglePage extends StatefulWidget {
  const LoginGooglePage({Key? key}) : super(key: key);

  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<LoginGooglePage> {
  final String providerName = "https://accounts.google.com";
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  late UserModel userModel;
  late TokenModel tokenModel;
  late GoogleSignIn _googleSignIn;

  LoginGoogleModel loginGoogle =
      LoginGoogleModel(idToken: "", providerName: "");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 70,
      alignment: Alignment.center,
      child: Scaffold(
        body: FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.done) {
                _googleSignIn = GoogleSignIn();
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 1),
                  width: size.width * 0.95,
                  height: size.height / 15,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(219, 68, 50, 1),
                        ),
                        child: TextButton(
                          onPressed: () {
                            _googleSignIn.signIn().then((result) {
                              result!.authentication.then((googleKey) {
                                loginGoogle.providerName = providerName;
                                loginGoogle.idToken = googleKey.idToken!;
                                Future<TokenModel?> loginGoogleModelFuture =
                                    LoginGoogleService()
                                        .loginGoogle(loginGoogle);
                                loginGoogleModelFuture.then((value) {
                                  if (value != null) {
                                    tokenModel = value;
                                    Future<ResponseModel<UserModel>?>
                                        hirerModelFuture = UserService()
                                            .getUserProfile(value.message);
                                    hirerModelFuture.then((hirer) {
                                      if (hirer != null) {
                                        userModel = hirer.content;
                                        Future<ResponseListModel<HobbiesModel>?>
                                            hobbiesFuture = HobbiesService()
                                                .getHobbiesOfUser(userModel.id,
                                                    tokenModel.message);
                                        hobbiesFuture.then((listHobbies) {
                                          if (listHobbies!.content.isNotEmpty) {
                                            setState(() {
                                              helper.pushInto(
                                                  context,
                                                  HomePage(
                                                    userModel: userModel,
                                                    tokenModel: tokenModel,
                                                  ),
                                                  true);
                                            });
                                          } else if (listHobbies
                                              .content.isEmpty) {
                                            setState(() {
                                              helper.pushInto(
                                                  context,
                                                  UserCategoriesPage(
                                                    userModel: userModel,
                                                    tokenModel: tokenModel,
                                                  ),
                                                  true);
                                            });
                                          }
                                        });
                                        Fluttertoast.showToast(
                                            msg: "ĐĂNG NHẬP THÀNH CÔNG",
                                            textColor: Colors.white,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    137, 128, 255, 1),
                                            toastLength: Toast.LENGTH_SHORT);
                                      }
                                    });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Tài khoản đã tồn tại",
                                        textColor: Colors.white,
                                        backgroundColor: const Color.fromRGBO(
                                            137, 128, 255, 1),
                                        toastLength: Toast.LENGTH_SHORT);
                                    setState(() {
                                      _googleSignIn.signOut();
                                      helper.pushInto(
                                          context, const LoginPage(), true);
                                    });
                                  }
                                });
                              });
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.googlePlusG,
                                color: Colors.white,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text("ĐĂNG NHẬP BẰNG GOOGLE",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Container();
            }),
      ),
    );
  }
}

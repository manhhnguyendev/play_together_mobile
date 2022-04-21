import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:play_together_mobile/models/hobbies_model.dart';
import 'package:play_together_mobile/models/login_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/login_google_page.dart';
import 'package:play_together_mobile/pages/register_page.dart';
import 'package:play_together_mobile/helpers/const.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/pages/forgot_password_page.dart';
import 'package:play_together_mobile/pages/home_page.dart';
import 'package:play_together_mobile/pages/take_user_categories_page.dart';
import 'package:play_together_mobile/services/email_service.dart';
import 'package:play_together_mobile/services/hobbies_service.dart';
import 'package:play_together_mobile/services/login_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/login_error_form.dart';
import 'package:play_together_mobile/widgets/main_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final List listError = [''];
  late UserModel userModel;
  late TokenModel tokenModel;
  String email = "";
  String password = "";
  bool obsecure = true;

  LoginModel login = LoginModel(email: "", password: "");

  void addError({String? error}) {
    if (!listError.contains(error)) {
      setState(() {
        listError.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (listError.contains(error)) {
      setState(() {
        listError.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            width: size.width,
            height: size.height * 0.45,
            decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image:
                        AssetImage("assets/images/play_together_logo_text.png"),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        buildEmailField(),
                        const SizedBox(
                          height: 15,
                        ),
                        buildPasswordField(),
                        FormError(listError: listError),
                      ],
                    ),
                  ),
                  MainButton(
                    text: "ĐĂNG NHẬP",
                    onPress: () {
                      if (_formKey.currentState == null) {
                        print("_formKey.currentState is null!");
                      } else if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (listError.length == 1) {
                          login.email = email;
                          login.password = password;
                          Future<String?> checkEmailFuture =
                              EmailService().checkEmail(login.email);
                          checkEmailFuture.then((_checkEmail) {
                            if (_checkEmail == 'true') {
                              Future<TokenModel?> loginModelFuture =
                                  LoginService().login(login);
                              loginModelFuture.then((value) {
                                if (value != null) {
                                  tokenModel = value;
                                  Future<ResponseModel<UserModel>?>
                                      hirerModelFuture = UserService()
                                          .getUserProfile(value.message);
                                  hirerModelFuture.then((hirer) {
                                    if (hirer != null) {
                                      userModel = hirer.content;
                                      Future<ResponseListModel<HobbiesModel>?>
                                          hobbiesFuture =
                                          HobbiesService().getHobbiesOfUser(
                                              userModel.id, tokenModel.message);
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
                                          msg: "Đăng nhập thành công",
                                          textColor: Colors.white,
                                          backgroundColor: const Color.fromRGBO(
                                              137, 128, 255, 1),
                                          toastLength: Toast.LENGTH_SHORT);
                                    }
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Mật khẩu không chính xác",
                                      textColor: Colors.white,
                                      backgroundColor: const Color.fromRGBO(
                                          137, 128, 255, 1),
                                      toastLength: Toast.LENGTH_SHORT);
                                }
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Tên đăng nhập không tồn tại",
                                  textColor: Colors.white,
                                  backgroundColor:
                                      const Color.fromRGBO(137, 128, 255, 1),
                                  toastLength: Toast.LENGTH_SHORT);
                            }
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height / 40,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                ),
                child: Text(
                  'Tạo tài khoản?',
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPasswordPage()),
                ),
                child: Text(
                  'Quên mật khẩu?',
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ]),
          SizedBox(
            height: size.height / 40,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  decoration: BoxDecoration(
                      color: Colors.black38,
                      border: Border.all(color: Colors.black45)),
                  child: SizedBox(
                    height: 0.01,
                    width: size.width * 0.3,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text("Hoặc",
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Colors.grey),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                  decoration: BoxDecoration(
                      color: Colors.black38,
                      border: Border.all(color: Colors.black45)),
                  child: SizedBox(
                    height: 0.01,
                    width: size.width * 0.3,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height / 50,
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: LoginGooglePage(),
          ),
        ]),
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      style: GoogleFonts.montserrat(),
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        password = value;
        if (value.isNotEmpty && listError.contains(passNullError)) {
          removeError(error: passNullError);
        }
        return;
      },
      validator: (value) {
        if ((value!.isEmpty) && !listError.contains(passNullError)) {
          addError(error: passNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          labelText: "Mật khẩu",
          hintText: "Nhập vào mật khẩu",
          hintStyle: GoogleFonts.montserrat(),
          labelStyle: GoogleFonts.montserrat(),
          enabledBorder: const OutlineInputBorder(
            gapPadding: 10,
          ),
          focusedBorder: const OutlineInputBorder(
            gapPadding: 10,
          ),
          errorBorder: const OutlineInputBorder(
              gapPadding: 10, borderSide: BorderSide(color: Colors.black)),
          focusedErrorBorder: const OutlineInputBorder(
              gapPadding: 10, borderSide: BorderSide(color: Colors.black)),
          errorStyle: GoogleFonts.montserrat(height: 0, color: Colors.black),
          suffixIcon: IconButton(
              onPressed: () => setState(() {
                    obsecure = !obsecure;
                  }),
              icon: Icon(
                obsecure ? Icons.visibility_off : Icons.visibility,
                size: 25,
                color: Colors.black,
              ))),
      obscureText: obsecure,
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      style: GoogleFonts.montserrat(),
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        email = value;
        if (value.isNotEmpty && listError.contains(emailNullError)) {
          removeError(error: emailNullError);
        } else if (emailValidatorRegExp.hasMatch(value) &&
            listError.contains(invalidEmailError)) {
          removeError(error: invalidEmailError);
        }
        return;
      },
      validator: (value) {
        if ((value!.isEmpty) && !listError.contains(emailNullError)) {
          addError(error: emailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !listError.contains(invalidEmailError)) {
          addError(error: invalidEmailError);
        }
        return null;
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        labelText: "Email",
        hintText: "Nhập vào email",
        hintStyle: GoogleFonts.montserrat(),
        labelStyle: GoogleFonts.montserrat(),
        enabledBorder: const OutlineInputBorder(
          gapPadding: 10,
        ),
        focusedBorder: const OutlineInputBorder(
          gapPadding: 10,
        ),
        focusedErrorBorder: const OutlineInputBorder(
            gapPadding: 10, borderSide: BorderSide(color: Colors.black)),
        errorBorder: (const OutlineInputBorder(
            gapPadding: 10, borderSide: BorderSide(color: Colors.black))),
        errorStyle: GoogleFonts.montserrat(height: 0, color: Colors.black),
      ),
    );
  }
}

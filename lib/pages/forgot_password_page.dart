import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:play_together_mobile/helpers/const.dart';
import 'package:play_together_mobile/models/password_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/pages/change_password_page.dart';
import 'package:play_together_mobile/services/email_service.dart';
import 'package:play_together_mobile/services/password_service.dart';
import 'package:play_together_mobile/widgets/login_error_form.dart';
import 'package:play_together_mobile/widgets/main_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:email_auth/email_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final EmailModel _emailModel = EmailModel(email: "");
  final List listErrorEmail = [''];
  final List listErrorOTP = [''];
  late TokenModel tokenModel;
  String email = "";
  String otpCode = "";
  bool submitValid = false;
  bool verifyEmail = false;

  void addError(List inputListError, {String? error}) {
    if (!inputListError.contains(error)) {
      setState(() {
        inputListError.add(error);
      });
    }
  }

  void removeError(List inputListError, {String? error}) {
    if (inputListError.contains(error)) {
      setState(() {
        inputListError.remove(error);
      });
    }
  }

  EmailAuth? emailAuth;

  @override
  void initState() {
    super.initState();
    emailAuth = EmailAuth(
      sessionName: "Play Together Application",
    );
  }

  bool verify() {
    return emailAuth!.validateOtp(
        recipientMail: emailController.value.text,
        userOtp: otpController.value.text);
  }

  void sendOtp() async {
    bool result = await emailAuth!
        .sendOtp(recipientMail: emailController.value.text, otpLength: 5);
    if (result) {
      setState(() {
        submitValid = true;
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
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.45,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/play_together_logo_text.png"),
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
                          Row(
                            children: [
                              Expanded(flex: 2, child: buildEmailField()),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  width: size.width,
                                  height: size.height / 14,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color:
                                              Color.fromRGBO(165, 165, 165, 1),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            if (emailController.text.isEmpty ||
                                                emailController.text == "") {
                                              Fluttertoast.showToast(
                                                  msg: "Vui l??ng nh???p Email",
                                                  textColor: Colors.white,
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          137, 128, 255, 1),
                                                  toastLength:
                                                      Toast.LENGTH_SHORT);
                                            } else {
                                              Future<String?> checkEmailFuture =
                                                  EmailService().checkEmail(
                                                      emailController.text);
                                              checkEmailFuture
                                                  .then((_checkEmail) {
                                                if (_checkEmail != 'false') {
                                                  sendOtp();
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "L???y m?? OTP th??nh c??ng",
                                                      textColor: Colors.white,
                                                      backgroundColor:
                                                          const Color.fromRGBO(
                                                              137, 128, 255, 1),
                                                      toastLength:
                                                          Toast.LENGTH_SHORT);
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "T??n ????ng nh???p kh??ng t???n t???i",
                                                      textColor: Colors.white,
                                                      backgroundColor:
                                                          const Color.fromRGBO(
                                                              137, 128, 255, 1),
                                                      toastLength:
                                                          Toast.LENGTH_SHORT);
                                                }
                                              });
                                            }
                                          },
                                          child: Text("L???y m?? OTP",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  color: Colors.white,
                                                  fontSize: 14)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          FormError(listError: listErrorEmail),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(flex: 2, child: buildOTPField()),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  width: size.width,
                                  height: size.height / 14,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color:
                                              Color.fromRGBO(165, 165, 165, 1),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            if (otpController.text.isEmpty ||
                                                otpController.text == "") {
                                              Fluttertoast.showToast(
                                                  msg: "Vui l??ng nh???p m?? OTP",
                                                  textColor: Colors.white,
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          137, 128, 255, 1),
                                                  toastLength:
                                                      Toast.LENGTH_SHORT);
                                            } else {
                                              verifyEmail = verify();
                                              if (verifyEmail == true) {
                                                Fluttertoast.showToast(
                                                    msg: "X??c th???c th??nh c??ng",
                                                    textColor: Colors.white,
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            137, 128, 255, 1),
                                                    toastLength:
                                                        Toast.LENGTH_SHORT);
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "M?? OTP kh??ng ch??nh x??c",
                                                    textColor: Colors.white,
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            137, 128, 255, 1),
                                                    toastLength:
                                                        Toast.LENGTH_SHORT);
                                              }
                                            }
                                          },
                                          child: Text("X??c th???c",
                                              style: GoogleFonts.montserrat(
                                                  color: Colors.white,
                                                  fontSize: 14)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          FormError(listError: listErrorOTP),
                        ],
                      ),
                    ),
                    MainButton(
                      text: "TI???P T???C",
                      onPress: () {
                        if (_formKey.currentState == null) {
                        } else if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (listErrorEmail.length == 1 &&
                              listErrorOTP.length == 1) {
                            _emailModel.email = emailController.text;
                            Future<TokenModel?> resetPasswordModelFuture =
                                PasswordService()
                                    .resetPasswordToken(_emailModel);
                            resetPasswordModelFuture.then((value) {
                              if (value != null) {
                                tokenModel = value;
                                if (verifyEmail == true) {
                                  setState(() {
                                    helper.pushInto(
                                        context,
                                        ChangePasswordPage(
                                          emailModel: _emailModel,
                                          tokenModel: tokenModel,
                                        ),
                                        true);
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Vui l??ng x??c th???c email",
                                      textColor: Colors.white,
                                      backgroundColor: const Color.fromRGBO(
                                          137, 128, 255, 1),
                                      toastLength: Toast.LENGTH_SHORT);
                                }
                              }
                            });
                          }
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'B???n ???? c?? t??i kho???n? Quay l???i ????ng nh???p',
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      style: GoogleFonts.montserrat(),
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        email = value;
        if (value.isNotEmpty && listErrorEmail.contains(emailNullError)) {
          removeError(listErrorEmail, error: emailNullError);
        } else if (emailValidatorRegExp.hasMatch(value) &&
            listErrorEmail.contains(invalidEmailError)) {
          removeError(listErrorEmail, error: invalidEmailError);
        }
        return;
      },
      validator: (value) {
        if ((value!.isEmpty) && !listErrorEmail.contains(emailNullError)) {
          addError(listErrorEmail, error: emailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !listErrorEmail.contains(invalidEmailError)) {
          addError(listErrorEmail, error: invalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        labelText: "Email",
        hintText: "Nh???p v??o email",
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

  TextFormField buildOTPField() {
    return TextFormField(
      style: GoogleFonts.montserrat(),
      controller: otpController,
      onSaved: (newValue) => otpCode = newValue!,
      maxLength: 6,
      onChanged: (value) {
        otpCode = value;
        if ((value.length == 6) && listErrorOTP.contains(otpNullError)) {
          removeError(listErrorOTP, error: otpNullError);
        }
        return;
      },
      validator: (value) {
        if ((value!.isEmpty || value.length < 6) &&
            !listErrorOTP.contains(otpNullError)) {
          addError(listErrorOTP, error: otpNullError);
          return "";
        }
        return null;
      },
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        counterText: "",
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        labelText: "M?? OTP",
        hintText: "Nh???p v??o m?? OTP",
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:play_together_mobile/helpers/const.dart';
import 'package:play_together_mobile/models/register_model.dart';
import 'package:play_together_mobile/pages/complete_register_page.dart';
import 'package:play_together_mobile/services/email_service.dart';
import 'package:play_together_mobile/widgets/login_error_form.dart';
import 'package:play_together_mobile/widgets/main_button.dart';
import 'package:email_auth/email_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List listErrorEmail = [''];
  final List listErrorPass = [''];
  final List listErrorConfirm = [''];
  final List listErrorOTP = [''];
  String email = "";
  String password = "";
  String confirmPass = "";
  String otpCode = "";
  bool submitValid = false;
  bool confirmEmail = false;
  bool passObsecure = true;
  bool confirmObsecure = true;

  TempRegisterModel tempRegisterModel = TempRegisterModel(
      email: "", password: "", confirmPassword: "", confirmEmail: false);

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
      sessionName: "Play Together",
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
          children: <Widget>[
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
                                                  msg: "Vui lòng nhập Email",
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
                                                if (_checkEmail == 'false') {
                                                  sendOtp();
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Lấy mã OTP thành công",
                                                      textColor: Colors.white,
                                                      backgroundColor:
                                                          const Color.fromRGBO(
                                                              137, 128, 255, 1),
                                                      toastLength:
                                                          Toast.LENGTH_SHORT);
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Email đã được sử dụng",
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
                                          child: Text("Lấy mã OTP",
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
                                                  msg: "Vui lòng nhập mã OTP",
                                                  textColor: Colors.white,
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          137, 128, 255, 1),
                                                  toastLength:
                                                      Toast.LENGTH_SHORT);
                                            } else {
                                              confirmEmail = verify();
                                              if (confirmEmail == true) {
                                                Fluttertoast.showToast(
                                                    msg: "Xác thực thành công",
                                                    textColor: Colors.white,
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            137, 128, 255, 1),
                                                    toastLength:
                                                        Toast.LENGTH_SHORT);
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Mã OTP không chính xác",
                                                    textColor: Colors.white,
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            137, 128, 255, 1),
                                                    toastLength:
                                                        Toast.LENGTH_SHORT);
                                              }
                                            }
                                          },
                                          child: Text("Xác thực",
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
                          const SizedBox(
                            height: 10,
                          ),
                          buildPasswordField(),
                          FormError(listError: listErrorPass),
                          const SizedBox(
                            height: 10,
                          ),
                          buildConfirmPasswordField(),
                          FormError(listError: listErrorConfirm),
                        ],
                      ),
                    ),
                    MainButton(
                      text: "TIẾP TỤC",
                      onPress: () {
                        if (_formKey.currentState == null) {
                        } else if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (listErrorEmail.length == 1 &&
                              listErrorPass.length == 1 &&
                              listErrorConfirm.length == 1 &&
                              listErrorOTP.length == 1) {
                            tempRegisterModel.email = emailController.text;
                            tempRegisterModel.confirmEmail = confirmEmail;
                            tempRegisterModel.password =
                                passwordController.text;
                            tempRegisterModel.confirmPassword =
                                confirmPasswordController.text;
                            if (confirmEmail == true) {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CompleteRegisterPage(
                                            tempRegisterModel:
                                                tempRegisterModel,
                                          )),
                                );
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Vui lòng xác thực email",
                                  textColor: Colors.white,
                                  backgroundColor:
                                      const Color.fromRGBO(137, 128, 255, 1),
                                  toastLength: Toast.LENGTH_SHORT);
                            }
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Bạn đã có tài khoản? Quay lại đăng nhập',
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
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

  TextFormField buildPasswordField() {
    return TextFormField(
      style: GoogleFonts.montserrat(),
      controller: passwordController,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        password = value;
        if (value.isNotEmpty && listErrorPass.contains(passNullError)) {
          removeError(listErrorPass, error: passNullError);
        } else if (passwordValidatorRegExp.hasMatch(value) &&
            listErrorPass.contains(invalidPassError)) {
          removeError(listErrorPass, error: invalidPassError);
        }
        return;
      },
      validator: (value) {
        if ((value!.isEmpty) && !listErrorPass.contains(passNullError)) {
          addError(listErrorPass, error: passNullError);
          return "";
        } else if (!passwordValidatorRegExp.hasMatch(value) &&
            !listErrorPass.contains(invalidPassError)) {
          addError(listErrorPass, error: invalidPassError);
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
          focusedErrorBorder: const OutlineInputBorder(
              gapPadding: 10, borderSide: BorderSide(color: Colors.black)),
          errorBorder: (const OutlineInputBorder(
              gapPadding: 10, borderSide: BorderSide(color: Colors.black))),
          errorStyle: GoogleFonts.montserrat(height: 0, color: Colors.black),
          suffixIcon: IconButton(
              onPressed: () => setState(() {
                    passObsecure = !passObsecure;
                  }),
              icon: Icon(
                passObsecure ? Icons.visibility_off : Icons.visibility,
                size: 25,
                color: Colors.black,
              ))),
      obscureText: passObsecure,
    );
  }

  TextFormField buildConfirmPasswordField() {
    return TextFormField(
      style: GoogleFonts.montserrat(),
      controller: confirmPasswordController,
      onSaved: (newValue) => confirmPass = newValue!,
      onChanged: (value) {
        confirmPass = value;
        if (value.isNotEmpty && listErrorConfirm.contains(confirmNullError)) {
          removeError(listErrorConfirm, error: confirmNullError);
        } else if (password == value) {
          removeError(listErrorConfirm, error: matchPassError);
        }
        return;
      },
      validator: (value) {
        if ((value!.isEmpty) && !listErrorConfirm.contains(confirmNullError)) {
          addError(listErrorConfirm, error: confirmNullError);
          return "";
        } else if (password != value &&
            !listErrorConfirm.contains(matchPassError)) {
          addError(listErrorConfirm, error: matchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          labelText: "Nhập lại mật khẩu",
          hintText: "Nhập lại mật khẩu",
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
          suffixIcon: IconButton(
              onPressed: () => setState(() {
                    confirmObsecure = !confirmObsecure;
                  }),
              icon: Icon(
                confirmObsecure ? Icons.visibility_off : Icons.visibility,
                size: 25,
                color: Colors.black,
              ))),
      obscureText: confirmObsecure,
    );
  }

  TextFormField buildOTPField() {
    return TextFormField(
      style: GoogleFonts.montserrat(),
      controller: otpController,
      maxLength: 6,
      onSaved: (newValue) => otpCode = newValue!,
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
        labelText: "Mã OTP",
        hintText: "Nhập vào mã OTP",
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

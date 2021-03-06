import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:play_together_mobile/helpers/const.dart';
import 'package:play_together_mobile/models/password_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/pages/login_page.dart';
import 'package:play_together_mobile/services/password_service.dart';
import 'package:play_together_mobile/widgets/login_error_form.dart';
import 'package:play_together_mobile/widgets/main_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordPage extends StatefulWidget {
  final EmailModel emailModel;
  final TokenModel tokenModel;

  const ChangePasswordPage(
      {Key? key, required this.emailModel, required this.tokenModel})
      : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final List listErrorPass = [''];
  final List listErrorConfirm = [''];
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  String password = "";
  String confirmPass = "";
  bool passObsecure = true;
  bool confirmObsecure = true;

  ResetPasswordModel resetPasswordModel = ResetPasswordModel(
      email: '', newPassword: '', confirmNewPassword: '', token: '');

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
                    buildPasswordField(),
                    FormError(listError: listErrorPass),
                    const SizedBox(
                      height: 10,
                    ),
                    buildConfirmField(),
                    FormError(listError: listErrorConfirm),
                    const SizedBox(
                      height: 5,
                    ),
                    MainButton(
                      text: "THAY ?????I M???T KH???U",
                      onPress: () {
                        if (_formKey.currentState == null) {
                        } else if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (listErrorPass.length == 1 &&
                              listErrorConfirm.length == 1) {
                            resetPasswordModel.email = widget.emailModel.email;
                            resetPasswordModel.newPassword =
                                newPasswordController.text;
                            resetPasswordModel.confirmNewPassword =
                                confirmNewPasswordController.text;
                            resetPasswordModel.token =
                                widget.tokenModel.message;
                            Future<bool?> resetPasswordModelFuture =
                                PasswordService()
                                    .resetPassword(resetPasswordModel);
                            resetPasswordModelFuture
                                .then((_resetPasswordModel) {
                              if (_resetPasswordModel == true) {
                                setState(() {
                                  helper.pushInto(
                                      context, const LoginPage(), true);
                                });
                                Fluttertoast.showToast(
                                    msg: "?????i m???t kh???u th??nh c??ng",
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
          ],
        ),
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      style: GoogleFonts.montserrat(),
      controller: newPasswordController,
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
          labelText: "M???t kh???u m???i",
          hintText: "Nh???p v??o m???t kh???u m???i",
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

  TextFormField buildConfirmField() {
    return TextFormField(
      style: GoogleFonts.montserrat(),
      controller: confirmNewPasswordController,
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
          labelText: "Nh???p l???i m???t kh???u m???i",
          hintText: "Nh???p l???i m???t kh???u m???i",
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
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:play_together_mobile/helpers/const.dart';
import 'package:play_together_mobile/models/password_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_balance_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/personal_page.dart';
import 'package:play_together_mobile/services/password_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/login_error_form.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:google_fonts/google_fonts.dart';

class PersonalChangePassword extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const PersonalChangePassword(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  State<PersonalChangePassword> createState() => _PersonalChangePasswordState();
}

class _PersonalChangePasswordState extends State<PersonalChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final List listErrorOldPass = [''];
  final List listErrorPass = [''];
  final List listErrorConfirm = [''];
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  String oldPassword = "";
  String password = "";
  String confirmPass = "";
  bool oldPassObsecure = true;
  bool passObsecure = true;
  bool confirmObsecure = true;

  ChangePasswordModel changePasswordModel = ChangePasswordModel(
      email: '', currentPassword: '', newPassword: '', confirmNewPassword: '');

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.black),
              child: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          centerTitle: true,
          title: Text(
            'Thay ?????i m???t kh???u',
            style: GoogleFonts.montserrat(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  buildOldPasswordField(),
                  FormError(listError: listErrorOldPass),
                  const SizedBox(
                    height: 10,
                  ),
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
                ],
              ),
            ),
          ),
        ],
      )),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: AcceptProfileButton(
                text: 'C???p nh???t',
                onPress: () {
                  if (_formKey.currentState == null) {
                  } else if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (listErrorPass.length == 1 &&
                        listErrorConfirm.length == 1) {
                      changePasswordModel.email = widget.userModel.email;
                      changePasswordModel.currentPassword = changePasswordModel
                          .newPassword = currentPasswordController.text;
                      changePasswordModel.newPassword =
                          newPasswordController.text;
                      changePasswordModel.confirmNewPassword =
                          confirmNewPasswordController.text;
                      Future<bool?> changePasswordModelFuture =
                          PasswordService().changePassword(
                              changePasswordModel, widget.tokenModel.message);
                      changePasswordModelFuture.then((_changePasswordModel) {
                        if (_changePasswordModel == true) {
                          Future<ResponseModel<UserBalanceModel>?>
                              getUserBalanceFuture = UserService()
                                  .getUserBalance(widget.userModel.id,
                                      widget.tokenModel.message);
                          getUserBalanceFuture.then((value) {
                            if (value != null) {
                              helper.pushInto(
                                context,
                                PersonalPage(
                                  userModel: widget.userModel,
                                  tokenModel: widget.tokenModel,
                                  activeBalance: value.content.activeBalance,
                                  balance: value.content.balance,
                                ),
                                true,
                              );
                              Fluttertoast.showToast(
                                  msg: "Thay ?????i m???t kh???u th??nh c??ng",
                                  textColor: Colors.white,
                                  backgroundColor:
                                      const Color.fromRGBO(137, 128, 255, 1),
                                  toastLength: Toast.LENGTH_SHORT);
                            }
                          });
                        }
                      });
                    }
                  }
                })),
      ),
    );
  }

  TextFormField buildOldPasswordField() {
    return TextFormField(
      style: GoogleFonts.montserrat(),
      controller: currentPasswordController,
      onSaved: (newValue) => oldPassword = newValue!,
      onChanged: (value) {
        oldPassword = value;
        if (value.isNotEmpty && listErrorOldPass.contains(passNullError)) {
          removeError(listErrorOldPass, error: passNullError);
        } else if (passwordValidatorRegExp.hasMatch(value) &&
            listErrorOldPass.contains(invalidPassError)) {
          removeError(listErrorOldPass, error: invalidPassError);
        }
        return;
      },
      validator: (value) {
        if ((value!.isEmpty) && !listErrorOldPass.contains(passNullError)) {
          addError(listErrorOldPass, error: passNullError);
          return "";
        } else if (!passwordValidatorRegExp.hasMatch(value) &&
            !listErrorOldPass.contains(invalidPassError)) {
          addError(listErrorOldPass, error: invalidPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          labelText: "M???t kh???u c??",
          hintText: "Nh???p v??o m???t kh???u c??",
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
                    oldPassObsecure = !oldPassObsecure;
                  }),
              icon: Icon(
                oldPassObsecure ? Icons.visibility_off : Icons.visibility,
                size: 25,
                color: Colors.black,
              ))),
      obscureText: oldPassObsecure,
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

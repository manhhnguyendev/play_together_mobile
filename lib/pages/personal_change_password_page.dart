import 'package:flutter/material.dart';
import 'package:play_together_mobile/constants/const.dart';
import 'package:play_together_mobile/widgets/login_error_form.dart';
import 'package:play_together_mobile/widgets/main_button.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';

class PersonalChangePassword extends StatefulWidget {
  const PersonalChangePassword({Key? key}) : super(key: key);

  @override
  State<PersonalChangePassword> createState() => _PersonalChangePasswordState();
}

class _PersonalChangePasswordState extends State<PersonalChangePassword> {
  final _formKey = GlobalKey<FormState>();
  String oldPassword = "";
  String password = "";
  String confirmPass = "";
  bool oldPassObsecure = true;
  bool passObsecure = true;
  bool confirmObsecure = true;
  final List listErrorOldPass = [''];
  final List listErrorPass = [''];
  final List listErrorConfirm = [''];

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
            child: FlatButton(
              child: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Thay đổi mật khẩu',
            style: TextStyle(
                fontSize: 18,
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
                text: 'Cập nhật',
                onpress: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Cập nhật thành công"),
                  ));
                  if (_formKey.currentState == null) {
                    print("_formKey.currentState is null!");
                  } else if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (listErrorPass.length == 1 &&
                        listErrorConfirm.length == 1) {
                      print("VALID");
                    }
                  }
                })),
      ),
    );
  }

  TextFormField buildOldPasswordField() {
    return TextFormField(
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
          labelText: "Mật khẩu cũ",
          hintText: "Nhập vào mật khẩu cũ",
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
          errorStyle: const TextStyle(height: 0, color: Colors.black),
          suffixIcon: IconButton(
              onPressed: () => setState(() {
                    oldPassObsecure = !oldPassObsecure;
                  }),
              icon: const Icon(
                Icons.remove_red_eye,
                size: 25,
                color: Colors.black,
              ))),
      obscureText: passObsecure,
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
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
          labelText: "Mật khẩu mới",
          hintText: "Nhập vào mật khẩu mới",
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
          errorStyle: const TextStyle(height: 0, color: Colors.black),
          suffixIcon: IconButton(
              onPressed: () => setState(() {
                    passObsecure = !passObsecure;
                  }),
              icon: const Icon(
                Icons.remove_red_eye,
                size: 25,
                color: Colors.black,
              ))),
      obscureText: passObsecure,
    );
  }

  TextFormField buildConfirmField() {
    return TextFormField(
      onSaved: (newValue) => confirmPass = newValue!,
      onChanged: (value) {
        confirmPass = value;
        if (value.isNotEmpty && listErrorConfirm.contains(confirmNullError)) {
          removeError(listErrorConfirm, error: confirmNullError);
        } else if (password == value) {
          removeError(listErrorConfirm, error: matchPassError);
          print(password + "-remove");
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
          print(password + "-add");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          labelText: "Nhập lại mật khẩu mới",
          hintText: "Nhập lại mật khẩu mới",
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
          errorStyle: const TextStyle(height: 0, color: Colors.black),
          suffixIcon: IconButton(
              onPressed: () => setState(() {
                    confirmObsecure = !confirmObsecure;
                  }),
              icon: const Icon(
                Icons.remove_red_eye,
                size: 25,
                color: Colors.black,
              ))),
      obscureText: confirmObsecure,
    );
  }
}
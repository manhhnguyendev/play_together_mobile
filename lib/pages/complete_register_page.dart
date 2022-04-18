import 'package:flutter/material.dart';
import 'package:play_together_mobile/helpers/const.dart';
import 'package:play_together_mobile/models/register_model.dart';
import 'package:play_together_mobile/pages/login_page.dart';
import 'package:play_together_mobile/services/register_service.dart';
import 'package:play_together_mobile/widgets/login_error_form.dart';
import 'package:play_together_mobile/widgets/main_button.dart';
import 'package:play_together_mobile/widgets/main_go_back_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;

class CompleteRegisterPage extends StatefulWidget {
  final TempRegisterModel tempRegisterModel;

  const CompleteRegisterPage({Key? key, required this.tempRegisterModel})
      : super(key: key);

  @override
  _CompleteRegisterPageState createState() => _CompleteRegisterPageState();
}

class _CompleteRegisterPageState extends State<CompleteRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final initialDate = DateTime.now();
  final List listErrorName = [''];
  final List listErrorBirthday = ['', birthdayNullError];
  final List listErrorProvince = [''];
  final nameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  late DateTime dateOfBirth;
  RegisterModel register = RegisterModel(
      email: "",
      password: "",
      confirmPassword: "",
      name: "",
      city: "",
      dateOfBirth: "",
      gender: false,
      confirmEmail: false);
  String name = "";
  String? city;
  bool gender = true;
  bool checkFirstTime = true;
  ValueNotifier<String> dateDisplay =
      ValueNotifier<String>("Ngày sinh của bạn");
  List<DropdownMenuItem<String>> listDrop = [];
  List<String> drop = [
    'An Giang',
    'Bà Rịa - Vũng Tàu',
    'Bắc Giang',
    'Bắc Kạn',
    'Bạc Liêu',
    'Bắc Ninh',
    'Bến Tre',
    'Bình Định',
    'Bình Dương',
    'Bình Phước',
    'Bình Thuận',
    'Cà Mau',
    'Cần Thơ',
    'Cao Bằng',
    'Đà Nẵng',
    'Đắk Lắk',
    'Đắk Nông',
    'Điện Biên',
    'Đồng Nai',
    'Đồng Tháp',
    'Gia Lai',
    'Hà Giang',
    'Hà Nam',
    'Hà Nội',
    'Hà Tĩnh',
    'Hải Dương',
    'Hải Phòng',
    'Hậu Giang',
    'Hòa Bình',
    'Hưng Yên',
    'Khánh Hòa',
    'Kiên Giang',
    'Kon Tum',
    'Lai Châu',
    'Lâm Đồng',
    'Lạng Sơn',
    'Lào Cai',
    'Long An',
    'Nam Định',
    'Nghệ An',
    'Ninh Bình',
    'Ninh Thuận',
    'Phú Thọ',
    'Phú Yên',
    'Quảng Bình',
    'Quảng Nam',
    'Quảng Ngãi',
    'Quảng Ninh',
    'Quảng Trị',
    'Sóc Trăng',
    'Sơn La',
    'Tây Ninh',
    'Thái Bình',
    'Thái Nguyên',
    'Thanh Hóa',
    'Thừa Thiên Huế',
    'Tiền Giang',
    'TP Hồ Chí Minh',
    'Trà Vinh',
    'Tuyên Quang',
    'Vĩnh Long',
    'Vĩnh Phúc',
    'Yên Bái',
  ];

  void loadData() {
    listDrop = [];
    listDrop = drop
        .map((val) => DropdownMenuItem<String>(
              child: Text(val),
              value: val,
            ))
        .toList();
  }

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

  void convertBirthday() {
    if (dateOfBirth == null) {
      dateDisplay.value = "Ngày sinh của bạn";
    } else {
      dateDisplay.value =
          '${dateOfBirth.day}/${dateOfBirth.month}/${dateOfBirth.year}';
    }
  }

  @override
  void initState() {
    dateDisplay = ValueNotifier<String>("Ngày sinh của bạn");
    dateDisplay.addListener(() {
      dateOfBirthController.text = dateDisplay.value;
      if (dateOfBirthController.text != "Ngày sinh của bạn" &&
          dateOfBirthController.text.isNotEmpty &&
          listErrorBirthday.contains(birthdayNullError)) {
        listErrorBirthday.remove(birthdayNullError);
      } else if ((dateOfBirthController.text == "Ngày sinh của bạn" ||
              dateOfBirthController.text.isEmpty) &&
          !listErrorBirthday.contains(birthdayNullError)) {
        listErrorBirthday.add(birthdayNullError);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (checkFirstTime) {
      loadData();
      checkFirstTime = false;
    }
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
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(flex: 1, child: buildNameField()),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: FormError(listError: listErrorName)),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: buildProvinceField(),
                                  flex: 7,
                                ),
                                const Expanded(
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color.fromARGB(220, 100, 100, 100),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        buildBirthdayField(),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      "Giới tính:",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              220, 100, 100, 100),
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: buildGenderSelection()),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  MainButton(
                      text: "HOÀN TẤT",
                      onpress: () {
                        if (_formKey.currentState == null) {
                          print("_formKey.currentState is null!");
                        } else if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (listErrorName.length == 1 &&
                              listErrorProvince.length == 1 &&
                              listErrorBirthday.length == 1) {
                            register.email = widget.tempRegisterModel.email;
                            register.confirmEmail =
                                widget.tempRegisterModel.confirmEmail;
                            register.password =
                                widget.tempRegisterModel.password;
                            register.confirmPassword =
                                widget.tempRegisterModel.confirmPassword;
                            register.name = nameController.text;
                            register.dateOfBirth = dateOfBirth.toString();
                            register.gender = gender;
                            register.city = city!;
                            Future<RegisterModel?> registerModelFuture =
                                RegisterService().register(register);
                            registerModelFuture.then((registerModel) {
                              if (registerModel != null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Đăng kí thành công"),
                                ));
                                setState(() {
                                  helper.pushInto(
                                      context, const LoginPage(), true);
                                });
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text("Vui lòng kiểm tra lại thông tin!"),
                                ));
                              }
                            });
                          }
                        }
                      }),
                  GoBackButton(
                      text: "QUAY LẠI ",
                      onpress: () {
                        Navigator.pop(context);
                      }),
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
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
              },
              child: const Text(
                'Bạn đã có tài khoản? Quay lại đăng nhập',
                style: TextStyle(
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
      )),
    );
  }

  TextFormField buildNameField() {
    return TextFormField(
      controller: nameController,
      maxLength: 30,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => name = newValue!,
      onChanged: (value) {
        name = value;
        if (value.isNotEmpty && listErrorName.contains(nameNullError)) {
          removeError(listErrorName, error: nameNullError);
        }
        return;
      },
      validator: (value) {
        if ((value!.isEmpty) && !listErrorName.contains(nameNullError)) {
          addError(listErrorName, error: nameNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        counterText: "",
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        labelText: "Tên",
        hintText: "Tên của bạn",
        enabledBorder: OutlineInputBorder(
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 10,
        ),
        focusedErrorBorder: OutlineInputBorder(
            gapPadding: 10, borderSide: BorderSide(color: Colors.black)),
        errorBorder: (OutlineInputBorder(
            gapPadding: 10, borderSide: BorderSide(color: Colors.black))),
        errorStyle: TextStyle(height: 0, color: Colors.black),
      ),
    );
  }

  Container buildGenderSelection() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Radio(
                    activeColor: const Color(0xff320444),
                    value: true,
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = true;
                      });
                    }),
                const Text("Nam")
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Radio(
                    activeColor: const Color(0xff320444),
                    value: false,
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = false;
                      });
                    }),
                const Text("Nữ"),
              ],
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildBirthdayField() {
    return TextFormField(
      controller: dateOfBirthController,
      onSaved: (newValue) {
        dateDisplay.value = newValue!;
      },
      decoration: const InputDecoration(
        counterText: "",
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        labelText: "Sinh nhật của bạn",
        enabledBorder: OutlineInputBorder(
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 10,
        ),
        focusedErrorBorder: OutlineInputBorder(
            gapPadding: 10, borderSide: BorderSide(color: Colors.black)),
        errorBorder: (OutlineInputBorder(
            gapPadding: 10, borderSide: BorderSide(color: Colors.black))),
        errorStyle: TextStyle(height: 0, color: Colors.black),
        suffixIcon: Icon(
          Icons.calendar_today,
        ),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year - 100),
          lastDate: DateTime(DateTime.now().year + 1),
        ).then((date) {
          dateOfBirth = date!;
          convertBirthday();
        });
      },
    );
  }

  Container buildProvinceField() {
    return Container(
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          menuMaxHeight: 6 * 48,
          value: city,
          items: listDrop,
          hint: const Text('Thành phố của bạn'),
          iconSize: 0.0,
          elevation: 16,
          onChanged: (value) {
            city = value as String;
            setState(() {
              city = value;
            });
          },
        ),
      ),
    );
  }
}

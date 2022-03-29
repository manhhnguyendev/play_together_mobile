import 'package:flutter/material.dart';
import 'package:play_together_mobile/constants/const.dart';
import 'package:play_together_mobile/models/image_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/personal_page.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/login_error_form.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:io';

class HirerProfilePage extends StatefulWidget {
  late UserModel userModel;
  final TokenModel tokenModel;

  HirerProfilePage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  _HirerProfilePageState createState() => _HirerProfilePageState();
}

class _HirerProfilePageState extends State<HirerProfilePage> {
  String name = "";
  String description = "";
  List listPlayerImage = [
    "assets/images/defaultprofile.png",
    "assets/images/defaultprofile.png",
    "assets/images/defaultprofile.png"
  ];
  final _formKey = GlobalKey<FormState>();
  final initialDate = DateTime.now();
  final List listErrorName = [''];
  final List listErrorBirthday = ['', birthdayNullError];
  final List listErrorCity = [''];
  final List listErrorDescription = [''];
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  UserUpdateModel userUpdateModel = UserUpdateModel(
    name: "",
    dateOfBirth: "",
    city: "",
    gender: false,
    avatar: "",
    description: "",
  );
  late String city;
  late DateTime dateOfBirth;
  late bool gender;
  String? avatar;
  String? urlDownload;
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

  File? _imageFile;

  getImageFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
    }
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('avatar/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => _imageFile);
    taskSnapshot.ref.getDownloadURL().then((value) {
      if (value != null) {
        avatar = value;
      }
    });
  }

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
    if (checkFirstTime) {
      loadData();
      nameController.text = widget.userModel.name;
      dateOfBirthController.text = DateFormat('dd/MM/yyyy')
          .format(DateTime.parse(widget.userModel.dateOfBirth));
      city = widget.userModel.city;
      gender = widget.userModel.gender;
      checkFirstTime = false;
      dateOfBirth = DateTime.parse(widget.userModel.dateOfBirth);
      descriptionController.text = widget.userModel.description;
    }
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
            'Thông tin tài khoản',
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      SizedBox(
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.userModel.avatar),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: -25,
                          child: RawMaterialButton(
                            onPressed: () {
                              getImageFromGallery();
                            },
                            elevation: 2.0,
                            fillColor: const Color(0xFFF5F6F9),
                            child: const Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.black,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            shape: const CircleBorder(),
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                alignment: Alignment.centerLeft,
                child: Row(children: const [
                  Text(
                    'Hình ảnh ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Icon(Icons.add_box_outlined),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(
                          widget.userModel.images.length,
                          (index) =>
                              buildImageItem(widget.userModel.images[index]))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Column(
                  children: <Widget>[
                    buildNameField(),
                    Row(children: [
                      Expanded(
                          flex: 1, child: FormError(listError: listErrorName)),
                    ]),
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
                              child: buildCityField(),
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
                                      color: Color.fromARGB(220, 100, 100, 100),
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
                      height: 20,
                    ),
                    buildDescriptionField(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: AcceptProfileButton(
              text: "CẬP NHẬT",
              onpress: () {
                if (_formKey.currentState == null) {
                  print("_formKey.currentState is null!");
                } else if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (listErrorName.length == 1 &&
                      listErrorCity.length == 1 &&
                      listErrorBirthday.length == 1) {}
                  setState(() {
                    uploadImageToFirebase(context);
                    userUpdateModel.name = nameController.text;
                    userUpdateModel.dateOfBirth = dateOfBirth.toString();
                    userUpdateModel.city = city;
                    userUpdateModel.gender = gender;
                    userUpdateModel.avatar = avatar!;
                    userUpdateModel.description = description;
                    Future<bool?> userUpdateModelFuture = UserService()
                        .updateUserProfile(
                            userUpdateModel, widget.tokenModel.message);
                    userUpdateModelFuture.then((userUpdate) {
                      if (userUpdate != true) {
                        userUpdateModel = userUpdate as UserUpdateModel;
                      }
                      setState(() {
                        Future<UserModel?> userModelFuture = UserService()
                            .getUserProfile(widget.tokenModel.message);
                        userModelFuture.then((user) {
                          setState(() {
                            if (user != null) {
                              widget.userModel = user;
                              helper.pushInto(
                                  context,
                                  PersonalPage(
                                      userModel: widget.userModel,
                                      tokenModel: widget.tokenModel),
                                  false);
                            }
                          });
                        });
                      });
                    });
                  });
                }
              }),
        ),
      ),
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
        labelText: "Họ",
        hintText: "Nhập vào họ",
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
        FocusScope.of(this.context).requestFocus(FocusNode());
        await showDatePicker(
          context: this.context,
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

  Container buildCityField() {
    return Container(
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
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

  Container buildDescriptionField() {
    return Container(
      height: 200,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: TextFormField(
        controller: descriptionController,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        maxLength: 1000,
        onSaved: (newValue) => description = newValue!,
        onChanged: (value) {
          description = value;
        },
        decoration: const InputDecoration(
          counterText: "",
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: "Giới thiệu sơ lược",
          hintText: "Giới thiệu bản thân bạn ...",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildImageItem(ImageModel imageLink) => Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: NetworkImage(imageLink.imageLink),
                  fit: BoxFit.cover)), //sua asset image thanh network
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:play_together_mobile/helpers/const.dart';
import 'package:play_together_mobile/models/image_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_balance_model.dart';
import 'package:play_together_mobile/models/user_model.dart';
import 'package:play_together_mobile/pages/personal_page.dart';
import 'package:play_together_mobile/services/image_service.dart';
import 'package:play_together_mobile/services/user_service.dart';
import 'package:play_together_mobile/widgets/login_error_form.dart';
import 'package:play_together_mobile/widgets/profile_accept_button.dart';
import 'package:play_together_mobile/helpers/helper.dart' as helper;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';

class UserProfilePage extends StatefulWidget {
  final UserModel userModel;
  final TokenModel tokenModel;

  const UserProfilePage(
      {Key? key, required this.userModel, required this.tokenModel})
      : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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
  AddImageModel addImageModel = AddImageModel(userId: "", imageLink: "");
  late String city;
  late DateTime dateOfBirth;
  late bool gender;
  bool checkFirstTime = true;
  String name = "";
  String description = "";
  String? avatar;
  String? urlDownload;
  File? _imageFile;
  List<String>? imagesLink = [];
  List<File>? listImageFile = [];
  List<ImageModel> listUserImages = [];
  List<AddImageModel> listAddImages = [];
  ValueNotifier<String> dateDisplay =
      ValueNotifier<String>("Ng??y sinh c???a b???n");
  List<DropdownMenuItem<String>> listDrop = [];
  List<String> drop = [
    'An Giang',
    'B?? R???a - V??ng T??u',
    'B???c Giang',
    'B???c K???n',
    'B???c Li??u',
    'B???c Ninh',
    'B???n Tre',
    'B??nh ?????nh',
    'B??nh D????ng',
    'B??nh Ph?????c',
    'B??nh Thu???n',
    'C?? Mau',
    'C???n Th??',
    'Cao B???ng',
    '???? N???ng',
    '?????k L???k',
    '?????k N??ng',
    '??i???n Bi??n',
    '?????ng Nai',
    '?????ng Th??p',
    'Gia Lai',
    'H?? Giang',
    'H?? Nam',
    'H?? N???i',
    'H?? T??nh',
    'H???i D????ng',
    'H???i Ph??ng',
    'H???u Giang',
    'H??a B??nh',
    'H??ng Y??n',
    'Kh??nh H??a',
    'Ki??n Giang',
    'Kon Tum',
    'Lai Ch??u',
    'L??m ?????ng',
    'L???ng S??n',
    'L??o Cai',
    'Long An',
    'Nam ?????nh',
    'Ngh??? An',
    'Ninh B??nh',
    'Ninh Thu???n',
    'Ph?? Th???',
    'Ph?? Y??n',
    'Qu???ng B??nh',
    'Qu???ng Nam',
    'Qu???ng Ng??i',
    'Qu???ng Ninh',
    'Qu???ng Tr???',
    'S??c Tr??ng',
    'S??n La',
    'T??y Ninh',
    'Th??i B??nh',
    'Th??i Nguy??n',
    'Thanh H??a',
    'Th???a Thi??n Hu???',
    'Ti???n Giang',
    'TP H??? Ch?? Minh',
    'Tr?? Vinh',
    'Tuy??n Quang',
    'V??nh Long',
    'V??nh Ph??c',
    'Y??n B??i',
  ];

  Future getUserImages() {
    Future<ResponseListModel<ImageModel>?> getUserImagesFuture = UserService()
        .getImagesOfUser(widget.userModel.id, widget.tokenModel.message);
    getUserImagesFuture.then((value) {
      if (value != null) {
        listUserImages = value.content;
      }
    });
    return getUserImagesFuture;
  }

  chooseAvatarFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
    }
    String fileName = basename(_imageFile!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('avatar/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => _imageFile);
    taskSnapshot.ref.getDownloadURL().then((value) {
      setState(() {
        avatar = value;
      });
    });
  }

  void loadData() {
    listDrop = [];
    listDrop = drop
        .map((val) => DropdownMenuItem<String>(
              child: Text(
                val,
                style: GoogleFonts.montserrat(),
              ),
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
    if (dateOfBirth.toString().isEmpty) {
      dateDisplay.value = "Ng??y sinh c???a b???n";
    } else {
      dateDisplay.value =
          '${dateOfBirth.day}/${dateOfBirth.month}/${dateOfBirth.year}';
    }
  }

  @override
  void initState() {
    dateDisplay = ValueNotifier<String>("Ng??y sinh c???a b???n");
    dateDisplay.addListener(() {
      dateOfBirthController.text = dateDisplay.value;
      if (dateOfBirthController.text != "Ng??y sinh c???a b???n" &&
          dateOfBirthController.text.isNotEmpty &&
          listErrorBirthday.contains(birthdayNullError)) {
        listErrorBirthday.remove(birthdayNullError);
      } else if ((dateOfBirthController.text == "Ng??y sinh c???a b???n" ||
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

      dateOfBirth = DateTime.parse(widget.userModel.dateOfBirth);
      descriptionController.text = widget.userModel.description;
      avatar = widget.userModel.avatar;
      checkFirstTime = false;
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
            'Th??ng tin t??i kho???n',
            style: GoogleFonts.montserrat(
                fontSize: 20,
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
                height: 20,
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
                          backgroundImage: NetworkImage(avatar!),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: -25,
                          child: RawMaterialButton(
                            onPressed: () {
                              chooseAvatarFromGallery();
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
                child: Row(children: [
                  Text(
                    'H??nh ???nh',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      var images = await ImagePicker().pickMultiImage();
                      for (var _image in images!) {
                        listImageFile!.add(File(_image.path));
                      }
                      for (var img in listImageFile!) {
                        String fileName = basename(img.path);
                        Reference firebaseStorageRef = FirebaseStorage.instance
                            .ref()
                            .child('images/$fileName');
                        UploadTask uploadTask = firebaseStorageRef.putFile(img);
                        TaskSnapshot taskSnapshot =
                            await uploadTask.whenComplete(() => img);
                        taskSnapshot.ref.getDownloadURL().then((value) {
                          addImageModel.userId = widget.userModel.id;
                          addImageModel.imageLink = value;
                          Future<ResponseModel<AddImageModel>?>
                              listImageModelFuture = ImageService().addImages(
                                  addImageModel, widget.tokenModel.message);
                          listImageModelFuture.then((_addImageModel) {
                            setState(() {
                              ScaffoldMessenger.of(this.context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Th??m th??nh c??ng!"),
                              ));
                            });
                          });
                        });
                      }
                    },
                    icon: const Icon(Icons.add_box_outlined),
                  ),
                ]),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: FutureBuilder(
                    future: getUserImages(),
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: List.generate(
                                  listUserImages.length,
                                  (index) =>
                                      buildImageItem(listUserImages[index]))),
                        ),
                      );
                    }),
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
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  "Gi???i t??nh:",
                                  style: GoogleFonts.montserrat(
                                      color: const Color.fromARGB(
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
              text: "C???P NH???T",
              onPress: () {
                if (_formKey.currentState == null) {
                } else if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (listErrorName.length == 1 &&
                      listErrorCity.length == 1 &&
                      listErrorBirthday.length == 1) {
                    userUpdateModel.name = nameController.text;
                    userUpdateModel.dateOfBirth = dateOfBirth.toString();
                    userUpdateModel.city = city;
                    userUpdateModel.gender = gender;
                    userUpdateModel.avatar =
                        avatar != null ? avatar! : widget.userModel.avatar;
                    userUpdateModel.description = description;
                    Future<bool?> userUpdateModelFuture = UserService()
                        .updateUserProfile(
                            userUpdateModel, widget.tokenModel.message);
                    userUpdateModelFuture.then((_userUpdateModel) {
                      if (_userUpdateModel == true) {
                        Future<ResponseModel<UserModel>?> userModelFuture =
                            UserService()
                                .getUserProfile(widget.tokenModel.message);
                        userModelFuture.then((_userModel) {
                          if (_userModel != null) {
                            Future<ResponseModel<UserBalanceModel>?>
                                getUserBalanceFuture = UserService()
                                    .getUserBalance(widget.userModel.id,
                                        widget.tokenModel.message);
                            getUserBalanceFuture.then((value) {
                              if (value != null) {
                                helper.pushInto(
                                  context,
                                  PersonalPage(
                                    userModel: _userModel.content,
                                    tokenModel: widget.tokenModel,
                                    activeBalance: value.content.activeBalance,
                                    balance: value.content.balance,
                                  ),
                                  true,
                                );
                                Fluttertoast.showToast(
                                    msg: "C???p nh???t th??ng tin th??nh c??ng",
                                    textColor: Colors.white,
                                    backgroundColor:
                                        const Color.fromRGBO(137, 128, 255, 1),
                                    toastLength: Toast.LENGTH_SHORT);
                              }
                            });
                          }
                        });
                      }
                    });
                  }
                }
              }),
        ),
      ),
    );
  }

  TextFormField buildNameField() {
    return TextFormField(
      style: GoogleFonts.montserrat(),
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
      decoration: InputDecoration(
        counterText: "",
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        labelText: "T??n",
        hintText: "Nh???p v??o t??n",
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
                Text("Nam", style: GoogleFonts.montserrat(fontSize: 15)),
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
                Text(
                  "N???",
                  style: GoogleFonts.montserrat(fontSize: 15),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildBirthdayField() {
    return TextFormField(
      style: GoogleFonts.montserrat(),
      controller: dateOfBirthController,
      onSaved: (newValue) {
        dateDisplay.value = newValue!;
      },
      decoration: InputDecoration(
        counterText: "",
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        labelText: "Sinh nh???t c???a b???n",
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
        suffixIcon: const Icon(
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

  SizedBox buildCityField() {
    return SizedBox(
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          menuMaxHeight: 6 * 48,
          value: city,
          items: listDrop,
          hint: const Text('Th??nh ph??? c???a b???n'),
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
        style: GoogleFonts.montserrat(),
        controller: descriptionController,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        maxLength: 1000,
        onSaved: (newValue) => description = newValue!,
        onChanged: (value) {
          description = value;
        },
        decoration: InputDecoration(
          counterText: "",
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: "Gi???i thi???u s?? l?????c",
          hintText: "Gi???i thi???u b???n th??n b???n ...",
          hintStyle: GoogleFonts.montserrat(),
          labelStyle: GoogleFonts.montserrat(),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildImageItem(ImageModel imageLink) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: this.context,
              builder: (BuildContext dialogContext) => Dialog(
                    backgroundColor: Colors.transparent,
                    child: Stack(children: [
                      Container(
                          alignment: FractionalOffset.center,
                          height: MediaQuery.of(this.context).size.height * 0.6,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: NetworkImage(imageLink.imageLink),
                                  fit: BoxFit.cover))),
                      Positioned(
                          bottom: 0,
                          right: -20,
                          child: RawMaterialButton(
                            onPressed: () {
                              Future<bool?> deleteImageFuture = ImageService()
                                  .deleteImage(
                                      imageLink.id, widget.tokenModel.message);
                              deleteImageFuture.then((value) {
                                if (value == true) {
                                  setState(() {
                                    ScaffoldMessenger.of(this.context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Xo?? th??nh c??ng!"),
                                    ));
                                    Navigator.pop(dialogContext);
                                  });
                                }
                              });
                            },
                            elevation: 2.0,
                            fillColor: const Color(0xFFF5F6F9),
                            child: const Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.black,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            shape: const CircleBorder(),
                          )),
                    ]),
                  ));
        },
        child: Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: NetworkImage(imageLink.imageLink), fit: BoxFit.cover)),
        ),
      ),
    );
  }
}

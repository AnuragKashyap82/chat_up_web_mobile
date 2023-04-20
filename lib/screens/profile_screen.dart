import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../apis/apis.dart';
import '../helper/dialog.dart';
import '../models/chat_user.dart';
import '../utils/global_variable.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  var _userData = {};
  Uint8List? _image;
  String photoUrl = "";

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected!!');
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void uploadPhoto(Uint8List? _image) async {
    setState(() {
      _isLoading = true;
    });
    photoUrl = await APIs().uploadImageToStorage(_image!);
    APIs.updateUserProfile(photoUrl).then((value) {
      showSnackBar("Profile Update Successfully", context);
      setState(() {
        _isLoading = false;
      });
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   // loadProfileImage();
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // void loadProfileImage() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   try {
  //     var userSnap = await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(FirebaseAuth.instance.currentUser?.uid)
  //         .get();
  //     if (userSnap.exists) {
  //       setState(() {
  //         _userData = userSnap.data()!;
  //         _isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   } catch (e) {
  //     showSnackBar(e.toString(), context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile Screen"),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton.extended(
            onPressed: () async {
              Dialogs.showProgressBar(context);

              await APIs.updateActiveStatus(false);

              await APIs.auth.signOut().then((value) async {
                Navigator.pop(context);
                Navigator.pop(context);

                APIs.auth = FirebaseAuth.instance;

                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              });
            },
            icon: const Icon(Icons.logout),
            label: Text("Logout"),
            backgroundColor: Colors.redAccent,
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: mq.width,
                    height: mq.height * 0.03,
                  ),
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 64,
                              backgroundImage:
                                  NetworkImage(widget.user.image),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: MaterialButton(
                          onPressed: () {
                            _showBottomSheet();
                          },
                          elevation: 1,
                          child: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          color: Colors.white,
                          shape: const CircleBorder(),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: mq.height * 0.03,
                  ),
                  Text(
                    widget.user.email,
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  SizedBox(
                    height: mq.height * 0.05,
                  ),
                  TextFormField(
                    initialValue: widget.user.name,
                    onSaved: (val) => APIs.me.name = val ?? "",
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : "Required Field",
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      hintText: "eg. Anurag Kashyap",
                      label: const Text("Name"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  SizedBox(
                    height: mq.height * 0.02,
                  ),
                  TextFormField(
                    initialValue: widget.user.about,
                    onSaved: (val) => APIs.me.about = val ?? "",
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : "Required Field",
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                      ),
                      hintText: "eg. Feeling happy",
                      label: const Text("About"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  SizedBox(
                    height: mq.height * 0.05,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: Size(mq.width * 0.5, mq.height * 0.06)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        APIs.updateUserInfo().then((value) {
                          showSnackBar("Profile Update Successfully", context);
                        });
                      } else {}
                    },
                    icon: Icon(Icons.edit),
                    label: _isLoading
                        ? CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          )
                        : Text(
                            "Update",
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    Size mq = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: mq.height * 0.03, bottom: mq.height * 0.05),
            children: [
              const Text(
                "Pick Profile Picture",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: mq.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: CircleBorder(),
                        fixedSize: Size(mq.width * 0.3, mq.height * 0.15)),
                    onPressed: () async {
                      Uint8List im = await pickImage(ImageSource.gallery);
                      setState(() {
                        _image = im;
                      });
                      if (_image != null) {
                        uploadPhoto(_image!);
                      } else {
                        showSnackBar("image is null", context);
                      }
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.photo_camera_back_outlined,
                      color: Colors.blue,
                      size: 42,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: CircleBorder(),
                        fixedSize: Size(mq.width * 0.3, mq.height * 0.15)),
                    onPressed: () async {
                      Uint8List im = await pickImage(ImageSource.camera);
                      setState(() {
                        _image = im;
                      });
                      if (_image != null) {
                        uploadPhoto(_image!);
                      } else {
                        showSnackBar("image is null", context);
                      }
                      uploadPhoto(_image!);
                      ;
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.camera_enhance_rounded,
                      color: Colors.blue,
                      size: 42,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: mq.height * 0.02,
              ),
            ],
          );
        });
  }
}

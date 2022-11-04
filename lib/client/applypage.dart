import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path_provider/path_provider.dart';
import 'package:upperlint_test/helpers/cus_widgets.dart';

class Apply extends StatefulWidget {
  //const Apply({super.key});
  static const routeName = '/apply';

  @override
  State<Apply> createState() => _ApplyState();
}

class _ApplyState extends State<Apply> {
  final formkey = GlobalKey<FormState>();
  File? resumeFile;
  File? passport;
  bool isloading = false;

  String? formfirstname;
  String? formSurname;
  String? formNumber;
  String? formEmail;

  String? formCover;

  String? resumefilepath;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Upperlink"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          margin: pageMargin,
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText(
                    "Frontend Software Engineer",
                    25,
                    weight: FontWeight.w500,
                    color: primarycolor,
                  ),
                  appText("Kindly, fill up the basic Information", 14,
                      weight: FontWeight.w500,
                      color: textcolor1,
                      topmargin: 20.0,
                      bottommargin: 30.0),
                  AppTextFieldWidget(
                    labelText: "First Name",
                    textInputType: TextInputType.name,
                    fx: (val) {
                      if (val!.isEmpty) {
                        return "First name is required";
                      }
                      return null;
                    },
                    fxsavedValue: (val) {
                      formfirstname = val;
                    },
                  ),
                  AppTextFieldWidget(
                    labelText: "Surname",
                    textInputType: TextInputType.name,
                    fx: (val) {
                      if (val!.isEmpty) {
                        return "Surname is required";
                      }
                      return null;
                    },
                    fxsavedValue: (val) {
                      formSurname = val;
                    },
                  ),
                  AppTextFieldWidget(
                    labelText: "Phone number",
                    textInputType: TextInputType.phone,
                    fx: (val) {
                      if (val!.isEmpty) {
                        return "Phone Number is required";
                      }
                      if (val.length != 11) {
                        return "Valid number is required. 080xxxxxxxx";
                      }
                      return null;
                    },
                    fxsavedValue: (val) {
                      formNumber = val;
                    },
                  ),
                  AppTextFieldWidget(
                    labelText: "Email address",
                    textInputType: TextInputType.emailAddress,
                    fx: (val) {
                      if (val!.isEmpty) {
                        return "Email is required";
                      }
                      if (!val.contains("@")) {
                        return "Valid email is required";
                      }
                      return null;
                    },
                    fxsavedValue: (val) {
                      formEmail = val;
                    },
                  ),
                  AppTextFieldWidget(
                    labelText: "Cover letter",
                    maxLines: 6,
                    textInputType: TextInputType.text,
                    fx: (val) {
                      if (val!.isEmpty) {
                        return "KIndly type in your cover letter";
                      }

                      return null;
                    },
                    fxsavedValue: (val) {
                      formCover = val;
                    },
                  ),
                  GestureDetector(
                    onTap: pickpassport,
                    child: AppTextFieldWidget(
                      enabled: false,
                      labelText: "Passport upload",
                      trailingButton: Icon(Icons.attach_file),
                      //textInputType: TextInputType.phone,
                    ),
                  ),
                  GestureDetector(
                    onTap: pickresume,
                    child: AppTextFieldWidget(
                      enabled: false,
                      labelText: "Resume upload",
                      trailingButton: Icon(Icons.attach_file),
                    ),
                  ),
                  appButton(submitForm, "Submit", isloading: isloading),
                  verticalSpace(30.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickpassport() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      int sizeInBytes = file.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb > 0.1) {
        showmessage(context, "File size exceeds 2mb");
        return;
      }

      passport = file;
    }
  }

  Future<void> pickresume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      int sizeInBytes = file.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb > 2) {
        showmessage(context, "File size exceeds 2mb");
        return;
      }

      resumeFile = file;
    }
  }

  Future<void> submitForm() async {
    FocusScope.of(context).unfocus();
    var isvalid = formkey.currentState!.validate();
    if (!isvalid) {
      return;
    }
    formkey.currentState!.save();

    if (resumeFile == null || passport == null) {
      showmessage(context, "Resume and Passport files are both required");
      return;
    }

    setState(() {
      isloading = true;
    });

    final adduser = FirebaseFirestore.instance
        .collection('users')
        .doc(DateTime.now().toIso8601String());

    try {
      var passporturl = await uploadimagetoStorage(passport!);
      var resumeurl = await uploadimagetoStorage(resumeFile!);

      var data = {
        "firstname": formfirstname,
        "surname": formSurname,
        "phone": formNumber,
        "email": formEmail,
        "cover": formCover,
        "pass": passporturl,
        "resume": resumeurl,
      };

      await adduser.set(data);
      if (!mounted) return;
      showmessage(context, "Application Submitted", iserror: false);
      navigate(context, "/", replaceall: true, delayed: true);
    } on Exception catch (e) {
      showmessage(context, "Something went wrong");
    }

    setState(() {
      isloading = false;
    });
  }

  Future<String> uploadimagetoStorage(File file) async {
    UploadTask? uploadTask;
    final path = 'images/${DateTime.now().toIso8601String()}';
    //final f = file.path;

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snap = await uploadTask.whenComplete(() => null);
    final urldownloaded = await snap.ref.getDownloadURL();
    return urldownloaded;
  }
}

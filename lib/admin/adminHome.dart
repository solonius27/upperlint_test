import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:upperlint_test/helpers/cus_widgets.dart';
import 'package:upperlint_test/helpers/usersmodels.dart';

class AdminHome extends StatefulWidget {
  //const AdminHome({super.key});
  static const routeName = '/adminhome';

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List<UserModel> users = [];

  @override
  void initState() {
    doinit();
    super.initState();
  }

  bool pageloading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageloading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              shrinkWrap: true,
              itemBuilder: (ctx, i) => ListTile(
                title: appText(
                  users[i].fname!,
                  20,
                ),
                subtitle: appText(
                  users[i].phone!,
                  15,
                ),
                trailing: Image.network(users[i].passport!),
              ),
            ),
    );
  }

  Future<void> doinit() async {
    try {
      users = await FirebaseFirestore.instance.collection('users').get().then(
            (res) => res.docs.map((e) => UserModel.fromMap(e.data())).toList(),
            onError: (e) => print("Error completing: $e"),
          );
    } on Exception catch (e) {
      //showmessage(context, message)
    }

    setState(() {
      pageloading = false;
    });
  }
}

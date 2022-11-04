import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? fname;
  String? surname;
  String? email;
  String? phone;
  String? cover;
  String? resume;
  String? passport;
  UserModel({
    this.fname,
    this.surname,
    this.email,
    this.phone,
    this.cover,
    this.resume,
    this.passport,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fname: map['firstname'],
      surname: map['surname'],
      email: map['email'],
      phone: map['phone'],
      cover: map['cover'],
      resume: map['resume'],
      passport: map['pass'],
    );
  }
}

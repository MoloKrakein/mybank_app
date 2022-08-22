import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'main.dart';
import 'package:flutter/material.dart';

class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("Data Pengeluaran"),),);
  Stream<List<User>> readUser() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}

// Map<String, dynamic> toJson() => {
//         'id': id,
//         'name': name,
//         'kategori': kategori,
//         "harga": outval,
//         "tanggal":tanggal,
//         "jam":jam,
//       };
class User {
  String id;
  final String name;
  final int outval;
  final String kategori;
  final DateTime tanggal;
  final String jam;

  User({
    this.id = '',
    required this.name,
    required this.outval,
    required this.kategori,
    required this.tanggal,
    required this.jam,
  });


static User fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      kategori: json['kategori'],
      outval: json['harga'],
      tanggal: json['tanggal'],
      jam: json['jam'],
    );
}
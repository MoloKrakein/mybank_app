import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Data Pengeluaran"),
        ),
        floatingActionButton: FloatingActionButton(child: Icon(Icons.add_box),onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>const userPage()));}),
        body: StreamBuilder<List<User>>(stream: readUser(), builder: (context, snapshot) {
          if (snapshot.hasError){
            return Text('Woops somthing break this thing!\nError : '+snapshot.error.toString());
          }else if (snapshot.hasData){
            final users = snapshot.data!;
            return ListView(
              children: users.map(listBuilder).toList()
            );
          } else{
            return Row(
              children: [
                Center(child: Text("Loading...."),),
                CircularProgressIndicator()
              ],
            );
          }
        },),
      );
  Stream<List<User>> readUser() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}

Widget listBuilder(User user) => ListTile(
  leading: CircleAvatar(child: Icon(getIconFromTxt('${user.kategori}'))),
  title: Text(user.outval.toString()),
  subtitle: Text(user.name),
  // trailing: ,
);
// Map<String, dynamic> toJson() => {
//         'id': id,
//         'name': name,
//         'kategori': kategori,
//         "harga": outval,
//         "tanggal":tanggal,
//         "jam":jam,
//       };


IconData getIconFromTxt(String iconName){
  switch(iconName){
    case 'Food n Beverage':{
      return Icons.restaurant;
    }
    break;
    case 'Hutang':{
      return Icons.balance;
    }
    break;
    case 'Barang Pribadi':{
      return Icons.backpack;
    }break;
    default:{
      return Icons.add_box;
    }
    

  }
}

class User {
  String id;
  late Timestamp timestamp;
  final String name;
  final int outval;
  final String kategori;
  final String jam;

  User({
    this.id = '',
    required Timestamp,
    required this.name,
    required this.outval,
    required this.kategori,
    required this.jam,
    
  });

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        kategori: json['kategori'],
        outval: json['harga'],
        Timestamp: json['tanggal'],
        jam: json['jam'],
      );
}

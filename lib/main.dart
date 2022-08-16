import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: TextField(controller: controller),
          actions: [
            IconButton(
                onPressed: () {
                  final name = controller.text;
                  createUser(name: name);
                },
                icon: Icon(Icons.add))
          ],
        ),
      );
}

class userPage extends StatefulWidget {
  const userPage({Key? key}) : super(key: key);

  @override
  State<userPage> createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  @override
  Widget build(BuildContext context) =>
    Scaffold(appBar: AppBar(title: Text("Tambah Pengeluaran"),),
    body: ListView(
      padding: EdgeInsets.all(25),
      children: [],
    ),
    );
  
}

Future createUser({required String name}) async {
  int idgenerated = RNG();
  final docUser = FirebaseFirestore.instance.collection('users').doc(idgenerated.toString());

  final out = output(
    id: idgenerated.toString(),
    name: name,
    outval: 80,
  );
  final json = out.toJson();
  await docUser.set(json);
}

int RNG() {
  Random random = new Random();
  int rng = random.nextInt(10000);
  return rng;
}

class output {
  String id;
  final String name;
  final int outval;

  output({
    this.id = '',
    required this.name,
    required this.outval,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        "outval": outval,
      };
}

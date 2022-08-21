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
      home: const userPage(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//Tampilkan Data (Read)
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

        //   body: Center(child: IconButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>const userPage()));}, icon: Icon(Icons.arrow_forward))
        // ));
      );
}

class userPage extends StatefulWidget {
  const userPage({Key? key}) : super(key: key);

  @override
  State<userPage> createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  //Variabbel
  var kategori = <String>[
    'Kategori',
    'Food n Beverage',
    'Hutang',
    'Barang Pribadi',
    'Lain-lain'
  ];
  int kat = 0;
  String nama = '';
  String finalkategori = "";
  int value = 0;
  //Controller
  TextEditingController namaController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Tambah Pengeluaran"),
        ),
        body: ListView(
          padding: EdgeInsets.all(25),
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    //Namaewa
                    controller: namaController,
                    decoration:
                        const InputDecoration(hintText: 'Enter your name'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'name still empty';
                      }
                      return null;
                    },
                  ),
                  DropdownButton<String>(
                      icon: const Icon(Icons.arrow_drop_down),
                      style: const TextStyle(color: Colors.blue),
                      underline: Container(
                        color: Colors.blueAccent,
                      ),
                      value: kat == null ? null : kategori[kat],
                      items: kategori.map((String value) {
                        return new DropdownMenuItem(
                          child: new Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          finalkategori = value!;
                          kat = kategori.indexOf(value);
                        });
                      }),
                  TextFormField(
                    //Isinyaewa
                    controller: valueController,
                    decoration: const InputDecoration(hintText: 'Value'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'value still empty';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      child: Text("Submit"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text("Nama Value :"), Text(namaController.text),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Kategori Value :"), Text(finalkategori),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Harga Value :"), Text(valueController.text),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
}

Future createUser({required String name}) async {
  int idgenerated = RNG();
  final docUser = FirebaseFirestore.instance
      .collection('users')
      .doc(idgenerated.toString());

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

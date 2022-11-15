import 'package:first_app/second_page.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'mongodb.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {SecondPage.tag: (context) => const SecondPage()},
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
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final List _nameList = [
    "Gertrude",
    "Bernadette",
    "Simone",
    "Jacqueline",
    "	Françoise",
    "	Josétte",
    "Ta tante"
  ];
  final List _mailList = [
    "Gertrude@pigeon.voyageur.com",
    "Bernadette@fax.com",
    "Simone@fax.com",
    "Jacqueline@fax.fr"
  ];
  final List _imageList = [
    "https://previews.123rf.com/images/giorgiomtb/giorgiomtb1306/giorgiomtb130600057/20633244-tr%C3%A8s-vieille-femme-showhing-sa-f-doigt-sur-ses-deux-mains.jpg",
    "https://image.shutterstock.com/image-photo/blonde-old-lady-wear-pinl-260nw-2110990463.jpg",
    "https://thumbs.dreamstime.com/b/portrait-de-la-vieille-femme-greyhaired-tenant-des-dollars-dans-mains-%C3%A0-maison-173116084.jpg",
    "https://us.123rf.com/450wm/vbaleha/vbaleha1401/vbaleha140100373/25390614-sourire-vieille-femme-tenant-de-l-argent-sur-fond-blanc.jpg?ver=6"
  ];
  final List _birthdayList = [
    "23/03/1930",
    "04/09/1940",
    "18/05/1950",
    "03/12/1920",
    "22/09/1910"
  ];
  List<modal_card> cardList = [];

  @override
  void initState(){

    getUsers();
  }

  getUsers() async {
    cardList = await MongoDatabase.getUsers();
  }

  Future<void> _awaitReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SecondPage(),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      cardList = getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 12)),
            onPressed: () {
              _awaitReturnValueFromSecondScreen(context);
            },
            child: const Text("Second Page"),
          )
        ],
      ),
      body: Center(
          child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount: cardList.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.black,
            child: cardList[index],
          );
        },
      )),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

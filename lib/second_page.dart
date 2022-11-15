import 'dart:math';

import 'package:first_app/main.dart';
import 'package:flutter/material.dart';
import 'mongodb.dart';

class SecondPage extends StatefulWidget {
  static const tag = "second_page";

  const SecondPage({super.key});

  @override
  State<StatefulWidget> createState() => _MySecondPageState();
}

class _MySecondPageState extends State<SecondPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final birthdayController = TextEditingController();
  final List _imageList = [
    "https://previews.123rf.com/images/giorgiomtb/giorgiomtb1306/giorgiomtb130600057/20633244-tr%C3%A8s-vieille-femme-showhing-sa-f-doigt-sur-ses-deux-mains.jpg",
    "https://image.shutterstock.com/image-photo/blonde-old-lady-wear-pinl-260nw-2110990463.jpg",
    "https://thumbs.dreamstime.com/b/portrait-de-la-vieille-femme-greyhaired-tenant-des-dollars-dans-mains-%C3%A0-maison-173116084.jpg",
    "https://us.123rf.com/450wm/vbaleha/vbaleha1401/vbaleha140100373/25390614-sourire-vieille-femme-tenant-de-l-argent-sur-fond-blanc.jpg?ver=6"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Form page"),
        ),
        body: Center(
            child: Column(children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: mailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Mail',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: birthdayController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your birthday',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState!.validate()) {
                        var rand = Random();
                        var image = _imageList[rand.nextInt(_imageList.length)];

                        var bgColor = Color.fromARGB(255, rand.nextInt(254) + 1,
                            rand.nextInt(254) + 1, rand.nextInt(254) + 1);

                        var card = modal_card(
                            nameController.text,
                            mailController.text,
                            birthdayController.text,
                            image,
                            bgColor);

                        card.create();

                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ])));
  }
}

class modal_card extends StatelessWidget {
  final String name;
  final String mail;
  final String birthday;
  final String image;
  final Color bgColor;

  const modal_card(
      this.name, this.mail, this.birthday, this.image, this.bgColor,
      {super.key});

  create() {
    MongoDatabase.createUser(name, mail, birthday, image);
  }

  fromJson(Map<String, dynamic> json){
    var rand = Random();
    var bgColor = Color.fromARGB(255, rand.nextInt(254) + 1,
        rand.nextInt(254) + 1, rand.nextInt(254) + 1);

    return modal_card(json['name'], json['mail'], json['birthday'], json['image'], bgColor);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [bgColor.withOpacity(0.3),bgColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                image,
                width: 80.0,
              ),
              Column(
                children: [
                  Text(name),
                  Text(mail),
                  Text(birthday),
                ],
              ),
            ]),
      ),
    );
  }
}

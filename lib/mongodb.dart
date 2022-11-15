import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:first_app/second_page.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter/material.dart';
import 'constant.dart';

class MongoDatabase {
  static DbCollection? collection;

  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    collection = db.collection(COLLECTION_NAME);
  }


  static getUsers() async {
    List<Map<String, dynamic>>? users = await collection?.find().toList();
    List<modal_card> cardList = await test(users);

    return cardList;
  }

  static test(users) async {
    List<modal_card> cardList = [];
    await for (var user in users!){
      var rand = Random();
      var bgColor = Color.fromARGB(255, rand.nextInt(254) + 1,
          rand.nextInt(254) + 1, rand.nextInt(254) + 1);
      var card = modal_card(user["name"], user["mail"], user["birthday"], user["image"], bgColor);
      cardList.add(card);
    }
    return cardList;
  }

  static createUser(String name, String mail, String birthday, String image) async {
    await collection?.insertOne({
      "name": name,
      "email": mail,
      "birthday": birthday,
      "image": image,
    });

  }

}
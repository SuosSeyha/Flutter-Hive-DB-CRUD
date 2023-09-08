import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_db_flutter/model/person.dart';
class AddPersonController extends GetxController{
  late Box personBox;
  List<Map<dynamic,dynamic>> listPerson=[];
  Future<void> createPerson(Person person)async{
    personBox.add(person.toMap());
    debugPrint("Person created");
    readPerson();
    update();
  }
  Future<void> readPerson()async{
    final data = personBox.keys.map((key){
      final item = personBox.get(key);
      return {
        "key":key,
        "name":item["name"],
        "age":item["age"]
      };
    }).toList();
    listPerson = data.reversed.toList();
  }
  Future<void> updatePerson(int itemKey, Person person)async{
    personBox.put(itemKey, person.toMap());
    readPerson();
    debugPrint("Person updated");
    update();
  }
  Future<void> deletePerson(int itemKey)async{
    personBox.delete(itemKey);
    readPerson();
    debugPrint("Person deleted");
    update();
  }
  @override
  void onInit() {
    super.onInit();
    personBox = Hive.box("person");
    readPerson();
  }
}
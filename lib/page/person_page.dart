import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive_db_flutter/controller/add_person_controller.dart';
import 'package:hive_db_flutter/model/person_model.dart';
import 'package:hive_db_flutter/widget/person_detail.dart';
// ignore: must_be_immutable
class PersonPage extends StatelessWidget {
  PersonPage({super.key});
  AddPersonController controller = Get.put(AddPersonController());
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  void clearText(){
    nameController.clear();
    ageController.clear();
  }
  void showDialog(int? itemKey,Person? person){
    clearText();
    if(itemKey!=null){
     final updateItem = controller.listPerson.firstWhere((element) => element["key"]==itemKey);
     nameController.text=updateItem["name"];
     ageController.text=updateItem["age"].toString();
    }
    Get.defaultDialog(
      backgroundColor: Colors.grey,
      title: itemKey==null?"Create Person":"Update Person",
      content: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
          ),
          const SizedBox(height: 20,),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: ageController,
            decoration: InputDecoration(
              hintText: 'Age',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
          )
        ],
      ),
      onCancel: () {
        
      },
      onConfirm: () {
        if(itemKey==null){
          controller.createPerson(
            Person(
              name: nameController.text, 
              age: int.parse(ageController.text)
            )
          );
        }else{
          controller.updatePerson(
            itemKey,
            Person(
              name: nameController.text, 
              age: int.parse(ageController.text)
            )
          );
        }
        nameController.clear();
        ageController.clear();
        Get.back();
      },
      textConfirm: itemKey==null?"Create":"Update",
      buttonColor: Colors.amber,
      barrierDismissible: false
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text("HIVE DATABASE",style:  TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),),
      ),
      body: GetBuilder(
        init: AddPersonController(),
        builder: (controller){
          return ListView.builder(
            itemCount: controller.listPerson.length,
            itemBuilder: (context, index) {
              final data = controller.listPerson[index];
              return  Slidable(
                endActionPane: ActionPane(
                motion: const ScrollMotion(), 
                children: [
                  SlidableAction(
                    label: "update",
                    backgroundColor: Colors.orange,
                    icon: Icons.edit,
                    borderRadius: BorderRadius.circular(10),
                    onPressed: (contesxt){
                      showDialog(
                        data["key"],
                        Person.toList(data),
                      );
                    }
                  ),
                  const SizedBox(width: 10,),
                  SlidableAction(
                    label: "delete",
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                    borderRadius: BorderRadius.circular(10),
                    onPressed: (contesxt){
                      controller.deletePerson(data["key"]);
                    }
                  ),
                  const SizedBox(width: 10,),
                ]
              ),
                child: PersonDetail(
                  name: data["name"],
                  age: data["age"],
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showDialog(null,null);
        },
      ),
    );
  }
}
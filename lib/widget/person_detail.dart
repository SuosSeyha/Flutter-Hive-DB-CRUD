import 'package:flutter/material.dart';
class PersonDetail extends StatelessWidget {
  final String name;
  final int age;
  const PersonDetail({
    super.key,
    required this.name,
    required this.age,te
    });
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height/2*0.2,
      width: width,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5
      ),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(10)
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
          Text(
            age.toString(),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
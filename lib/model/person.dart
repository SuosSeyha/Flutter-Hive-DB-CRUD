class Person{
  final String name;
  final int age;

  Person({
    required this.name,
    required this.age
  });

  Map<dynamic,dynamic> toMap(){
    return {
      'name':name,
      'age':age
    };
  }
  Person.toList(Map<dynamic,dynamic> res)
  : name = res["name"],
    age = res["age"];
}
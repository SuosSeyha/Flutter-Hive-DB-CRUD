import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_db_flutter/page/homepage.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:hive_flutter/hive_flutter.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final dir =await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.initFlutter("person_db");
  await Hive.openBox("person");
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  PersonPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

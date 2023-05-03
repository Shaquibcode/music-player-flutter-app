import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'views/home.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return GetMaterialApp(
     theme: ThemeData(
       appBarTheme: const AppBarTheme(
         color: Colors.transparent,
         elevation: 0,
       ),
     ),
     debugShowCheckedModeBanner: false,
     title: 'Muzic',
     home: Home(),
   );
  }
}

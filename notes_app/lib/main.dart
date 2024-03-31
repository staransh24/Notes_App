import 'package:flutter/material.dart';
import 'package:notes_app/Pages/homepage.dart';
import 'package:notes_app/Provider/notes_provider.dart';
import 'package:notes_app/Theme/light_mode.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

   return MultiProvider(providers: [
     ChangeNotifierProvider(create: (context) => NotesProvider(),)
   ],
   child: MaterialApp(
     title: 'Flutter Demo',
     theme: lightMode,
     home: const HomePage(),
     debugShowCheckedModeBanner: false,
   ),);
  }
}


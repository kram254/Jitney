import 'package:flutter/material.dart';
import 'package:jitney/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:jitney/providers/app.dart';


void main (){
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AppProvider.initialize())
  ],
  child: MaterialApp (
    debugShowCheckedModeBanner: false,
    title:"Jitney",
    home: HomeScreen()),
    ));
}
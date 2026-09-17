import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:project_cybersim/widgets.dart';

void main()async{
  Directory appDataFolder = await getApplicationDocumentsDirectory();
  runApp(MyApp(
    appDataFolder: appDataFolder,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.appDataFolder,
  });
  final Directory appDataFolder;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project CyberSim',
      home: HomePage(
        appDataFolder: appDataFolder,
      ),
    );
  }
}
class HomePage extends StatelessWidget {
  const new({
    super.key,
    required this.appDataFolder,
  });
  final Directory appDataFolder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Column(
            spacing: 10,
            children: [
              SimpleButton(
                icon: Icons.flag, 
                text: "Add Country",
              ),
              //TODO: Display Countries
              Column(
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
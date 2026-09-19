import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:project_cybersim/country_dashboard.dart';
import 'package:project_cybersim/functions.dart';
import 'package:project_cybersim/resource_creator.dart';
import 'package:project_cybersim/widgets.dart';
import 'package:quickie/quickie.dart';

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
class HomePage extends StatefulWidget {
  const new({
    super.key,
    required this.appDataFolder,
  });
  final Directory appDataFolder;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> widgetize(){
    List<Map<String,dynamic>> countries = getCountries(appDataFolder: widget.appDataFolder);
    List<Widget> widgets = [];
    for(Map<String,dynamic> countryObject in countries){
      widgets.add(Country(
        appDataFolder: widget.appDataFolder, 
        countryObject: countryObject,
        reload: (){
          setState(() {
            
          });
        },
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        onPressed: (){
          //Resource Creator
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ResourceCreator(
              appDataFolder: widget.appDataFolder,
              resourceSelector: false,
            ),
          ));
        },
        child: Icon(
          Icons.oil_barrel,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Column(
            spacing: 10,
            children: [
              SimpleButton(
                icon: Icons.flag, 
                text: "Add Country",
                onTap: ()async{
                  String? countryName = await quickString(
                    context: context,
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    title: Text(
                      "Country Name",
                    ),
                  );
                  if(countryName != null && countryName.isNotEmpty){
                    countryName = countryName.trim();
                    createCountry(
                      appDataFolder: widget.appDataFolder, 
                      countryName: countryName,
                    );
                    setState(() {
                      
                    });
                  }
                },
              ),
              //Display Countries
              SingleChildScrollView(
                child: Column(
                  children: widgetize(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Country extends StatelessWidget {
  const new({
    super.key,
    required this.appDataFolder,
    required this.countryObject,
    required this.reload,
  });
  final Directory appDataFolder;
  final Map<String,dynamic> countryObject;
  final Function reload;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
        await Navigator.push(context, MaterialPageRoute(
          builder: (context) => CountryDashboard(
            appDataFolder: appDataFolder, 
            countryObject: countryObject,
          ),
        ));
        reload();
      },
      child: Row(
        spacing: 10,
        children: [
          Icon(
            Icons.chevron_right,
            color: Colors.redAccent,
          ),
          Text(
            countryObject["name"],
          ),
        ],
      ),
    );
  }
}
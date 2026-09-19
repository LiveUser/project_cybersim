import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_cybersim/infrastructure_creator.dart';
import 'package:project_cybersim/widgets.dart';
import 'package:raw_context/raw_context.dart';

class CountryDashboard extends StatefulWidget {
  const new({
    super.key,
    required this.appDataFolder,
    required this.countryObject,
  });
  final Directory appDataFolder;
  final Map<String,dynamic> countryObject;

  @override
  State<CountryDashboard> createState() => _CountryDashboardState();
}

class _CountryDashboardState extends State<CountryDashboard> {
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
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: Text(
                      widget.countryObject["name"],
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  RawContext(
                    items: [
                      RawContextItem(
                        onPressed: ()async{
                          //TODO: Create infrastructure
                          await Navigator.push(context, MaterialPageRoute(
                            builder: (context) => InfrastructureCreator(
                              appDataFolder: widget.appDataFolder,
                              countryObject: widget.countryObject,
                            ),
                          ));
                          setState(() {
                            
                          });
                        },
                        item: Text(
                          "Create infrastructure",
                        ),
                      ),
                      RawContextItem(
                        onPressed: (){
                          //TODO: View currently available resources
                        },
                        item: Text(
                          "Resources",
                        ),
                      ),
                      RawContextItem(
                        onPressed: (){
                          //TODO: Net production
                          
                        },
                        item: Text(
                          "Production analysis",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
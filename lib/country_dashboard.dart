import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_cybersim/widgets.dart';
import 'package:raw_context/raw_context.dart';

class CountryDashboard extends StatelessWidget {
  const new({
    super.key,
    required this.appDataFolder,
    required this.countryObject,
  });
  final Directory appDataFolder;
  final Map<String,dynamic> countryObject;

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
                      countryObject["name"],
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  RawContext(
                    items: [
                      RawContextItem(
                        onPressed: (){
                          //TODO: Create Utility page
                        },
                        item: Text(
                          "Utility",
                        ),
                      ),
                      RawContextItem(
                        onPressed: (){
                          //TODO: Create Mining page
                        },
                        item: Text(
                          "Mining",
                        ),
                      ),
                      RawContextItem(
                        onPressed: (){
                          //TODO: Create Utility page
                        },
                        item: Text(
                          "Production",
                        ),
                      ),
                      RawContextItem(
                        onPressed: (){
                          //TODO: Create Utility page
                        },
                        item: Text(
                          "Infrastructure",
                        ),
                      ),
                      RawContextItem(
                        onPressed: (){
                          //TODO: Create Utility page
                        },
                        item: Text(
                          "Resources",
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
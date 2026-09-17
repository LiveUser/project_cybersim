import 'package:flutter/material.dart';
import 'dart:io';
import 'package:project_cybersim/widgets.dart';
import 'package:quickie/quickie.dart';
import 'package:raw_context/raw_context.dart';
import 'functions.dart';

class ResourceCreator extends StatefulWidget {
  const new({
    super.key,
    required this.appDataFolder,
  });
  final Directory appDataFolder;

  @override
  State<ResourceCreator> createState() => _ResourceCreatorState();
}

class _ResourceCreatorState extends State<ResourceCreator> {
  List<Widget> widgetize(){
    List<Widget> widgets = [];
    List<Map<String,dynamic>> resourcesObjects = getAllResources(appDataFolder: widget.appDataFolder);
    for(Map<String,dynamic> resourceObject in resourcesObjects){
      widgets.add(Resource(
        appDataFolder: widget.appDataFolder,
        resourceObject: resourceObject,
      ));
    }
    return widgets;
  }
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
                icon: Icons.add_circle, 
                text: "Create Resource", 
                onTap: ()async{
                  String? newResourceName = await quickString(
                    context: context,
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    title: Text(
                      "Country Name",
                    ),
                  );
                  if(newResourceName != null && newResourceName.isNotEmpty){
                    createResource(
                      appDataFolder: widget.appDataFolder, 
                      resourceName: newResourceName,
                    );
                    setState(() {
                      
                    });
                  }
                },
              ),
              SingleChildScrollView(
                child: Column(
                  spacing: 10,
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
class Resource extends StatefulWidget {
  const new({
    super.key,
    required this.appDataFolder,
    required this.resourceObject,
  });
  final Directory appDataFolder;
  final Map<String,dynamic> resourceObject;

  @override
  State<Resource> createState() => _ResourceState();
}

class _ResourceState extends State<Resource> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 10,
      children: [
        Icon(
          Icons.chevron_right,
          color: Colors.redAccent,
        ),
        Text(
          widget.resourceObject["resource_name"],
        ),
        RawContext(
          items: [
            //TODO: Change type of unit
            RawContextItem(
              onPressed: (){
                widget.resourceObject["unit"] = "unit";
                changeUnit(
                  appDataFolder: widget.appDataFolder, 
                  uuid: widget.resourceObject["uuid"], 
                  newUnit: widget.resourceObject["unit"],
                );
                setState(() {
                  
                });
              }, 
              item: Text(
                "unit",
              ),
            ),
            RawContextItem(
              onPressed: (){
                widget.resourceObject["unit"] = "kg";
                changeUnit(
                  appDataFolder: widget.appDataFolder, 
                  uuid: widget.resourceObject["uuid"], 
                  newUnit: widget.resourceObject["unit"],
                );
                setState(() {
                  
                });
              }, 
              item: Text(
                "kg",
              ),
            ),
            RawContextItem(
              onPressed: (){
                widget.resourceObject["unit"] = "liters";
                changeUnit(
                  appDataFolder: widget.appDataFolder, 
                  uuid: widget.resourceObject["uuid"], 
                  newUnit: widget.resourceObject["unit"],
                );
                setState(() {
                  
                });
              }, 
              item: Text(
                "liters",
              ),
            ),
          ],
          child: Text(
            "Unit: ${widget.resourceObject["unit"]}",
          ),
        ),
        SizedBox(
          width: 100,
          child: SimpleButton(
            icon: Icons.delete, 
            text: "Delete", 
            onTap: (){
              //TODO: Warn about the potential to break the program and allow deleting the resource
              
            },
          ),
        ),
      ],
    );
  }
}
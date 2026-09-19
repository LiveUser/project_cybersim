// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:objective_db/objective_db.dart';
import 'dart:io';
import 'package:project_cybersim/widgets.dart';
import 'package:quickie/quickie.dart';
import 'package:raw_context/raw_context.dart';
import 'functions.dart';

class ResourceCreator extends StatefulWidget {
  const new({
    super.key,
    required this.appDataFolder,
    required this.resourceSelector,
  });
  final Directory appDataFolder;
  final bool resourceSelector;

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
        resourceSelector: widget.resourceSelector,
        delete: (uuid){
          Entry entry = Entry(dbPath: widget.appDataFolder.path);
          entry.select().delete(key: "all_resources", uuid: uuid);
        },
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
    required this.resourceSelector,
    required this.delete,
  });
  final Directory appDataFolder;
  final Map<String,dynamic> resourceObject;
  final bool resourceSelector;
  final Function(String uuid) delete;

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
            //Change type of unit
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
            RawContextItem(
              onPressed: (){
                widget.resourceObject["unit"] = "watts";
                changeUnit(
                  appDataFolder: widget.appDataFolder, 
                  uuid: widget.resourceObject["uuid"], 
                  newUnit: widget.resourceObject["unit"],
                );
                setState(() {
                  
                });
              }, 
              item: Text(
                "watts",
              ),
            ),
          ],
          child: Text(
            "Unit: ${widget.resourceObject["unit"]}",
          ),
        ),
        widget.resourceSelector != true ? SizedBox() : SizedBox(
          width: 100,
          child: SimpleButton(
            icon: Icons.add_task, 
            text: "Select", 
            onTap: ()async{
              //Warn about the potential to break the program and allow deleting the resource
              double? amount = await quickDouble(
                context: context,
                title: Text(
                  "How many ${widget.resourceObject["resource_name"]} ${widget.resourceObject["unit"]} per hour?",
                ),
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              );
              if(amount != null){
                Navigator.pop(context,{
                  "resource-uuid": widget.resourceObject["uuid"],
                  "amount": amount,
                });
              }
            },
          ),
        ),
        RawContext(
          items: [
            RawContextItem(
              onPressed: ()async{
                //Warn about the potential to break the program and allow deleting the resource
                bool? shouldDelete = await quickConfirm(
                  context: context,
                  title: Text(
                    "Are you sure you want to delete ${widget.resourceObject["resource_name"]}?",
                  ),
                  body: Text(
                    "This may break the program if other components depend on it.",
                  ),
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                );
                if(shouldDelete == true){
                  widget.delete(widget.resourceObject["uuid"]);
                }
              }, 
              item: Text(
                "Delete",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
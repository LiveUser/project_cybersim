import 'dart:io';
import 'package:flutter/material.dart';
import 'package:objective_db/objective_db.dart';
import 'package:project_cybersim/functions.dart';
import 'package:project_cybersim/infrastructure_creator.dart';
import 'package:project_cybersim/widgets.dart';
import 'package:quickie/quickie.dart';
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
  List<Widget> widgetize(){
    List<Widget> widgets = [];
    List<DbObject> infrastructure = getInfrastructure(appDataFolder: widget.appDataFolder, countryUUID: widget.countryObject["uuid"]);
    for(DbObject reference in infrastructure){
      widgets.add(InfrastructureViewer(
        appDataFolder: widget.appDataFolder,
        countryObject: widget.countryObject,
        infrastructureObject: reference.view(),
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
              //TODO: Display Infrastructure Here
              Column(
                spacing: 10,
                children: widgetize(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class InfrastructureViewer extends StatefulWidget {
  const new({
    super.key,
    required this.appDataFolder,
    required this.countryObject,
    required this.infrastructureObject,
  });
  final Directory appDataFolder;
  final Map<String,dynamic> countryObject;
  final Map<String,dynamic> infrastructureObject;

  @override
  State<InfrastructureViewer> createState() => _InfrastructureViewerState();
}

class _InfrastructureViewerState extends State<InfrastructureViewer> {
  bool dropDown = false;
  bool deleted = false;

  List<Widget> displayIO({
    required String type,
  }){
    List<Widget> widgets = [];
    for(Map<String,dynamic> ioObject in widget.infrastructureObject[type]){
      DbObject dbObject = DbObject(uuid: ioObject["uuid"], dbPath: widget.appDataFolder.path, cipherKeys: null);
      widgets.add(IoViewer(
        appDataFolder: widget.appDataFolder, 
        ioObject: dbObject.view(),
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return deleted ? SizedBox() : GestureDetector(
      onTap: (){
        setState(() {
          dropDown = !dropDown;
        });
      },
      onLongPress: ()async{
        bool? shouldDelete = await quickConfirm(
          context: context,
          title: Text(
            "Are you sure you want to delete ${widget.infrastructureObject["infrastructure-name"]}?",
          )
        );
        if(shouldDelete == true){
          deleteInfrastructure(
            appDataFolder: widget.appDataFolder, 
            countryUUID: widget.countryObject["uuid"], 
            infrastructureUUID: widget.infrastructureObject["uuid"],
          );
          setState(() {
            deleted = true;
          });
        }
      },
      child: Container(
        width: double.infinity,
        color: Colors.redAccent,
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: Text(
                    widget.infrastructureObject["infrastructure-name"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Icon(
                  dropDown ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                  color: Colors.white,
                ),
              ],
            ),
            !dropDown ? SizedBox() : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Inputs:",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Column(
                  children: displayIO(type: "inputs"),
                ),
                Text(
                  "Outputs:",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Column(
                  children: displayIO(type: "outputs"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class IoViewer extends StatelessWidget {
  const new({
    super.key,
    required this.appDataFolder,
    required this.ioObject,
  });
  final Directory appDataFolder;
  final Map<String,dynamic> ioObject;
  
  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> resourceObject = getObject(appDataFolder: appDataFolder, uuid: ioObject["resource-uuid"]);

    return Row(
      spacing: 10,
      children: [
        Icon(
          Icons.chevron_right,
          color: Colors.white,
        ),
        Text(
          "${resourceObject["resource_name"]} ${ioObject["amount"]}${resourceObject["unit"]}/hour",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
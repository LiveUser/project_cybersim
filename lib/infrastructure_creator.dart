import 'package:flutter/material.dart';
import 'package:project_cybersim/functions.dart';
import 'package:project_cybersim/widgets.dart';
import 'dart:io';
import 'resource_creator.dart';

//TODO: Set inputs, outputs and a name to identify the facilities
class InfrastructureCreator extends StatefulWidget {
  const new({
    super.key,
    required this.appDataFolder,
    required this.countryObject,
  });
  final Directory appDataFolder;
  final Map<String,dynamic> countryObject;

  @override
  State<InfrastructureCreator> createState() => _InfrastructureCreatorState();
}

class _InfrastructureCreatorState extends State<InfrastructureCreator> {
  TextEditingController infrastructureName = TextEditingController();
  Map<String,dynamic> infrastructureObject = {
    "infrastructure-name": "",
    "inputs": [],
    "outputs": [],
  };

  List<Widget> displayIO({
    required String type,
  }){
    List<Widget> widgets = [];
    for(int i = 0; i < (infrastructureObject[type] as List).length; i++){
      Map<String,dynamic> ioObject = (infrastructureObject[type] as List)[i];
      widgets.add(IoDisplayer(
        index: i,
        appDataFolder: widget.appDataFolder, 
        ioObject: ioObject,
        remove: (index) {
          (infrastructureObject[type] as List).removeAt(index);
          setState(() {
            
          });
        },
      ));
    }
    return widgets;
  }
  
  @override
  void initState(){
    super.initState();
    infrastructureName.addListener((){
      infrastructureObject.addAll({
        "infrastructure-name": infrastructureName.text,
      });
    });
  }

  @override
  void dispose(){
    super.dispose();
    infrastructureName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              //Infrastructure Name
              TextField(
                controller: infrastructureName,
                decoration: InputDecoration(
                  label: Text(
                    "Infrastructure Name",
                  ),
                ),
              ),
              //Input
              SimpleButton(
                icon: Icons.input, 
                text: "Select resource inputs", 
                onTap: ()async{
                  //Reuse resource creator for selecting resources
                  Map<String,dynamic>? resource = await Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ResourceCreator(
                      appDataFolder: widget.appDataFolder,
                      resourceSelector: true,
                    ),
                  ));
                  if(resource != null){
                    (infrastructureObject["inputs"] as List).add(resource);
                    setState(() {

                    });
                  }
                },
              ),
              Text(
                "Inputs:",
              ),
              Column(
                children: displayIO(type: "inputs"),
              ),
              //Output
              SimpleButton(
                icon: Icons.output, 
                text: "Select resource outputs", 
                onTap: ()async{
                  //Reuse resource creator for selecting resources
                  Map<String,dynamic>? resource = await Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ResourceCreator(
                      appDataFolder: widget.appDataFolder,
                      resourceSelector: true,
                    ),
                  ));
                  if(resource != null){
                    (infrastructureObject["outputs"] as List).add(resource);
                    setState(() {

                    });
                  }
                },
              ),
              Text(
                "Outputs:",
              ),
              Column(
                children: displayIO(type: "outputs"),
              ),
              SimpleButton(
                icon: Icons.add_business, 
                text: "Create", 
                onTap: (){
                  //Create infrastructure
                  if(infrastructureName.text.isNotEmpty){
                    addInfrastructure(
                      appDataFolder: widget.appDataFolder, 
                      uuid: widget.countryObject["uuid"], 
                      infrastructureObject: infrastructureObject,
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class IoDisplayer extends StatelessWidget {
  const new({
    super.key,
    required this.index,
    required this.appDataFolder,
    required this.ioObject,
    required this.remove,
  });
  final int index;
  final Directory appDataFolder;
  final Map<String,dynamic> ioObject;
  final Function(int index) remove;
  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> resourceObject = getObject(appDataFolder: appDataFolder, uuid: ioObject["resource-uuid"]);

    return Row(
      spacing: 10,
      children: [
        Icon(
          Icons.chevron_right,
          color: Colors.redAccent,
        ),
        Expanded(
          child: Text(
            "${resourceObject["resource_name"]} ${ioObject["amount"]} ${resourceObject["unit"]}/hour",
          ),
        ),
        GestureDetector(
          onTap: (){
            remove(index);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.redAccent,
            child: Text(
              "remove",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
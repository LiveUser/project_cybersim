import 'dart:io';
import 'package:objective_db/objective_db.dart';

void createResource({
  required Directory appDataFolder,
  required String resourceName,
}){
  Entry entry = Entry(dbPath: appDataFolder.path);
  entry.select().insert(
    key: "all_resources", 
    value: [
      {
        "resource_name": resourceName,
        "unit": "unit",
      }
    ],
  );
}

List<Map<String,dynamic>> getAllResources({
  required Directory appDataFolder,
}){
  List<Map<String,dynamic>> allResources = [];
  try{
    Entry entry = Entry(dbPath: appDataFolder.path);
    List<DbObject> allResourcesReferences = entry.select().selectMultiple(key: "all_resources");
    for(DbObject reference in allResourcesReferences){
      allResources.add(reference.view());
    }
  }catch(error){
    //Do nothing
  }
  return allResources;
}

void changeUnit({
  required Directory appDataFolder,
  required String uuid,
  required String newUnit,
}){
  DbObject resource = DbObject(
    uuid: uuid, 
    dbPath: appDataFolder.path, 
    cipherKeys: null,
  );
  resource.insert(
    key: "unit", 
    value: newUnit,
  );
}

void createCountry({
  required Directory appDataFolder,
  required String countryName,
}){
  Entry entry = Entry(dbPath: appDataFolder.path);
  entry.select().insert(
    key: "countries",
    value: [
      {
        "name": countryName,
        //Basic Utitilities (Consumes Resources to produce basics like electricity and water)
        "utilities": [],
        //Inputs resources into the system (Assume extracting costs nothing at first for simplicity)
        "mining": [],
        //Production (takes resources as input outputs another resource)
        "production": [],
        //Infrastructure (consumes resources but produces no output, example: residential, offices)
        "infrastructure": [],
        //Resources (Map of available outputed resources)
        "resources": [],
      }
    ],
  );
}

List<Map<String,dynamic>> getCountries({
  required Directory appDataFolder,
}){
  List<Map<String,dynamic>> countries = [];
  try{
    Entry entry = Entry(dbPath: appDataFolder.path);
    List<DbObject> countriesReferences = entry.select().selectMultiple(key: "countries");
    for(DbObject reference in countriesReferences){
      countries.add(reference.view());
    }
  }catch(error){
    //Do nothing
  }
  return countries;
}

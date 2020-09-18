import 'dart:convert';
import 'dart:io';

import 'package:cohoresourceapp_android/data/model/organization_level_model.dart';
import 'package:cohoresourceapp_android/widgets/categories.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path_provider/path_provider.dart';

import '../model/fulldatabase_model.dart';
import '../model/category_model.dart';
import '../model/county_model.dart';
import '../model/resource_model.dart';

abstract class CohoRepo {
  Future<FullDatabaseModel> fetchFullDatabase();

  Future<List<CategoryModel>> fetchAllCategories();

  Future<List<CountyModel>> fetchAllCounties();

  Future<List<ResourceModel>> fetchResourcesOfCategory(CategoryModel category);

  Future<List<ResourceModel>> fetchResourcesOfCounty(CountyModel county);
}

class FullDatabaseRepo implements CohoRepo {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.reference();

  Future<FullDatabaseModel> fetchFullDatabase() {
    return _databaseRef.once().then((DataSnapshot snapshot) {
      // todo process all the crappp
      return FullDatabaseModel(
        categories: [],
        resources: [],
        counties: [],
      );
    });
  }

  @override
  Future<List<CountyModel>> fetchAllCounties() {
    return _databaseRef
        .child("counties")
        .orderByChild("name")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> dynMap = snapshot.value;
      List<CountyModel> counties = [];
      dynMap.forEach((key, value) {
        counties.add(CountyModel.countyFromDynMap(value));
      });

      return counties;
    });
  }

  @override
  Future<List<CategoryModel>> fetchAllCategories() {
    return _databaseRef
        .child("categories")
        .orderByChild("name")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> dynMap = snapshot.value;
      List<CategoryModel> categories = [];
      dynMap.forEach((key, value) {
        categories.add(CategoryModel.categoryFromDynMap(value));
      });

      return categories;
    });
  }

  @override
  Future<List<ResourceModel>> fetchResourcesOfCategory(CategoryModel category) {
    int catId = category.id;

    return _databaseRef
        .child("resources")
        .once()
        .then((DataSnapshot snapshot) {
          print('Firebase snapshot collected...');
      Map<dynamic, dynamic> dynMap = snapshot.value;

      List<ResourceModel> resources = [];

      print('building ${dynMap.length} resources...');
      dynMap.forEach((key, value) {
        ResourceModel resource = ResourceModel.resourceFromDynMap(value);
        if (resource.categoryIDs.contains(catId)) {
          resources.add(resource);
        }
      });

      return resources;
    });
  }

  @override
  Future<List<ResourceModel>> fetchResourcesOfCounty(CountyModel county) {
    int countyID = county.id;

    return _databaseRef
        .child("resources")
        .orderByChild("name")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> dynMap = snapshot.value;

      List<ResourceModel> resources = [];

      dynMap.forEach((key, value) {
        ResourceModel resource = ResourceModel.resourceFromDynMap(value);
        if (resource.countyIDs.contains(countyID)) {
          resources.add(resource);
        }
      });

      return resources;
    });
  }

  Future<List<ResourceModel>> fetchResourcesOfParent(OrganizationLevelModel parent) {
    if (parent is CategoryModel) {
      return fetchResourcesOfCategory(parent);
    } else if (parent is CountyModel){
      return fetchResourcesOfCounty(parent);
    } else { // this shouldn't ever happen
      List<ResourceModel> emptyList = [];
      return Future.value(emptyList);
    }
  }

  void _saveCategories(List<CategoryModel> categories) {
    List<Map<dynamic, dynamic>> categoriesMap = [];

    categories.forEach((category) {
      categoriesMap.add(category.toDynMap());
    });

    String categoriesJSON = jsonEncode(categoriesMap);

    getApplicationDocumentsDirectory().then((directory) {
      final file = File('${directory.path}/categories.json');
      file.writeAsString(categoriesJSON).then((value) {
        print("saved");
      },
          onError: (e) {
            print("error saving file");
          });
    });

    print('saved');
  }

  Future<List<CategoryModel>> _readCategories() async {
    Directory dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/categories.json');
    String text = await file.readAsString();

    dynamic categoriesJSON = jsonDecode(text);

    List<dynamic> listObj = List.from(categoriesJSON);
    List<CategoryModel> categories = [];

    listObj.forEach((dynElement) {
      categories.add(CategoryModel.categoryFromDynMap(dynElement));
    });

    return categories;
  }

  void _saveCounties(List<CountyModel> counties) {
    List<Map<dynamic, dynamic>> countiesMap = [];

    counties.forEach((county) {
      countiesMap.add(county.toDynMap());
    });

    String countiesJSON = jsonEncode(countiesMap);

    getApplicationDocumentsDirectory().then((directory) {
      final file = File('${directory.path}/counties.json');
      file.writeAsString(countiesJSON).then((value) {
        print("saved");
      },
          onError: (e) {
            print("error saving file");
          });
    });

    print('saved');
  }

  Future<List<CountyModel>> _readCounties() async {
    Directory dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/counties.json');
    String text = await file.readAsString();

    dynamic countiesJSON = jsonDecode(text);

    List<dynamic> listObj = List.from(countiesJSON);
    List<CountyModel> counties = [];

    listObj.forEach((dynElement) {
      counties.add(CategoryModel.categoryFromDynMap(dynElement));
    });

    return counties;
  }

  void _saveResources(List<ResourceModel> resources) {
    List<Map<dynamic, dynamic>> resourcesMap = [];

    resources.forEach((resource) {
      resourcesMap.add(resource.toDynMap());
    });

    String resourcesJSON = jsonEncode(resourcesMap);

    getApplicationDocumentsDirectory().then((directory) {
      final file = File('${directory.path}/resources.json');
      file.writeAsString(resourcesJSON).then((value) {
        print("saved");
      },
          onError: (e) {
            print("error saving file");
          });
    });

    print('saved');
  }

  Future<List<ResourceModel>> _readResources() async {
    Directory dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/resources.json');
    String text = await file.readAsString();

    dynamic resourcesJSON = jsonDecode(text);

    List<dynamic> listObj = List.from(resourcesJSON);
    List<ResourceModel> resources = [];

    listObj.forEach((dynElement) {
      resources.add(ResourceModel.resourceFromDynMap(dynElement));
    });

    return resources;
  }
}

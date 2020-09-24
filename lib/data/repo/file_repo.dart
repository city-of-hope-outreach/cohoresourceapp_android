import 'dart:convert';
import 'dart:io';

import 'package:cohoresourceapp_android/data/model/category_model.dart';
import 'package:cohoresourceapp_android/data/model/county_model.dart';
import 'package:cohoresourceapp_android/data/model/resource_model.dart';
import 'package:path_provider/path_provider.dart';

class FileRepo {
    void saveCategories(List<CategoryModel> categories) {
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

    Future<List<CategoryModel>> readCategories() async {
        try {
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
        } catch (e) {
          return Future.error("Cannot read file");
        }
    }

    void saveCounties(List<CountyModel> counties) {
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

    Future<List<CountyModel>> readCounties() async {
        try {
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
        } catch (e) {
            return Future.error("Cannot read file");
        }
    }

    void saveResources(List<ResourceModel> resources) {
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

    Future<List<ResourceModel>> readResources() async {
        try {
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
        } catch (e) {
          return Future.error("Cannot read file");
        }
    }
}
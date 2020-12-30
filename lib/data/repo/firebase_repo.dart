import 'package:cohoresourceapp_android/data/model/category_model.dart';
import 'package:cohoresourceapp_android/data/model/county_model.dart';
import 'package:cohoresourceapp_android/data/model/resource_model.dart';
import 'package:cohoresourceapp_android/data/repo/file_repo.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRepo {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.reference();
  final FileRepo _fileRepo;
  final int _timeout = 12;

  FirebaseRepo(this._fileRepo);

  Future<List<CountyModel>> fetchAllCountiesFromFirebase() {
    return _databaseRef.child("counties").orderByChild("name").once().then(
        (DataSnapshot snapshot) {
      Map<dynamic, dynamic> dynMap = snapshot.value;
      List<CountyModel> counties = [];
      dynMap.forEach((key, value) {
        counties.add(CountyModel.countyFromDynMap(value));
      });

      _fileRepo.saveCounties(counties);
      return counties;
    }, onError: (error) {
      throw ("Database Error");
    }).timeout(Duration(seconds: _timeout), onTimeout: () {
      throw ("Connection Timed Out");
    });
  }

  Future<List<CategoryModel>> fetchAllCategoriesFromFirebase() {
    return _databaseRef.child("categories").orderByChild("name").once().then(
        (DataSnapshot snapshot) {
      Map<dynamic, dynamic> dynMap = snapshot.value;
      List<CategoryModel> categories = [];
      dynMap.forEach((key, value) {
        categories.add(CategoryModel.categoryFromDynMap(value));
      });

      _fileRepo.saveCategories(categories);
      return categories;
    }, onError: (error) {
      throw ("Database Error");
    }).timeout(Duration(seconds: _timeout), onTimeout: () {
      throw ("Connection Timed Out");
    });
  }

  Future<List<ResourceModel>> fetchAllResourcesFromFirebase() {
    return _databaseRef.child("resources").once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> dynMap = snapshot.value;

      List<ResourceModel> resources = [];

      dynMap.forEach((key, value) {
        ResourceModel resource = ResourceModel.resourceFromDynMap(value);
        resources.add(resource);
      });

      _fileRepo.saveResources(resources);
      return resources;
    }, onError: (error) {
      throw ("Database Error");
    }).timeout(Duration(seconds: _timeout), onTimeout: () {
      throw ("Connection Timed Out");
    });
  }
}

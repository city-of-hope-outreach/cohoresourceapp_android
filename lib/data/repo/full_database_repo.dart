import 'package:cohoresourceapp_android/data/model/full_database_model.dart';
import 'package:cohoresourceapp_android/data/model/organization_level_model.dart';
import 'package:cohoresourceapp_android/data/repo/file_repo.dart';
import 'package:cohoresourceapp_android/data/repo/firebase_repo.dart';
import 'package:connectivity/connectivity.dart';

import '../model/category_model.dart';
import '../model/county_model.dart';
import '../model/resource_model.dart';

abstract class CohoRepo {
  Future<List<CategoryModel>> fetchAllCategories();

  Future<List<CountyModel>> fetchAllCounties();

  Future<List<ResourceModel>> fetchResourcesOfCategory(CategoryModel category);

  Future<List<ResourceModel>> fetchResourcesOfCounty(CountyModel county);
}

class FullDatabaseRepo implements CohoRepo {
  FileRepo _fileRepo;
  FirebaseRepo _firebaseRepo;
  FullDatabaseModel _databaseModel;


  FullDatabaseRepo() {
    _fileRepo = FileRepo();
    _firebaseRepo = FirebaseRepo(_fileRepo);
    _databaseModel = FullDatabaseModel();
  }

  Future<FullDatabaseModel> fetchEverything() async {
    if (_databaseModel.loaded) {
      return _databaseModel;
    } else {
      try {
        ConnectivityResult connectivityResult =
            await Connectivity().checkConnectivity();

        if (connectivityResult == ConnectivityResult.none) {
          List<Future<dynamic>> futures = [
            _fileRepo
                .readCategories()
                .then((value) => _databaseModel.categories = value),
            _fileRepo
                .readCounties()
                .then((value) => _databaseModel.counties = value),
            _fileRepo
                .readResources()
                .then((value) => _databaseModel.resources = value)
          ];

          await Future.wait(futures);
        } else {
          List<Future<dynamic>> futures = [
            _firebaseRepo
                .fetchAllCategoriesFromFirebase()
                .then((value) => _databaseModel.categories = value)
                .catchError((e) => _fileRepo
                    .readCategories()
                    .then((value) => _databaseModel.categories = value)),
            _firebaseRepo
                .fetchAllCountiesFromFirebase()
                .then((value) => _databaseModel.counties = value)
                .catchError((e) => _fileRepo
                    .readCounties()
                    .then((value) => _databaseModel.counties = value)),
            _firebaseRepo
                .fetchAllResourcesFromFirebase()
                .then((value) => _databaseModel.resources = value)
                .catchError((e) => _fileRepo
                    .readResources()
                    .then((value) => _databaseModel.resources = value))
          ];

          await Future.wait(futures);
        }

        _databaseModel.loaded = true;
        return _databaseModel;
      } catch (e) {
        return Future.error("Could not load data: $e");
      }
    }
  }

  @override
  Future<List<CountyModel>> fetchAllCounties() async {
    try {
      await fetchEverything();
      return _databaseModel.counties;
    } catch (e) {
      return Future.error("Could not load counties: $e");
    }
  }

  @override
  Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      await fetchEverything();
      return _databaseModel.categories;
    } catch (e) {
      return Future.error("Could not load categories: $e");
    }
  }

  @override
  Future<List<ResourceModel>> fetchResourcesOfCategory(CategoryModel category) async {
    await fetchEverything();
    int catId = category.id;
    return _databaseModel.resources.where((element) => element.categoryIDs.contains(catId)).toList();
  }

  @override
  Future<List<ResourceModel>> fetchResourcesOfCounty(CountyModel county) async {
    await fetchEverything();
    int countyID = county.id;
    return _databaseModel.resources.where((element) => element.countyIDs.contains(countyID)).toList();
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

  Future<List<ResourceModel>> searchResources(String query) async {
    if (!_databaseModel.loaded) {
      await fetchEverything();
    }

    List<String> queries = query.split(' ');

    List<ResourceModel> filteredResources = [];

    // prioritize name first
    _databaseModel.resources.forEach((res) {
      queries.forEach((str) {
        if (res.name.toLowerCase().contains(str.toLowerCase())
            && !filteredResources.contains(res)) {
          filteredResources.add(res);
        }
      });
    });

    // tags
    _databaseModel.resources.forEach((res) {
      queries.forEach((str) {
        if (res.tags.toLowerCase().contains(str.toLowerCase())
            && !filteredResources.contains(res)) {
          filteredResources.add(res);
        }
      });
    });

    // description
    _databaseModel.resources.forEach((res) {
      queries.forEach((str) {
        if (res.description.toLowerCase().contains(str.toLowerCase())
            && !filteredResources.contains(res)) {
          filteredResources.add(res);
        }
      });
    });

    // services
    _databaseModel.resources.forEach((res) {
      queries.forEach((str) {
        if (res.services.toLowerCase().contains(str.toLowerCase())
            && !filteredResources.contains(res)) {
          filteredResources.add(res);
        }
      });
    });

    // services
    _databaseModel.resources.forEach((res) {
      queries.forEach((str) {
        if (res.services.toLowerCase().contains(str.toLowerCase())
            && !filteredResources.contains(res)) {
          filteredResources.add(res);
        }
      });
    });

    return filteredResources;
  }
}

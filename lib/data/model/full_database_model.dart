import 'package:cohoresourceapp_android/data/model/category_model.dart';
import 'package:cohoresourceapp_android/data/model/resource_model.dart';

import 'county_model.dart';

class FullDatabaseModel {
    List<ResourceModel> resources = [];
    List<CountyModel> counties = [];
    List<CategoryModel> categories = [];

    bool loaded = false;
}
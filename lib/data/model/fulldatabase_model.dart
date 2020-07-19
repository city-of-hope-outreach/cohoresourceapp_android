import 'package:equatable/equatable.dart';

import './resource_model.dart';
import './category_model.dart';
import './county_model.dart';

class FullDatabaseModel extends Equatable{
    final List<CategoryModel> categories;
    final List<CountyModel> counties;
    final List<ResourceModel> resources;

  FullDatabaseModel({this.categories, this.counties, this.resources});

  @override
  List<Object> get props => [categories, counties, resources];
}
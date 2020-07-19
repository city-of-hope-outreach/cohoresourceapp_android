import '../data/model/organization_level_model.dart';
import '../data/model/category_model.dart';
import '../data/model/county_model.dart';
import '../data/model/resource_model.dart';

import 'package:equatable/equatable.dart';

abstract class CohoDatabaseState extends Equatable {
  const CohoDatabaseState();
}

class LoadingState extends CohoDatabaseState {
  const LoadingState();
  @override
  List<Object> get props => [];
}

class CategoriesLoadedState extends CohoDatabaseState {
  final List<CategoryModel> categories;

  CategoriesLoadedState(this.categories);

  @override
  List<Object> get props => [categories];
}

class CountiesLoadedState extends CohoDatabaseState {
  final List<CountyModel> counties;

  CountiesLoadedState(this.counties);

  @override
  List<Object> get props => [counties];
}

class ResourcesLoadedState extends CohoDatabaseState {
  final List<ResourceModel> resources;
  final OrganizationLevelModel parent;

  ResourcesLoadedState({this.resources, this.parent});

  @override
  List<Object> get props => [resources, parent];
}

class ResourceDetailState extends CohoDatabaseState {
  final ResourceModel resource;

  ResourceDetailState(this.resource);

  @override
  List<Object> get props => [resource];
}
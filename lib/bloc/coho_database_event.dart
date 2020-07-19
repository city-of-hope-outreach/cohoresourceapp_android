import 'package:cohoresourceapp_android/data/model/organization_level_model.dart';

import '../data/model/category_model.dart';
import '../data/model/county_model.dart';
import '../data/model/resource_model.dart';
import 'package:equatable/equatable.dart';

abstract class CohoDatabaseEvent extends Equatable {
  const CohoDatabaseEvent();
}

class DataLoadingEvent extends CohoDatabaseEvent {
  @override
  List<Object> get props => [];

}

class CategoriesLoadingEvent extends CohoDatabaseEvent {
  @override
  List<Object> get props => [];

}

class CountiesLoadingEvent extends CohoDatabaseEvent {
  @override
  List<Object> get props => [];

}

class ResourcesLoadingEvent extends CohoDatabaseEvent {
  final OrganizationLevelModel parent;

  ResourcesLoadingEvent({this.parent});

  @override
  List<Object> get props => [parent];
}

class ResourceDetailEvent extends CohoDatabaseEvent {
  final ResourceModel resource;

  ResourceDetailEvent(this.resource);

  @override
  List<Object> get props => [resource];
}
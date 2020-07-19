import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cohoresourceapp_android/data/model/county_model.dart';
import '../data/model/organization_level_model.dart';
import '../data/model/resource_model.dart';
import '../data/repo/full_database_repo.dart';
import './bloc.dart';

class CohoDatabaseBloc extends Bloc<CohoDatabaseEvent, CohoDatabaseState> {
  final CohoRepo cohoRepo;

  CohoDatabaseBloc(this.cohoRepo);


  @override
  CohoDatabaseState get initialState => LoadingState();

  @override
  Stream<CohoDatabaseState> mapEventToState(
    CohoDatabaseEvent event,
  ) async* {
    yield LoadingState();
    if (event is CategoriesLoadingEvent) {
      // todo maybe implement a try/catch here
      final categories = await cohoRepo.fetchAllCategories();
      yield CategoriesLoadedState(categories);
    } else if (event is CountiesLoadingEvent) {
      final counties = await cohoRepo.fetchAllCounties();
      yield CountiesLoadedState(counties);
    } else if (event is ResourcesLoadingEvent) {
      List<ResourceModel> resources;

      print('about to load resources');

      if (event.parent is CountyModel) {
        resources = await cohoRepo.fetchResourcesOfCounty(event.parent);
      } else {
        resources = await cohoRepo.fetchResourcesOfCategory(event.parent);
      }

      print('loaded resources');

      yield ResourcesLoadedState(resources: resources, parent: event.parent);
    } else if (event is ResourceDetailEvent) {
      ResourceModel resource = event.resource;
      yield ResourceDetailState(resource);
    }
  }
}

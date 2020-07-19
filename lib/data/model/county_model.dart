import './organization_level_model.dart';

class CountyModel extends OrganizationLevelModel {
    final int id;
    final String name;
    final String description;
    final String icon;

    CountyModel({this.id, this.name, this.description, this.icon});

    static countyFromDynMap(Map<dynamic, dynamic> dynMap) {
        return CountyModel(
            id: dynMap['id'],
            name: dynMap['name'],
            description: dynMap['description'],
            icon: dynMap['icon']
        );
    }
}
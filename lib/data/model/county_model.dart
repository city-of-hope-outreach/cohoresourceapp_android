import './organization_level_model.dart';

class CountyModel extends OrganizationLevelModel {
    final int id;
    final String name;
    final String description;
    final String icon;

    CountyModel({this.id, this.name, this.description, this.icon});

    Map<dynamic, dynamic> toDynMap() {
        Map<dynamic, dynamic> county = new Map();
        county['id'] = this.id;
        county['name'] = this.name;
        county['description'] = this.description;
        county['icon'] = this.icon;

        return county;
    }

    static countyFromDynMap(Map<dynamic, dynamic> dynMap) {
        return CountyModel(
            id: dynMap['id'],
            name: dynMap['name'],
            description: dynMap['description'],
            icon: dynMap['icon']
        );
    }
}
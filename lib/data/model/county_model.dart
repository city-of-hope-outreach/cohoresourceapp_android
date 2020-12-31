import './organization_level_model.dart';

class CountyModel extends OrganizationLevelModel {
    CountyModel({int id, String name, String description, String icon}): super(id: id, name: name, description: description, icon: icon);

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
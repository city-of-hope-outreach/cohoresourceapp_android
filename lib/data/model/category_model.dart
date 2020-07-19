import './organization_level_model.dart';

class CategoryModel extends OrganizationLevelModel {
    final int id;
    final String name;
    final String description;
    final String icon;

    CategoryModel({this.id, this.name, this.description, this.icon});

    static categoryFromDynMap(Map<dynamic, dynamic> dynMap) {
        return CategoryModel(
            id: dynMap['id'],
            name: dynMap['name'],
            description: dynMap['description'],
            icon: dynMap['icon']
        );
    }
}
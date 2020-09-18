import './organization_level_model.dart';

class CategoryModel extends OrganizationLevelModel {
    final int id;
    final String name;
    final String description;
    final String icon;

    CategoryModel({this.id, this.name, this.description, this.icon});

    Map<dynamic, dynamic> toDynMap() {
        Map<dynamic, dynamic> cat = new Map();
        cat['id'] = this.id;
        cat['name'] = this.name;
        cat['description'] = this.description;
        cat['icon'] = this.icon;

        return cat;
    }

    static categoryFromDynMap(Map<dynamic, dynamic> dynMap) {
        return CategoryModel(
            id: dynMap['id'],
            name: dynMap['name'],
            description: dynMap['description'],
            icon: dynMap['icon']
        );
    }
}
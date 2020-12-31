import './organization_level_model.dart';

class CategoryModel extends OrganizationLevelModel {
    CategoryModel({int id, String name, String description, String icon}): super(id: id, name: name, description: description, icon: icon);

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
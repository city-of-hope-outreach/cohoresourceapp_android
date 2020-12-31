import 'package:cohoresourceapp_android/data/model/category_model.dart';
import 'package:cohoresourceapp_android/data/model/resource_model.dart';

import 'county_model.dart';

class FullDatabaseModel {
    List<ResourceModel> resources = [];
    List<CountyModel> counties = [];
    List<CategoryModel> categories = [];

    bool loaded = false;
    
    List<CategoryModel> categoriesOfResource(ResourceModel res) {
        List<CategoryModel> categories = [];
        res.categoryIDs.forEach((id) {
            CategoryModel cat = categoryById(id);
            if (cat != null) {
                categories.add(cat);
            }
        });

        return categories;
    }
    
    CategoryModel categoryById(int id) {
        CategoryModel category = null;
        categories.forEach((cat) { 
            if (cat.id == id) {
                category = cat;
                return;
            }
        });
        
        return category;
    }
}
import 'package:cohoresourceapp_android/data/repo/full_database_repo.dart';
import 'package:cohoresourceapp_android/data/repo/icons_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'resource_list.dart';
import '../data/model/category_model.dart';

class Categories extends StatefulWidget {

    final List<CategoryModel> categories;
    final FullDatabaseRepo repo;

    Categories({this.categories, this.repo});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
    void _pushRoute(BuildContext theContext, String title, CategoryModel category) {
        Navigator.push(theContext,
            MaterialPageRoute(
                builder: (context) => ResourceList(
                    title: title,
                    parent: category,
                    repo: widget.repo,),
            ),
        );
    }

    @override
  Widget build(BuildContext context) {
        return categoriesLoaded(context, widget.categories);
  }

  @override
  void didChangeDependencies() {
        super.didChangeDependencies();
//        BlocProvider.of<CohoDatabaseBloc>(context).add(CategoriesLoadingEvent());
        print("Categories did change dependencies");

  }

  ListTile _tile(BuildContext context, CategoryModel category) => ListTile(
      title: Text(category.name,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
          )),
      leading: Icon(
          IconsUtil.iconForCat(category),
          color: Colors.blue[500],
      ),
      onTap: () => _pushRoute(context, category.name, category),
  );

    Widget loadingIndicator() {
        return Center(child: CircularProgressIndicator(),);
    }

    Widget categoriesLoaded(BuildContext context, List<CategoryModel> categories) {
        return ListView.separated(
            itemBuilder: (context, index) {
                return _tile(context, categories[index]);
            },
            separatorBuilder: (context, index) {
                return Divider();
            },
            itemCount: categories.length);
    }
}
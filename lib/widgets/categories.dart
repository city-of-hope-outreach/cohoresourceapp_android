import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'resource_list.dart';
import '../bloc/bloc.dart';
import '../data/model/category_model.dart';

class Categories extends StatefulWidget {

    final List<CategoryModel> categories;

    Categories({this.categories});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
    void _pushRoute(BuildContext theContext, String title, CategoryModel category) {
        Navigator.push(theContext,
            MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                    value: BlocProvider.of<CohoDatabaseBloc>(theContext),
                    child: ResourceList(title: title, parent: category,),
                )
            ),
        );
    }

    @override
  Widget build(BuildContext context) {
        return BlocBuilder<CohoDatabaseBloc, CohoDatabaseState>(
            builder: (context, state) {
                print("Categories building state: $state");
                return categoriesLoaded(context, widget.categories);
            },
        );
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
          Icons.apps,
          color: Colors.blue[500],
      ),
      onTap: () => _pushRoute(context, category.name, category),
  );

    Widget loadingIndicator() {
        return Center(child: CircularProgressIndicator(),);
    }

    Widget categoriesLoaded(BuildContext context, List<CategoryModel> categories) {
        List<Widget> listChildren = [];

        categories.forEach((category) {
           listChildren.add(_tile(context, category));
           listChildren.add(Divider());
        });

        return ListView(
            children: listChildren,
        );
    }
}
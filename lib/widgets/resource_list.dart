import 'package:cohoresourceapp_android/bloc/bloc.dart';
import 'package:cohoresourceapp_android/data/model/organization_level_model.dart';
import 'package:cohoresourceapp_android/data/repo/full_database_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/resource_model.dart';

class ResourceList extends StatefulWidget {
  final String title;

  final List<ResourceModel> resources;

  final OrganizationLevelModel parent;

  final FullDatabaseRepo repo;

  ResourceList({this.title, this.resources, this.parent, this.repo});

  @override
  _ResourceListState createState() => _ResourceListState();
}

class _ResourceListState extends State<ResourceList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.repo.fetchResourcesOfParent(widget.parent),
      builder: (context, AsyncSnapshot<List<ResourceModel>> snapshot) {
        if (snapshot.hasData) {
          return resourcesLoaded(context, snapshot.data);
        }
        return loadingIndicator();
      },
    );
  }

  ListTile _tile(BuildContext context, String title, IconData icon) => ListTile(
    title: Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    leading: Icon(
      icon,
      color: Colors.deepOrangeAccent,
    ),
    onTap: () => _pushRoute(context, title),
  );

  Widget loadingIndicator() {
    return Center(child: CircularProgressIndicator(),);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('calling loading resources: ${widget.parent}');
  }

  void _pushRoute(BuildContext context, String title) {
    Navigator.push(context,
      MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: BlocProvider.of<CohoDatabaseBloc>(context),
            child: ResourceList(title: title,),
          )
      ),
    );
  }

  Widget resourcesLoaded(BuildContext context, List<ResourceModel> resources) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return _tile(context, resources[index].name, Icons.description);
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: resources.length),
    );
  }

  List<Widget> listViewChildren(BuildContext context, List<ResourceModel> resources) {
    List<Widget> list = [];
    resources.forEach((item) {
      list.add(_tile(context, item.name, Icons.description));
//      list.add(Divider());
    });

    return list;
  }
}
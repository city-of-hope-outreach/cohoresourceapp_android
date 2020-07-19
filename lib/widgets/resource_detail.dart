import 'package:cohoresourceapp_android/bloc/bloc.dart';
import 'package:cohoresourceapp_android/data/model/resource_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResourceDetail extends StatefulWidget {
  final ResourceModel resource;

  ResourceDetail({this.resource});

  @override
  _ResourceDetailState createState() => _ResourceDetailState();
}

class _ResourceDetailState extends State<ResourceDetail> {
  @override
  void didChangeDependencies() {
      super.didChangeDependencies();
      BlocProvider.of<CohoDatabaseBloc>(context).add(CountiesLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
        builder: (context, state) {
            if (state is ResourceDetailState) {
                return buildResource();
            }
            return loadingIndicator();
        },
    );
  }

  Widget loadingIndicator() {
      return Center(child: CircularProgressIndicator(),);
  }

  Widget buildResource() {

  }
}
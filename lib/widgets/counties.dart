import 'package:cohoresourceapp_android/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'resource_list.dart';
import '../data/model/county_model.dart';

class Counties extends StatefulWidget {

    final List<CountyModel> counties;

    Counties({this.counties});

  @override
  _CountiesState createState() => _CountiesState();
}

class _CountiesState extends State<Counties> {
    void _pushRoute(BuildContext theContext, String title, CountyModel county) {
        Navigator.push(theContext,
            MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                    value: BlocProvider.of<CohoDatabaseBloc>(theContext),
                    child: ResourceList(title: title, parent: county,),
                )
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        return countiesLoaded(context, widget.counties);
    }

    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
//        BlocProvider.of<CohoDatabaseBloc>(context).add(CountiesLoadingEvent());
        print("Counties did change dependencies");
    }

    ListTile _tile(BuildContext context, CountyModel county) =>
        ListTile(
            title: Text(county.name,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                )),
            leading: Icon(
                Icons.location_on,
                color: Colors.blue[500],
            ),
            onTap: () => _pushRoute(context, county.name, county),
        );

    Widget loadingIndicator() {
        return Center(child: CircularProgressIndicator(),);
    }

    Widget countiesLoaded(BuildContext context, List<CountyModel> counties) {
        List<Widget> listTiles = [];

        counties.forEach((county) {
           listTiles.add(_tile(context, county));
           listTiles.add(Divider());
        });

        return ListView(
            children: listTiles,
        );
    }
}

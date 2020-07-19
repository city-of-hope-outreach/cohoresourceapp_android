
import 'package:cohoresourceapp_android/test.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/resource_list.dart';
import './data/repo/full_database_repo.dart';
import './bloc/bloc.dart';

import './question.dart';
import 'widgets/categories.dart';
import 'widgets/counties.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoHO Resource App',
      theme: ThemeData.dark(),
      home: BlocProvider(
        builder: (context) => CohoDatabaseBloc(FullDatabaseRepo()),
        child: CohoHome(title: "CoHO Resource App"),
      ),
    );
  }
}

/* underscore means private class*/
class CohoHome extends StatefulWidget {
  final String title;

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    Categories(),
    Counties(),
    Question("G'Day Mate"),
    Text('Index 2: School', style: optionStyle,),
  ];

  CohoHome({this.title});

  @override
  _CohoHomeState createState() => _CohoHomeState();
}

class _CohoHomeState extends State<CohoHome> {
  int _selectedIndex = 0;

  Widget buildForLoadingState() {
    return Center(child: CircularProgressIndicator());
  }

  Widget buildForCategoriesLoadedState(BuildContext context, CategoriesLoadedState state) {
    return BlocProvider.value(
      value: BlocProvider.of<CohoDatabaseBloc>(context),
      child: Categories(categories: state.categories)
    );
  }

  Widget buildForCountiesLoadedState(BuildContext context, CountiesLoadedState state) {
    return BlocProvider.value(
      value: BlocProvider.of<CohoDatabaseBloc>(context),
      child: Counties(counties: state.counties)
    );
  }

  Widget buildForResourcesLoadedState(ResourcesLoadedState state) {
    return ResourceList(title: state.parent.name, resources: state.resources);
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      BlocProvider.of<CohoDatabaseBloc>(context).add(CategoriesLoadingEvent());
    } else if (index == 1) {
      BlocProvider.of<CohoDatabaseBloc>(context).add(CountiesLoadingEvent());
    } else {
      // todo figure everything else out
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(this.widget.title),
      ),
      body: BlocBuilder<CohoDatabaseBloc, CohoDatabaseState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return buildForLoadingState();
          } else if (state is CategoriesLoadedState) {
            return buildForCategoriesLoadedState(context, state);
          } else if (state is CountiesLoadedState) {
            return buildForCountiesLoadedState(context, state);
          }
          return buildForLoadingState();
        },
      ),
      bottomNavigationBar: BottomNavigationBar (
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            title: Text('Counties')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print("main did change dependencies");

    BlocProvider.of<CohoDatabaseBloc>(context).add(CategoriesLoadingEvent());
  }
}

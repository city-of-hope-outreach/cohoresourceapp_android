import 'package:cohoresourceapp_android/data/model/category_model.dart';
import 'package:cohoresourceapp_android/data/model/full_database_model.dart';
import 'package:cohoresourceapp_android/test.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'data/model/county_model.dart';
import 'widgets/resource_list.dart';
import './data/repo/full_database_repo.dart';

import './error_message.dart';
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
      home: CohoHome(title: 'CoHO Resource App'),
    );

//        return  MaterialApp(
//            title: "TEST APP",
//            theme: ThemeData.dark(),
//            home: TestWidget(),
//        );
  }
}

/* underscore means private class*/
class CohoHome extends StatefulWidget {
  final String title;
  FullDatabaseRepo repo = FullDatabaseRepo();

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    Categories(),
    Counties(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  CohoHome({this.title});

  @override
  _CohoHomeState createState() => _CohoHomeState();
}

class _CohoHomeState extends State<CohoHome> {
  int _selectedIndex = 0;
  Future<FullDatabaseModel> everyThingFut;

  Widget buildForLoadingState() {
    return Center(child: CircularProgressIndicator());
  }

  void _onItemTapped(int index) {
    if (index == 0) {
//      BlocProvider.of<CohoDatabaseBloc>(context).add(CategoriesLoadingEvent());
    } else if (index == 1) {
//      BlocProvider.of<CohoDatabaseBloc>(context).add(CountiesLoadingEvent());
    } else {
      // todo figure everything else out
    }

    setState(() {
      _selectedIndex = index;
      everyThingFut = widget.repo.fetchEverything();
    });
  }

  Widget body() {
    // if (_selectedIndex == 0) {
    //   return FutureBuilder(
    //     future: widget.repo.fetchAllCategories(),
    //     builder: (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
    //       if (snapshot.hasData) {
    //         return Categories(categories: snapshot.data, repo: widget.repo);
    //       } else if (snapshot.hasError) {
    //         return ErrorMessage(errorMsg: "An Internet connection is required to load data on the first launch",
    //           onRefresh: () => _refresh(),);
    //       } else {
    //         return buildForLoadingState();
    //       }
    //     },
    //   );
    // } else if (_selectedIndex == 1) {
    //   return FutureBuilder(
    //     future: widget.repo.fetchAllCounties(),
    //     builder: (context, AsyncSnapshot<List<CountyModel>> snapshot) {
    //       if (snapshot.hasData) {
    //         return Counties(
    //           counties: snapshot.data,
    //           repo: widget.repo,
    //         );
    //       } else if (snapshot.hasError) {
    //         return ErrorMessage(errorMsg: "An Internet connection is required to load data on the first launch",
    //           onRefresh: () => _refresh(),);
    //       } else {
    //         return buildForLoadingState();
    //       }
    //     },
    //   );
    // } else {
    //   return null;
    // }
    
    return FutureBuilder(
      future: everyThingFut,
      builder: (context, AsyncSnapshot<FullDatabaseModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildForLoadingState();
        }

        if (snapshot.hasData) {
          if (_selectedIndex ==  0) {
            return Categories(categories: snapshot.data.categories, repo: widget.repo);
          } else {
            return Counties(counties: snapshot.data.counties, repo: widget.repo);
          }
        } else if (snapshot.hasError) {
          return ErrorMessage(errorMsg: "An Internet connection is required to load data on the first launch",
            onRefresh: () => _refresh(),);
        } else {
          return buildForLoadingState();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(this.widget.title),
      ),
      body: body(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), title: Text('Counties')),
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

  void _refresh() {
    setState(() {
      everyThingFut = widget.repo.fetchEverything();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    everyThingFut = widget.repo.fetchEverything();

    print("main did change dependencies");
  }
}

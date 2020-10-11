import 'package:flutter/material.dart';

import './data/repo/full_database_repo.dart';
import 'data/model/full_database_model.dart';
import 'widgets/search.dart';
import 'widgets/error_message.dart';
import 'widgets/categories.dart';
import 'widgets/counties.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: CohoHome(),
    );

       // return  MaterialApp(
       //     title: "TEST APP",
       //     theme: ThemeData.dark(),
       //     home: TestWidget(),
       // );
  }
}

class CohoHome extends StatefulWidget {
  FullDatabaseRepo repo = FullDatabaseRepo();

  CohoHome();

  @override
  _CohoHomeState createState() => _CohoHomeState();
}

class _CohoHomeState extends State<CohoHome> {
  int _selectedIndex = 0;
  Future<FullDatabaseModel> everyThingFut;

  AppBar _appBar = AppBar(title: Text("CoHO Resource App"));

  Widget buildForLoadingState() {
    return Center(child: CircularProgressIndicator());
  }

  void _onItemTapped(int index) {
    setState(() {
      // if (index != 2) {
      //   _appBar = AppBar(title: Text("CoHO Resource App"));
      // } else {
      //   _appBar = null;
      // }

      _selectedIndex = index;
      everyThingFut = widget.repo.fetchEverything();
    });
  }

  Widget body() {
    if (_selectedIndex == 2) {
      return Search(repo: widget.repo,);
    }

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
      appBar: _appBar,
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_application/bloc/home/home_bloc.dart';
import 'package:test_flutter_application/bloc/home/home_event.dart';
import 'package:test_flutter_application/bloc/home/home_state.dart';
import 'package:test_flutter_application/models/client_preferences.dart';
import 'package:test_flutter_application/models/user.dart';
import 'package:test_flutter_application/services/user_repository.dart';
import 'package:test_flutter_application/view/user_info.dart';

class HomePage extends StatefulWidget {
  final userRepository = UserRepository();
  final _clienRepository = ClientPreferences();

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchQuery = new TextEditingController();
  bool _isSearching = false;
  Widget appBarTitle = new Text(
    "Search Sample",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = new GlobalKey<ScaffoldState>();
  String _searchText = "";
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    void _handleSearchStart() {
      setState(() {
        _isSearching = true;
      });
    }

    void _handleSearchEnd() {
      setState(() {
        this.actionIcon = new Icon(
          Icons.search,
          color: Colors.white,
        );
        this.appBarTitle = new Text(
          "Search Sample",
          style: new TextStyle(color: Colors.white),
        );
        _isSearching = false;
        _searchQuery.clear();
      });
    }

    List<ChildItem> _buildList(List<User> _list) {
      return _list.map((contact) => new ChildItem(contact)).toList();
    }

    List<ChildItem> _buildSearchList(List<User> _list) {
      if (_searchText.isEmpty) {
        return _list.map((contact) => new ChildItem(contact)).toList();
      } else {
        List<User> _searchList = [];
        for (int i = 0; i < _list.length; i++) {
          String name = _list.elementAt(i).name.first;
          if (name.toLowerCase().contains(_searchText.toLowerCase())) {
            _searchList.add(_list.elementAt(i));
          }
        }
        return _searchList.map((contact) => new ChildItem(contact)).toList();
      }
    }

    return BlocProvider<HomePageBloc>(
        create: (context) => HomePageBloc(HomePageRefreshingState()),
        child: MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  title: appBarTitle,
                  actions: <Widget>[
                    new IconButton(
                      icon: actionIcon,
                      onPressed: () {
                        setState(() {
                          if (this.actionIcon.icon == Icons.search) {
                            this.actionIcon = new Icon(
                              Icons.close,
                              color: Colors.white,
                            );
                            this.appBarTitle = new TextField(
                              controller: _searchQuery,
                              style: new TextStyle(
                                color: Colors.white,
                              ),
                              decoration: new InputDecoration(
                                  prefixIcon: new Icon(Icons.search,
                                      color: Colors.white),
                                  hintText: "Search...",
                                  hintStyle:
                                      new TextStyle(color: Colors.white)),
                            );
                            // BlocProvider.of<HomePageBloc>(context)
                            //     .add(StartSearchEvent());
                            _handleSearchStart();
                          } else {
                            _handleSearchEnd();
                          }
                        });
                      },
                    ),
                  ]),
              body: BlocBuilder<HomePageBloc, HomePageState>(
                  builder: (context, state) {
                if (state is HomePageLogoutedState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is HomePageRefreshingState) {
                  BlocProvider.of<HomePageBloc>(context)
                      .add(HomePageRefreshEvent());
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is HomePageRefreshedState) {
                  return RefreshIndicator(
                      onRefresh: () async {
                        BlocProvider.of<HomePageBloc>(context)
                            .add(HomePageRefreshEvent());
                      },
                      key: refreshKey,
                      child: ListView(
                        padding: new EdgeInsets.symmetric(vertical: 8.0),
                        children: _isSearching
                            ? _buildSearchList(state.loadedUser)
                            : _buildList(state.loadedUser),
                      ));
                  // ListView.builder(
                  //     itemCount: state.loadedUser.length,
                  //     itemBuilder: (context, index) => Container(
                  //           child: ListTile(
                  //             onTap: () {
                  //               Navigator.of(context).push(
                  //                   MaterialPageRoute(
                  //                       builder: (context) => UserInfo(
                  //                           state.loadedUser[index].name,
                  //                           state
                  //                               .loadedUser[index].location,
                  //                           state.loadedUser[index]
                  //                               .picture)));
                  //             },
                  //             leading: Image.network(
                  //                 state.loadedUser[index].picture.large),
                  //             title: Column(
                  //               children: [
                  //                 Text(state.loadedUser[index].name.first),
                  //                 Text(
                  //                     state.loadedUser[index].location.city)
                  //               ],
                  //             ),
                  //             contentPadding:
                  //                 EdgeInsets.fromLTRB(10, 10, 10, 20),
                  //           ),
                  //         )));
                }

                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              })),
        ));
  }
}

class ChildItem extends StatelessWidget {
  final User user;
  ChildItem(this.user);
  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                UserInfo(user.name, user.location, user.picture)));
      },
      leading: Image.network(user.picture.large),
      title: Column(
        children: [Text(user.name.first), Text(user.location.city)],
      ),
    );
  }
}

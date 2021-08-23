import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_application/bloc/authorization/authorization_bloc.dart';
import 'package:test_flutter_application/bloc/home/home_bloc.dart';
import 'package:test_flutter_application/bloc/home/home_event.dart';
import 'package:test_flutter_application/bloc/home/home_state.dart';
import 'package:test_flutter_application/models/client_preferences.dart';
import 'package:test_flutter_application/models/user.dart';
import 'package:test_flutter_application/services/user_repository.dart';
import 'package:test_flutter_application/view/authorization_page.dart';
import 'package:test_flutter_application/view/user_info.dart';

class HomePage extends StatefulWidget {
  final userRepository = UserRepository();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchQuery = TextEditingController();
  final _clientPreferences = ClientPreferences();

  Widget appBarTitle = Text(
    "Search",
    style: TextStyle(color: Colors.white),
  );
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );

  Icon closeIcon = Icon(Icons.close, color: Colors.white);

  final key = new GlobalKey<ScaffoldState>();
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    List<ChildItem> _buildList(List<User> _list) {
      return _list.map((contact) => new ChildItem(contact)).toList();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            if (state is HomePageRefreshedState && state.isSearching) {
              return TextField(
                onChanged: (_searchQuery) {
                  BlocProvider.of<HomePageBloc>(context).add(
                      HomePageRefreshEvent(
                          false, true, false, false, _searchQuery));
                },
                style: new TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.white),
                    hintText: "Search...",
                    hintStyle: new TextStyle(color: Colors.white)),
              );
            }
            return appBarTitle;
          },
        ),
        actions: <Widget>[
          BlocBuilder<HomePageBloc, HomePageState>(
            builder: (context, state) {
              if (state is HomePageRefreshedState && state.isSearching) {
                return IconButton(
                  icon: closeIcon,
                  onPressed: () {
                    context.read<HomePageBloc>().add(
                        HomePageRefreshEvent(false, false, false, true, ""));
                  },
                );
              } else {
                return IconButton(
                  icon: actionIcon,
                  onPressed: () {
                    context.read<HomePageBloc>().add(
                        HomePageRefreshEvent(false, true, false, false, ""));
                  },
                );
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<HomePageBloc>().add(HomePageLogoutEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if (state is HomePageLogoutSuccessState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider<AuthorizationBloc>(
                        create: (context) => AuthorizationBloc(),
                        child: AuthorizationPage())));
          }

          if (state is HomePageRefreshingState) {
            Provider.of<HomePageBloc>(context)
                .add(HomePageRefreshEvent(true, false, false, false, ""));
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is HomePageRefreshedState) {
            return Scaffold(
              body: RefreshIndicator(
                onRefresh: () async {
                  if (_searchQuery.text != "") {
                    BlocProvider.of<HomePageBloc>(context).add(
                        HomePageRefreshEvent(
                            false, false, true, false, _searchQuery.text));
                  } else {
                    BlocProvider.of<HomePageBloc>(context).add(
                        HomePageRefreshEvent(true, false, false, false, ""));
                  }
                },
                key: refreshKey,
                child: ListView(
                  padding: new EdgeInsets.symmetric(vertical: 8.0),
                  children: _buildList(state.loadedUser),
                ),
              ),
            );
          }

          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/viewModel/HomeViewModel.dart';
import 'package:untitled3/widgets/CoPassengersCardWidget.dart';

class HomeView extends StatefulWidget {
  final String currentUserID;
  HomeView({@required this.currentUserID});
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    bool portrait = orientation == Orientation.portrait;
    print(
        "mwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmwmw");

    print(orientation);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          // toolbarHeight: portrait ? 56.0 : 0.0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Co-passengers in your vicinity",
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
              child: Body(
                currentUserID: widget.currentUserID,
              ),
              onRefresh: () {
                return Future.delayed(
                  Duration(seconds: 1),
                  () {
                    setState(() {});
                  },
                );
              }),
        ));
  }
}

class Body extends StatelessWidget {
  final String currentUserID;
  Body({@required this.currentUserID});
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    bool portrait = orientation == Orientation.portrait;

    return Consumer<HomeViewModel>(builder: (context, data, child) {
      return Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (ConnectionState.active != null && !snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('images/airIndiaLogo.png', height: 200),
                      Text(
                        "Loading co-passenggers list ....",
                        style: TextStyle(fontSize: 20),
                      ),
                      CircularProgressIndicator()
                    ],
                  ),
                ),
              );
            }
            if (ConnectionState.done != null && snapshot.hasError) {
              return const Center(child: Text('Something went wrong :('));
            }
            List travelers = snapshot.data.keys.toList();
            List statuses = snapshot.data.values.toList();

            return portrait
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CoPassengersCard(
                            currentUser:
                                Provider.of<HomeViewModel>(context).current,
                            friend: travelers[index],
                            status: statuses[index],
                          ));
                    },
                  )
                : GridView.builder(
              itemCount: snapshot.data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                          childAspectRatio: 1.7
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CoPassengersCard(
                            currentUser:
                                Provider.of<HomeViewModel>(context).current,
                            friend: travelers[index],
                            status: statuses[index],
                          ));
                    },
                  );
            Text("a");
          },
          future:
              context.read<HomeViewModel>().travalersListFuture(currentUserID),
        ),
      );
    });
  }
}

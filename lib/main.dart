import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/services/CloudFirestoreServices.dart';
import 'package:untitled3/viewModel/ChatViewModel.dart';
import 'package:untitled3/viewModel/HomeViewModel.dart';
import 'package:untitled3/views/HomeView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ChatViewModel()),
        ChangeNotifierProvider.value(value: HomeViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Media Player',
        theme: ThemeData(
          appBarTheme: AppBarTheme(),
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
        ),
        home: SelectUserView(),
      ),
    );
  }
}

class SelectUserView extends StatelessWidget {
  CloudFirestoreServices _cloudFirestoreServices = CloudFirestoreServices();

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    bool portrait = orientation == Orientation.portrait;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
         
          title: Text(
            "Select your name",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (ConnectionState.active != null && !snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset('images/airIndiaLogo.png',
                                  height: 200),
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
                      return const Center(
                          child: Text('Something went wrong :('));
                    }



                    return portrait ?  ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                      offset: Offset(0, 5))
                                ],
                              ),
                              child: ListTile(
                                tileColor: Colors.white,
                                title: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(snapshot.data[index].name.toString(),
                                        style: TextStyle(fontSize: 25)),
                                    Text(
                                        "Ticket ID : " +
                                            snapshot.data[index].code
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey.shade700)),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeView(
                                          currentUserID:
                                          snapshot.data[index].id,
                                        )),
                                  );
                                },
                              ),
                            ));
                      },
                    ) :
                    GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5
                    ),
                    itemBuilder: (context, index) {

                    return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                    decoration: BoxDecoration(
                    boxShadow: [
                    BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, 5))
                    ],
                    ),
                    child: ListTile(
                    tileColor: Colors.white,
                    title: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                    Text(snapshot.data[index].name.toString(),
                    style: TextStyle(fontSize: 25)),
                    Text(
                    "Ticket ID : " +
                    snapshot.data[index].code
                        .toString(),
                    style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade700)),
                    ],
                    ),
                    onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => HomeView(
                    currentUserID:
                    snapshot.data[index].id,
                    )),
                    );
                    },
                    ),
                    ));
                    });




                  },
                  future: _cloudFirestoreServices.allTravelers()),
            ),
          ],
        ));
  }
}

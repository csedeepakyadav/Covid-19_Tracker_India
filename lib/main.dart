import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'staemanagement/StateManager.dart';
import 'model/DataModel.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xff2e2e2e),
  ));
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StateManager>(create: (_) => StateManager()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        showSemanticsDebugger: false,
        theme: ThemeData(
          primaryColor: Color(0xff2e2e2e), //Color(0xffFF614C),
          brightness: Brightness.dark,

          textTheme: GoogleFonts.tavirajTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        themeMode: ThemeMode.dark,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var statemanager = Provider.of<StateManager>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          statemanager.fetchCovidData();
        },
        child: Icon(Icons.refresh),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                child: Center(
                  child: Text(
                    '***   Covid-19  Tracker   ***',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
                height: 1,
              ),
              SizedBox(
                height: 70,
              ),
              CovidIndia(),
              SizedBox(
                height: 20,
              ),
            ],
          )),
    );
  }
}

class CovidIndia extends StatelessWidget {
  final String country;
  CovidIndia({this.country});
  @override
  Widget build(BuildContext context) {
    var statemanager = Provider.of<StateManager>(context);

    return FutureBuilder<CovidData>(
      future: statemanager
          .fetchCovidData(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<CovidData> snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ClipOval(
                        child: Container(
                          //     color: Colors.transparent,
                          //  width: MediaQuery.of(context).size.width * 0.3,
                          child: Image.network(
                              'https://www.countries-ofthe-world.com/flags-normal/flag-of-India.png'),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        color: Colors.transparent,
                        // width: MediaQuery.of(context).size.height * 0.2,
                        child: Text(
                          snapshot.data.country,
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  //  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Colors.grey,
                ),
                Container(
                  child: Table(
                      //  border: TableBorder.all(color: Colors.black),
                      border: TableBorder(
                        right: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                        verticalInside: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black),
                        bottom: BorderSide(color: Colors.black),
                      ),
                      children: [
                        TableRow(children: [
                          Container(
                            //s color: Colors.blue,
                            child: Center(
                              child: Text(
                                'Confirmed',
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                'Deaths',
                                style:
                                    TextStyle(fontSize: 22, color: Colors.red),
                              ),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                'Recovered',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.green),
                              ),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          Container(
                            child: Center(
                              child: Text(
                                snapshot.data.confirmed.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                snapshot.data.deaths.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                snapshot.data.recovered.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ]),
                      ]),
                ),
                SizedBox(
                  height: 70,
                ),
                Container(
                  child: Center(
                    child: Text(
                      'Last Updated : ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Center(
                    child: Text(
                      snapshot.data.lastUpdate.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {}
        return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...',
                      style: TextStyle(color: Colors.white)),
                )
              ]),
        );
      },
    );
  }
}

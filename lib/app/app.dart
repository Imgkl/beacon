import 'package:beacon/drop_beacon.dart';
import 'package:beacon/drop_beacon_option.dart';
import 'package:beacon/search_beacon.dart';
import 'package:beacon/search_beacon_option.dart';
import 'package:beacon/widgets/custom_painter.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool search = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Color(0xFF1C1C1C),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff30bE96),
                    Color(0xff402565),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        search = true;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                      height: search
                          ? MediaQuery.of(context).size.height * 0.6
                          : MediaQuery.of(context).size.height * 0.4,
                      child: CustomPaint(
                        painter: CurvePainter(search),
                        child: Container(
                          decoration: search
                              ? BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                      Color(0xfff06966),
                                      Color(0xfffad6a6)
                                    ]))
                              : null,
                          padding: EdgeInsets.only(bottom: search ? 0 : 55),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                child: search
                                    ? SearchBeacon()
                                    : SearchBeaconOption(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        search = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                      height: search
                          ? MediaQuery.of(context).size.height * 0.4
                          : MediaQuery.of(context).size.height * 0.6,
                      child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.only(top: search ? 55 : 0),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                child:
                                    !search ? DropBeacon() : DropBeaconOption(),
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

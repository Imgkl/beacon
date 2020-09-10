import 'package:dough/dough.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share/share.dart';

class DropSuccess extends StatelessWidget {
  final BuildContext context;
  final String password;

  const DropSuccess({Key key, this.context, this.password}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   leading: IconButton(
      //       icon: Icon(Icons.arrow_back_ios),
      //       onPressed: () {
      //         Navigator.popAndPushNamed(
      //           context,
      //           "/app",
      //         );
      //       }),
      // ),
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Text(
                    "Share this Pass Key with your friends so that they can follow your beacon and track live location.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                ),
                Text(
                  password ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.white),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PressableDough(
                        child: OutlineButton(
                      borderSide: BorderSide(color: Color(0xff30bE96),),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        Flushbar(
                          message: "Passcode Copied.",
                          icon: Icon(
                            LineIcons.check_circle_o,
                            size: 28.0,
                            color: Colors.green,
                          ),
                          duration: Duration(seconds: 3),
                          leftBarIndicatorColor: Colors.white,
                        )..show(context);
                        Clipboard.setData(new ClipboardData(text: password));
                      },
                      child: Text(
                        "Copy pin",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                    PressableDough(
                        child: OutlineButton(
                      borderSide: BorderSide(color: Color(0xff30bE96),),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        Share.share(
                            "Hello, Here's my beacon. Enter this code ($password) to follow it.");
                      },
                      child: Text(
                        "Share",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Material(
                    elevation: 10,
                    color: Colors.white,
                    child: IconButton(
                        icon: Icon(LineIcons.home),
                        onPressed: () {
                          Navigator.popAndPushNamed(
                            context,
                            "/app",
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

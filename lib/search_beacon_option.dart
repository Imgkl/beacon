import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SearchBeaconOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 200,
          width: 300,
          child: FlareActor(
            "assets/flare/search.flr",
            animation: "Search location",
          ),
        ),
        Hero(
          tag: "Search",
          child: Text("Search beacon", style: Theme.of(context).textTheme.headline4,)),
      ],
    );
  }
}

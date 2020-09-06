import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class DropBeaconOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 170,
          width: 300,
          child: FlareActor(
            "assets/flare/drop.flr",
            animation: "record",
          ),
        ),
        Text(
            "Drop beacon",
            style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white),
          ),
      ],
    );
  }
}

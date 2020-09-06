import 'package:beacon/widgets/swipe_button.dart';
import 'package:flutter/material.dart';

class DropBeacon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CircleAvatar(
          radius: 150,
              backgroundImage: NetworkImage("https://staticmapmaker.com/img/google@2x.png"),
        ),
        Padding(
          padding: const EdgeInsets.only(top:68.0),
          child: SwipingButton(text: "Drop a Beacon", onSwipeCallback: (){
            print("Dropped");
          }, sucessfulText: "Dropping a Beacon...", swipeButtonColor: Color(0xff30bE96), iconColor: Colors.white,),
        )
      ],
    );
  }
}

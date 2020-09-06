import 'package:beacon/widgets/swipe_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class SearchBeacon extends StatefulWidget {
  @override
  _SearchBeaconState createState() => _SearchBeaconState();
}

class _SearchBeaconState extends State<SearchBeacon> {
  bool showButton = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: Text(
            "Enter Passcode to search a beacon.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical:40.0),
          child: PinCodeFields(
            length: 4,
            fieldBorderStyle: FieldBorderStyle.Square,
            responsive: false,
            fieldHeight: 50.0,
            fieldWidth: 50.0,
            borderWidth: 5.0,
            activeBorderColor: Colors.teal,
            activeBackgroundColor: Colors.tealAccent,
            borderRadius: BorderRadius.circular(20.0),
            keyboardType: TextInputType.number,
            autoHideKeyboard: false,
            fieldBackgroundColor: Color(0xfffad6a6),
            borderColor: Color(0xfff06966),
            onChange: (s) {
              if (s.length >= 4) {
                setState(() {
                  showButton = true;
                });
              }else{
                setState(() {
                  showButton = false;
                });
              }
            },
          ),
        ),
        showButton?Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: SwipingButton(
            text: "Search a Beacon",
            onSwipeCallback: () {
              print("Searching....");
            },
            sucessfulText: "Searching a Beacon...",
            swipeButtonColor: Color(0xfff06966),
            iconColor: Colors.white,
          ),
        ): Container(
          height: 55,
        )
      ],
    );
  }
}
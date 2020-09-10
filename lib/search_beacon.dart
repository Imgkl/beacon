import 'package:beacon/widgets/swipe_button.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: PinCodeTextField(
            backgroundColor: Colors.transparent,
            appContext: context,
            length: 6,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              selectedColor: Colors.white,
              selectedFillColor: Color(0xfffad6a6),
              activeColor: Color(0xfffad6a6),
              activeFillColor: Color(0xfff06966),
              shape: PinCodeFieldShape.circle,
              fieldHeight: 70,
              fieldWidth: 50,
            ),
            animationDuration: Duration(milliseconds: 300),
            enableActiveFill: false,
            obsecureText: false,
            onChanged: (value) {
              setState(() {
                if (value.length >= 6) {
                  setState(() {
                    showButton = true;
                  });
                } else {
                  setState(() {
                    showButton = false;
                  });
                }
              });
            },
          ),
        ),
        showButton
            ? Padding(
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
              )
            : Container(
                height: 55,
              )
      ],
    );
  }
}

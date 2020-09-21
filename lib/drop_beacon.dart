import 'package:awesome_page_transitions/awesome_page_transitions.dart';
import 'package:beacon/screen/drop_beacon_sucess.dart';
import 'package:beacon/services/location_serv.dart';
import 'package:beacon/widgets/swipe_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class DropBeacon extends StatefulWidget {
  @override
  _DropBeaconState createState() => _DropBeaconState();
}

class _DropBeaconState extends State<DropBeacon> {

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 300,
          width: 300,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7000),
            child: FlutterMap(
              options: MapOptions(
                interactive: false,
                minZoom: 15.0,
                center: LatLng(userLocation?.latitude ?? 0.0,
                    userLocation?.longitude ?? 0.0),
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']),
                MarkerLayerOptions(markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(userLocation.latitude ?? 0.0,
                        userLocation.longitude ?? 0.0),
                    builder: (ctx) => Container(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ])
              ],
            ),
            // backgroundImage: NetworkImage("https://staticmapmaker.com/img/google@2x.png"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 68.0),
          child: SwipingButton(
            text: "Drop a Beacon",
            onSwipeCallback: () {
              Navigator.push(
                context,
                AwesomePageRoute(
                  transitionDuration: Duration(milliseconds: 600),
                  enterPage: DropSuccess(
                    context: context,
                    password: randomAlphaNumeric(6),
                  ),
                  transition: ParallaxTransition(),
                ),
              );
              print("Dropped");
            },
            sucessfulText: "Dropping a Beacon...",
            swipeButtonColor: Color(0xff30bE96),
            iconColor: Colors.white,
          ),
        )
      ],
    );
  }
}

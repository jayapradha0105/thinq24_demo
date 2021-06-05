import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thinq24_demo/style/theme.dart' as Theme;

class map extends StatefulWidget {
  @override
  mapState createState() => mapState();
}

class mapState extends State<map> {
  LocationData _currentPosition;
  GoogleMapController mapController;

  List<Marker> _markers = <Marker>[];

  Location location = Location();

  GoogleMapController _controller;

  LatLng _initialcameraposition = LatLng(0.5937, 0.9629);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoc();
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    location.onLocationChanged.listen((l) {
      setState(() {
        _markers.add(
            Marker(
                markerId: MarkerId('Current Location'),
                position: LatLng(l.latitude,l.longitude),
                infoWindow: InfoWindow(
                    title: 'Current Location'
                )
            )
        );
        _currentPosition = l;
        _initialcameraposition =
            LatLng(_currentPosition.latitude, _currentPosition.longitude);
      });
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.Colors.primarycolor,
        title: Text(
          "Map View",
          style: TextStyle(
              color: Theme.Colors.secondcolor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialcameraposition, zoom: 15),
              mapType: MapType.normal,
              markers: Set<Marker>.of(_markers),
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
            ),
          ),
      ),
    );
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);
  }
}

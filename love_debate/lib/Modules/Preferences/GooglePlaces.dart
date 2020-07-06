
///Addressss portion
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:math';

List<String> address=List<String>();
const kGoogleApiKey = "AIzaSyDkrmNt7yLpSO4JA9k7JdzVmX3KQrvvyzg";
// to get places detail (lat/lng)
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

final customTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  accentColor: Colors.redAccent,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.00)),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 12.50,
      horizontal: 10.00,
    ),
  ),
);

class RoutesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: "My App",
    theme: customTheme,
    routes: {
      "/": (_) => GooglePlaces(),
      "/search": (_) => CustomSearchScaffold(),
    },
  );
}

class GooglePlaces extends StatefulWidget {
  @override
  _GooglePlacesState createState() => _GooglePlacesState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class _GooglePlacesState extends State<GooglePlaces> {
  Mode _mode = Mode.overlay;
  String location="empty";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: Text("My App"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //  _buildDropdownMenu(),
              RaisedButton(
                onPressed: _handlePressButton,
                child: Text("Search places"),
              ),
            ],
          )),
    );
  }


  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: Mode.overlay,

//      language: "fr",
//      components: [Component(Component.country, "fr")],
    );
    displayPrediction(p, homeScaffoldKey.currentState);
  }
}

Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
  if (p != null) {
    // get detail (lat/lng)
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;
//
    print(detail.result.formattedAddress.toString());
//     //print(detail.result.addressComponents.toString());
//    print(detail.result.addressComponents[0].longName.toString()+" 0");
//    print(detail.result.addressComponents[0].types);
//    print(detail.result.addressComponents[1].longName.toString()+" 1");
//    print(detail.result.addressComponents[1].types);
//    print(detail.result.addressComponents[2].longName.toString()+" 2");
//    print(detail.result.addressComponents[2].types);
//    print(detail.result.addressComponents[3].longName.toString()+" 3");
//    print(detail.result.addressComponents[3].types);
//    print(detail.result.addressComponents[4].longName.toString()+" 4");
//    print(detail.result.addressComponents[4].types);
//    print(detail.result.addressComponents[5].longName.toString()+" 5");
//    print(detail.result.addressComponents[5].types);
//    print(detail.result.addressComponents[6].longName.toString()+" 6");
//    print(detail.result.addressComponents[6].types);
//    print(detail.result.addressComponents[7].longName.toString()+" 7");
//    print(detail.result.addressComponents[7].types);
//    print(detail.result.addressComponents[8].longName.toString()+" 8");
//    print(detail.result.addressComponents[8].types);

    for(int i=0;i<detail.result.addressComponents.length;i++){
      print(detail.result.addressComponents[i].types[0].toString());
      if(detail.result.addressComponents[i].types[0].toString()=="administrative_area_level_1"){
        print("state");
      }
      if(detail.result.addressComponents[i].types[0]=="administrative_area_level_2"&&detail.result.addressComponents[i].types[0]!="locality"){
        print("city");
      }
    }
    //address.add(detail.result.formattedAddress.split(",").toString());
    //print(address);
    scaffold.showSnackBar(
      SnackBar(content: Text("${p.description} - $lat/$lng")),
    );
  }
}

class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
    apiKey: kGoogleApiKey,
    sessionToken: Uuid().generateV4(),
    language: "en",
    components: [Component(Component.country, "uk")],
  );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p, searchScaffoldKey.currentState);
      },
      logo: Row(
        children: [FlutterLogo()],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
    return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    searchScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {
      searchScaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Got answer")),
      );
    }
  }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(generateBits(bitCount), digitCount);

  int generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}










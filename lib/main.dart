import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'routes/search_route.dart';

void main() => runApp(EbaySearchApp());

class EbaySearchApp extends StatefulWidget {
  @override
  createState() => _EbaySearchAppState();
}

class _EbaySearchAppState extends State<EbaySearchApp> {
  String _token;
  String _appID;
  String _certID;
  final String getTokenURL =
      'https://api.sandbox.ebay.com/identity/v1/oauth2/token';

  Future<Map<String, dynamic>>_getCredentials() async {

  }

  // Get auth token for making api calls
  _getToken() async {
    String data = await DefaultAssetBundle.of(context).loadString("lib/assets/credentials.json");
    Map<String, dynamic> creds = jsonDecode(data);

    http.Response response = await http.post(
      getTokenURL,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic ' +
            base64Encode(utf8.encode(
                '${creds['AppID']}:${creds['CertID']}')),
      },
      body:
          'grant_type=client_credentials&scope=https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope',
    );
    if (response.statusCode != 200) {
      throw Exception("Authorization Failed: ${response.body}");
    }
    Map<String, dynamic> decoded = jsonDecode(response.body);

    setState(() {
      _token = decoded['access_token'].toString();
      _appID = creds['AppID'];
      _certID = creds['CertID'];
    });
  }

  Widget _loadingScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ebay Search App"),
      ),
      body: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Center(
                child: Text("Preparing Application"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Token(
      _token,
      _appID,
      _certID,
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ebay Search App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SearchRoute(title: 'Ebay Search App'),
      ),
    );
  }
}

class Token extends InheritedWidget {
  final String token;
  final String appID;
  final String certID;

  const Token(this.token, this.appID, this.certID, Widget child) : super(child: child);

  @override
  bool updateShouldNotify(Token oldWidget) {
    return token != oldWidget.token;
  }

  static Token of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(Token);
  }
}
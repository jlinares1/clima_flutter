import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(
      {required this.urlPath,
      required this.unEncodedPath,
      required this.queryParameters});

  final String urlPath;
  final String unEncodedPath;
  final Map<String, dynamic> queryParameters;

  Future getData() async {
    Uri url = Uri.https(urlPath, unEncodedPath, queryParameters);
    Response response = await get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Network {
  final Uri uri;
  Network({required this.uri});

  Future getData() async {
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      return convert.jsonDecode(data);
    }
  }
}

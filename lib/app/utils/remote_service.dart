import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  String url = 'http://localhost:8080/register';
  Uri uri = Uri.parse(url);
  final response = await http.post(uri);

  if (response.statusCode == 200) {
    Map<String, dynamic> register = json.decode(response.body);
    print(register);
  } else {
    print("failed to load");
  }
}

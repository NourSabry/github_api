import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

addListToSharedPreferences() async {
  var url = Uri.parse('https://api.github.com/users/square/repos');

  final response = await http.get(url);
  final extractedData = json.decode(response.body) as List<dynamic>?;
  List<String> infoList = extractedData!.map((e) => json.encode(e)).toList();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList('stringValue', infoList);
}

getListValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> listValue = prefs.getStringList('stringValue')!;
  return listValue;
}

removeValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.remove("stringValue");
}
refreshValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.reload();
}

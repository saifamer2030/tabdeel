import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

saveToken(userId, role) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("userId", userId);
  prefs.setString("role", role);
}

savedata(key, value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

//shared prefrences user data
save(String key, value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, json.encode(value));
}

readerItem(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return json.decode(prefs.getString(key));
}

remove(String key) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

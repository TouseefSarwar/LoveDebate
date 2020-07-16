
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

  getBy(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  set(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  containKey(String key) async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }
}


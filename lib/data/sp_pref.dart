import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  dynamic read(String key) async {
    final prefs = await SharedPreferences.getInstance();

    final String? val = prefs.getString(key);

    if (val != null) {
      return json.decode(val);
    } else {
      return null;
    }
  }

  dynamic save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(key, value);
    print("prefs.setString(key, value); ${prefs.getString(key)}");
  }

  dynamic remove(String key) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove(key);
  }
}

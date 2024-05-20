import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager<T> {
  final String key;

  SharedPreferencesManager(this.key);

  // Método para guardar un valor en SharedPreferences
  Future<void> save(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(key, value);
  }

  // Método para recuperar un valor de SharedPreferences
  Future<String?> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   return prefs.getString(key);
  }

  // Método para eliminar un valor de SharedPreferences
  Future<void> remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

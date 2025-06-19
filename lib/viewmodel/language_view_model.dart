import 'package:cook_buddy/utils/imports.dart';


class LanguageViewModel with ChangeNotifier{
  String _language = "English";

  String get language => _language;

  LanguageViewModel(){
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _language = prefs.getString("language") ?? "English";
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    _language = _language == "English" ? "Hindi" : "English";
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", _language);
    notifyListeners();
  }

}
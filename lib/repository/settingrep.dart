import 'package:shared_preferences/shared_preferences.dart';

class SettingRepository {
  // ignore: constant_identifier_names
  static const THEME_KEY = "darkMode";
  // ignore: constant_identifier_names
  static const PSEUDO_KEY = "pseudo";
  // ignore: constant_identifier_names
  static const SCORE_KEY = "score";
  // ignore: constant_identifier_names
  static const LEVEL_MORPION_KEY = "levelMorpion";
  // ignore: constant_identifier_names
  static const LEVELJEU_MORPION_KEY = "levelJeuMorpion";
  // ignore: constant_identifier_names
  static const LEVEL_PUISSANCE4_KEY = "levelPuissance4";
  // ignore: constant_identifier_names
  static const LEVELJEU_PUISSANCE4_KEY = "levelJeuPuissance4";

  saveSettingsDark(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(THEME_KEY, value);
  }

  saveSettingsPseudo(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(PSEUDO_KEY, value);
  }

  saveSettingsScore(String pseudo, String score, String level) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> scores = sharedPreferences.getStringList(SCORE_KEY) ?? [];
    scores.add("$pseudo:$score:$level");
    sharedPreferences.setStringList(SCORE_KEY, scores);
  }

  clearSettingsScore() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(SCORE_KEY);
  }

  Future<List<String>> getSettingsScore() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(SCORE_KEY) ?? [];
  }

  Future<bool> getSettingsDark() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(THEME_KEY) ?? false;
  }

  Future<String?> getSettingsPseudo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(PSEUDO_KEY);
  }

  saveSettingsLevelMorpion(int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(LEVEL_MORPION_KEY, value);
  }

  saveSettingsLevelJeuMorpion(int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(LEVELJEU_MORPION_KEY, value);
  }

  Future<int> getSettingsLevelMorpion() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(LEVEL_MORPION_KEY) ?? 1;
  }

  Future<int> getSettingsLevelJeuMorpion() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(LEVELJEU_MORPION_KEY) ?? 1;
  }

  saveSettingsLevelPuissance4(int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(LEVEL_PUISSANCE4_KEY, value);
  }

  saveSettingsLevelJeuPuissance4(int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(LEVELJEU_PUISSANCE4_KEY, value);
  }

  Future<int> getSettingsLevelPuissance4() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(LEVEL_PUISSANCE4_KEY) ?? 1;
  }

  Future<int> getSettingsLevelJeuPuissance4() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(LEVELJEU_PUISSANCE4_KEY) ?? 1;
  }

  clearSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}

import 'settingrep.dart';
import 'package:flutter/material.dart';

class SettingViewModel extends ChangeNotifier {
  late bool _isDark;
  late String _pseudo;
  late List _score;
  late int _niveauMorpion;
  late int _niveauJeuMorpion;
  late int _niveauPuissance4;
  late int _niveauJeuPuissance4;
  late SettingRepository _settingRepository;
  bool get isDark => _isDark;
  String get pseudos => _pseudo;
  List get score => _score;
  int get niveauMorpion => _niveauMorpion;
  int get niveauJeuMorpion => _niveauJeuMorpion;
  int get niveauPuissance4 => _niveauPuissance4;
  int get niveauJeuPuissance4 => _niveauJeuPuissance4;
  SettingViewModel() {
    _isDark = false;
    _score = [];
    _niveauMorpion = 1;
    _niveauJeuMorpion = _niveauMorpion;
    _niveauPuissance4 = 1;
    _niveauJeuPuissance4 = _niveauPuissance4;
    _settingRepository = SettingRepository();
    getSettingsDark();
    getSettingsPseudo();
    getSettingsScore();
    getSettingsNiveauMorpion();
    getSettingsNiveauJeuMorpion();
    getSettingsNiveauPuissance4();
    getSettingsNiveauJeuPuissance4();
  }

  set isDark(bool value) {
    _isDark = value;
    _settingRepository.saveSettingsDark(value);
    notifyListeners();
  }

  set pseudo(String value) {
    _pseudo = value;
    _settingRepository.saveSettingsPseudo(value);
    notifyListeners();
  }

  addScore(String pseudo, String score, String level) {
    _score.add("$pseudo:$score:$level");
    _settingRepository.saveSettingsScore(pseudo, score, level);
    notifyListeners();
  }

  clearScore() {
    _score = [];
    _settingRepository.clearSettingsScore();
    notifyListeners();
  }

  set niveauMorpion(int value) {
    _niveauMorpion = value;
    _settingRepository.saveSettingsLevelMorpion(value);
    notifyListeners();
  }

  set niveauJeuMorpion(int value) {
    _niveauJeuMorpion = value;
    _settingRepository.saveSettingsLevelJeuMorpion(value);
    notifyListeners();
  }

  getSettingsDark() async {
    _isDark = await _settingRepository.getSettingsDark();
    notifyListeners();
  }

  getSettingsPseudo() async {
    _pseudo = await _settingRepository.getSettingsPseudo() ?? "";
    notifyListeners();
  }

  getSettingsScore() async {
    _score = await _settingRepository.getSettingsScore();
    notifyListeners();
  }

  getSettingsNiveauMorpion() async {
    _niveauMorpion = await _settingRepository.getSettingsLevelMorpion();
    notifyListeners();
  }

  getSettingsNiveauJeuMorpion() async {
    _niveauJeuMorpion = await _settingRepository.getSettingsLevelJeuMorpion();
    if (_niveauJeuMorpion > _niveauMorpion) {
      _niveauJeuMorpion = _niveauMorpion;
      _settingRepository.saveSettingsLevelJeuMorpion(_niveauJeuMorpion);
    }
    notifyListeners();
  }

  getSettingsNiveauPuissance4() async {
    _niveauPuissance4 = await _settingRepository.getSettingsLevelPuissance4();
    notifyListeners();
  }

  getSettingsNiveauJeuPuissance4() async {
    _niveauJeuPuissance4 =
        await _settingRepository.getSettingsLevelJeuPuissance4();
    if (_niveauJeuPuissance4 > _niveauPuissance4) {
      _niveauJeuPuissance4 = _niveauPuissance4;
      _settingRepository.saveSettingsLevelJeuPuissance4(_niveauJeuPuissance4);
    }
    notifyListeners();
  }

  set niveauPuissance4(int value) {
    _niveauPuissance4 = value;
    _settingRepository.saveSettingsLevelPuissance4(value);
    notifyListeners();
  }

  set niveauJeuPuissance4(int value) {
    _niveauJeuPuissance4 = value;
    _settingRepository.saveSettingsLevelJeuPuissance4(value);
    notifyListeners();
  }

  clearSettings() {
    _settingRepository.clearSettings();
    _isDark = false;
    _pseudo = "";
    _score = [];
    _niveauMorpion = 1;
    _niveauJeuMorpion = 1;
    _niveauPuissance4 = 1;
    _niveauJeuPuissance4 = 1;
    notifyListeners();
  }

  clearSettingsScore() {
    _settingRepository.clearSettingsScore();
    _score = [];
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:td2_flutter/ui/home.dart';
import 'package:td2_flutter/mytheme.dart';
import 'package:td2_flutter/repository/settingsmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyTD2());
}

class MyTD2 extends StatelessWidget {
  const MyTD2({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          SettingViewModel settingViewModel = SettingViewModel();
          return settingViewModel;
        }),
      ],
      child: Consumer<SettingViewModel>(
        builder: (context, SettingViewModel notifier, child) {
          return MaterialApp(
              theme: notifier.isDark ? MyTheme.dark() : MyTheme.light(),
              title: 'TP MOBILE',
              home: const Home());
        },
      ),
    );
  }
}

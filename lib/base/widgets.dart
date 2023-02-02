// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:moi_pratki/app/screen/about/about_posta_screen.dart';
import 'package:moi_pratki/base/color_data.dart';
import 'package:moi_pratki/base/preference_settings_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'common_button.dart';

class AppBarIcons extends StatefulWidget {
  final Color? iconColor;

  const AppBarIcons({Key? key, this.iconColor}) : super(key: key);

  @override
  State<AppBarIcons> createState() => _AppBarIconsState();
}

class _AppBarIconsState extends State<AppBarIcons> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceSettingsProvider>(
      builder: (context, prefSetProvider, _) {
        return Row(
          children: [
            SplashIcon(
              icon: Icon(Icons.info_outline,
                  color: Theme.of(context).iconTheme.color),
              size: 28,
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: const ActivityScreen(),
                  ),
                );
              },
            ),
            const SizedBox(width: defaultPadding - 5),
            Padding(
                padding: const EdgeInsets.only(left: defaultPadding),
                child: InkWell(
                  onTap: () => prefSetProvider
                      .enableDarkTheme(!prefSetProvider.isDarkTheme),
                  borderRadius: BorderRadius.circular(10.0),
                  child: Icon(
                    prefSetProvider.isDarkTheme
                        ? Icons.light_mode_sharp
                        : Icons.dark_mode_sharp,
                    size: 24.0,
                    color: prefSetProvider.isDarkTheme
                        ? Colors.white
                        : Theme.of(context).iconTheme.color,
                  ),
                )),
          ],
        );
      },
    );
  }
}

class AppVersion extends StatefulWidget {
  const AppVersion({Key? key}) : super(key: key);

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  String _version = "";

  void _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _version = packageInfo.version;
      });
    }
  }

  @override
  void initState() {
    _getAppVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var TextTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Мои пратки",
            style: TextTheme.titleSmall!
                .copyWith(fontSize: 13, color: Colors.white70)),
                const Spacer(),
        Text("Верзија: $_version\n",
            style: TextTheme.titleSmall!
                .copyWith(fontSize: 13, color: Colors.white70)),
      ],
    );
  }
}

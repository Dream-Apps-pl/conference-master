import 'dart:io';

import 'package:conferenceapp/common/appbar.dart';
import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/generated/l10n.dart';
import 'package:conferenceapp/organizers/organizers_page.dart';
import 'package:conferenceapp/sponsors/sponsors_page.dart';
import 'package:conferenceapp/utils/analytics.dart';
import 'package:conferenceapp/utils/languages.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:line_icons/line_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'authenticator_button.dart';
import 'settings_toggle.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  int counter = 0;
  bool authVisible = false;

  @override
  Widget build(BuildContext context) {
    final sharedPrefs = Provider.of<SharedPreferences>(context);
    final defaultLang = Localizations.localeOf(context);
    context.read<LanguageCubit>().changeStartLang();
    return Positioned.fill(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 40),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: <Widget>[
          ListTile(
            title: Text(S.current.language),
          ),
          Row(
            children: [
              const SizedBox(width: 15),
              ChoiceChip(
                label: Text(S.current.poland),
                selected: defaultLang == const Locale('pl') ? true : false,
                onSelected: (bool selected) {
                  context.read<LanguageCubit>().changeLang(context, 'pl');
                },
              ),
              const SizedBox(width: 5),
              ChoiceChip(
                label: Text(S.current.english),
                selected: defaultLang == const Locale('en') ? true : false,
                onSelected: (bool selected) {
                  context.read<LanguageCubit>().changeLang(context, 'en');
                },
              ),
            ],
          ),
          SettingsToggle(
            title: S.current.darkTheme,
            onChanged: (_) => changeBrightness(),
            value: Theme.of(context).brightness == Brightness.dark,
          ),
          SettingsToggle(
            title: S.current.reminders,
            subtitle: S.current.remindersDes,
            onChanged: changeReminders,
            value: sharedPrefs.getBool('reminders') == true,
          ),
          ListTile(
            title: Text(S.current.sponsors),
            subtitle: Text(S.current.sponsorsDes),
            trailing: const Icon(LineIcons.angleRight),
            contentPadding: const EdgeInsets.only(left: 16.0, right: 24.0),
            onTap: () {
              logger.info('Sponsors tapped');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SponsorsPage(),
                  settings: const RouteSettings(name: 'sponsors'),
                ),
              );
            },
          ),
          ListTile(
            title: Text(S.current.organizers),
            subtitle: Text(S.current.organizersDes),
            trailing: const Icon(LineIcons.angleRight),
            contentPadding: const EdgeInsets.only(left: 16.0, right: 24.0),
            onTap: () {
              logger.info('Organizers tapped');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrganizersPage(),
                  settings: const RouteSettings(name: 'organizers'),
                ),
              );
            },
          ),
          ListTile(
            title: Text(S.current.codeOfConduct),
            subtitle: Text(S.current.codeOfConductDes),
            trailing: const Icon(LineIcons.angleRight),
            contentPadding: const EdgeInsets.only(left: 16.0, right: 24.0),
            onTap: () async {
              final text = await getFileData('assets/coc.md');
              logger.info('Coc tapped');
              if (!mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: FlutterEuropeAppBar(
                      back: true,
                      search: false,
                    ),
                    body: Markdown(
                      data: text,
                    ),
                  ),
                  settings: const RouteSettings(name: 'organizers'),
                ),
              );
            },
          ),
          ListTile(
            title: Text(S.current.sendFeedback),
            subtitle: Text(S.current.sendFeedbackDes),
            trailing: const Icon(LineIcons.angleRight),
            contentPadding: const EdgeInsets.only(left: 16.0, right: 24.0),
            onTap: () async {
              logger.info('Feedback tapped');
              await showDialog(
                context: context,
                barrierDismissible: true,
                builder: (ctx) => SimpleDialog(
                  children: <Widget>[
                    TextButton(
                      child: Text(S.current.sendEmail),
                      onPressed: () {
                        sendEmail();
                        Navigator.pop(ctx);
                      },
                    ),
                    // not use snapfeed
                    // TextButton(
                    //   child: Text(
                    //     'Try Snapfeed\n(User feedback tool for Flutter apps)',
                    //     textAlign: TextAlign.center,
                    //   ),
                    //   onPressed: () {
                    //     Navigator.pop(ctx);
                    //     logger.info('Feedback button tapped');
                    //     //Snapfeed.of(context).startFeedback();
                    //   },
                    // )
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: Text(S.current.about),
            trailing: const Icon(LineIcons.angleRight),
            contentPadding: const EdgeInsets.only(left: 16.0, right: 24.0),
            onTap: () async {
              final text = await getFileData('assets/about.md');
              logger.info('About tapped');
              if (!mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text(S.current.aboutApp),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          MarkdownBody(
                            data: text,
                          ),
                          TextButton(
                            child: Text(S.current.sendEmail),
                            onPressed: () {
                              sendEmail();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text(S.current.openSourceLicenses),
            subtitle: Text(S.current.openSourceLicensesDes),
            trailing: const Icon(LineIcons.angleRight),
            contentPadding: const EdgeInsets.only(left: 16.0, right: 24.0),
            onTap: () async {
              final version = await PackageInfo.fromPlatform();
              logger.info('Open source licenses tapped');
              if (!mounted) return;
              showLicensePage(
                  context: context,
                  applicationIcon: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      'assets/flutter_europe.png',
                      height: 50,
                    ),
                  ),
                  applicationName: S.current.conferenceTitle,
                  applicationVersion: version.version,
                  applicationLegalese:
                      'Created by Dominik Roszkowski (roszkowski.dev), Maciek Korzeniewski (@korzonkiee), Marcin Szałek (fidev.io) and Robert Odrowąż-Sypniewski for the Flutter Europe conference');
            },
          ),
          // if (Provider.of<FirebaseRemoteConfig>(context, listen: false)
          //     .getBool('service_login_enabled'))
          //   ListTile(
          //     title: Text('Service login'),
          //     subtitle: Text('You can check tickets if you\'re authorized'),
          //     trailing: Icon(LineIcons.angleRight),
          //     contentPadding: EdgeInsets.only(left: 16.0, right: 24.0),
          //     onTap: () {
          //       AuthenticatorButton().showLoginDialog(context);
          //     },
          //   ),
          Visibility(
            visible: authVisible,
            child: const AuthenticatorButton(),
          ),
          GestureDetector(
            onTap: () {
              counter++;
              if (counter > 8) {
                setState(() {
                  authVisible = true;
                });
              }
            },
            child: const VersionInfo(),
          )
        ],
      ),
    );
  }

  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  void sendEmail() async {
    final version = await PackageInfo.fromPlatform();
    final platform = Platform.isIOS ? 'iOS' : 'Android';
    const email = 'piotr@snyiwizje.pl';
    final subject = S.current.subject;
    final body =
        'Cześć! Chciałem podzielić się swoja opinią na temat tej aplikacji mobilnej.<br><br><br>Wersja Aplikacji: ${version.version}<br>App Id: ${version.packageName}<br>Platforma: $platform';
    final url = Uri.encodeFull('mailto:$email?subject=$subject&body=$body');
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      logger.warn('Nie mogę wyświetlić $url, przy opcji share');

      Share.share(body, subject: body);
    }
  }

  void changeReminders(bool value) {
    final sharedPrefs = Provider.of<SharedPreferences>(context);
    analytics!.setUserProperty(name: 'reminders', value: '$value');
    sharedPrefs.setBool('reminders', value);
    setState(() {});
  }

  void changeBrightness() {
    final target = Theme.of(context).brightness == Brightness.dark ? 0 : 1;
    Logger().info('target $target');
    final paramValue = target == 0 ? 'light' : 'dark';
    analytics!.logEvent(
      name: 'settings_theme',
      parameters: {'target': paramValue},
    );
    analytics!.setUserProperty(name: 'theme', value: paramValue);
    // DynamicTheme.of(context).setBrightness(target);
    DynamicTheme.of(context)!.setTheme(target);
  }
}

class VersionInfo extends StatelessWidget {
  const VersionInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final pkg = snapshot.data;
            return Row(
              children: <Widget>[
                Text('V. ${pkg!.version} (${pkg.buildNumber})'),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

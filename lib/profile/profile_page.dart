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
import 'package:flutter_bugfender/flutter_bugfender.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:line_icons/line_icons.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'authenticator_button.dart';
import 'settings_toggle.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int counter = 0;
  bool authVisible = false;

  @override
  Widget build(BuildContext context) {
    final sharedPrefs = Provider.of<SharedPreferences>(context);
    final defaultLang = Localizations.localeOf(context);
    context.read<LanguageCubit>().changeStartLang();
    return Positioned.fill(
      child: ListView(
        padding: EdgeInsets.only(bottom: 40),
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: <Widget>[
          ListTile(
            title: Text(S.current.language),
          ),
          Row(
            children: [
              SizedBox(width: 15),
              ChoiceChip(
                label: Text('Poland'),
                selected: defaultLang == Locale('pl') ? true : false,
                onSelected: (bool selected) {
                  context.read<LanguageCubit>().changeLang(context, 'pl');
                },
              ),
              SizedBox(width: 5),
              ChoiceChip(
                label: Text('English'),
                selected: defaultLang == Locale('en') ? true : false,
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
            trailing: Icon(LineIcons.angleRight),
            contentPadding: EdgeInsets.only(left: 16.0, right: 24.0),
            onTap: () {
              logger.info('Sponsors tapped');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SponsorsPage(),
                  settings: RouteSettings(name: 'sponsors'),
                ),
              );
            },
          ),
          ListTile(
            title: Text(S.current.organizers),
            subtitle: Text(S.current.organizersDes),
            trailing: Icon(LineIcons.angleRight),
            contentPadding: EdgeInsets.only(left: 16.0, right: 24.0),
            onTap: () {
              logger.info('Organizers tapped');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrganizersPage(),
                  settings: RouteSettings(name: 'organizers'),
                ),
              );
            },
          ),
          ListTile(
            title: Text(S.current.codeOfConduct),
            subtitle: Text(S.current.codeOfConductDes),
            trailing: Icon(LineIcons.angleRight),
            contentPadding: EdgeInsets.only(left: 16.0, right: 24.0),
            onTap: () async {
              final text = await getFileData('assets/coc.md');
              logger.info('Coc tapped');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: FlutterEuropeAppBar(
                      back: true,
                      search: false,
                    ),
                    body: Container(
                      child: Markdown(
                        data: text,
                      ),
                    ),
                  ),
                  settings: RouteSettings(name: 'organizers'),
                ),
              );
            },
          ),
          ListTile(
            title: Text(S.current.sendFeedback),
            subtitle: Text(S.current.sendFeedbackDes),
            trailing: Icon(LineIcons.angleRight),
            contentPadding: EdgeInsets.only(left: 16.0, right: 24.0),
            onTap: () async {
              logger.info('Feedback tapped');
              await showDialog(
                context: context,
                barrierDismissible: true,
                builder: (ctx) => SimpleDialog(
                  children: <Widget>[
                    TextButton(
                      child: Text('Send e-mail'),
                      onPressed: () {
                        sendEmail();
                        Navigator.pop(ctx);
                      },
                    ),
                    TextButton(
                      child: Text(
                        'Try Snapfeed\n(User feedback tool for Flutter apps)',
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                        logger.info('Feedback button tapped');
                        //Snapfeed.of(context).startFeedback();
                      },
                    )
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: Text(S.current.about),
            trailing: Icon(LineIcons.angleRight),
            contentPadding: EdgeInsets.only(left: 16.0, right: 24.0),
            onTap: () async {
              final text = await getFileData('assets/about.md');
              logger.info('About tapped');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text('About the app'),
                    ),
                    body: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          MarkdownBody(
                            data: text,
                          ),
                          TextButton(
                            child: Text('Send e-mail'),
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
            trailing: Icon(LineIcons.angleRight),
            contentPadding: EdgeInsets.only(left: 16.0, right: 24.0),
            onTap: () async {
              final version = await PackageInfo.fromPlatform();
              logger.info('Open source licenses tapped');
              showLicensePage(
                  context: context,
                  applicationIcon: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      'assets/flutter_europe.png',
                      height: 50,
                    ),
                  ),
                  applicationName: 'Konferencje Sny i Wizje',
                  applicationVersion: '${version.version}',
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
            child: AuthenticatorButton(),
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
            child: VersionInfo(),
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
    final email = 'piotr@snyiwizje.pl';
    final subject = 'Informacja zwrotna z aplikacji "Sny i Wizje';
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
    FlutterBugfender.setDeviceString('reminders', '$value');
    sharedPrefs.setBool('reminders', value);
    setState(() {});
  }

  void changeBrightness() {
    final target = Theme.of(context).brightness == Brightness.dark ? 0 : 1;
    print('target $target');
    final paramValue = target == 0 ? 'light' : 'dark';
    analytics!.logEvent(
      name: 'settings_theme',
      parameters: {'target': paramValue},
    );
    analytics!.setUserProperty(name: 'theme', value: paramValue);
    FlutterBugfender.setDeviceString('theme', paramValue);
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

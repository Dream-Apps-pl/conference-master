import 'package:conferenceapp/admin/admin_page.dart';
import 'package:conferenceapp/agenda/agenda_page.dart';
import 'package:conferenceapp/common/appbar.dart';
import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/force_update/force_update.dart';
import 'package:conferenceapp/force_update/force_update_dialog.dart';
import 'package:conferenceapp/generated/l10n.dart';
import 'package:conferenceapp/main_page/add_ticket_button.dart';
import 'package:conferenceapp/main_page/learn_features_button.dart';
import 'package:conferenceapp/model/talk.dart';
import 'package:conferenceapp/my_schedule/my_schedule_page.dart';
import 'package:conferenceapp/notifications/notifications_page.dart';
import 'package:conferenceapp/notifications/repository/notifications_unread_repository.dart';
import 'package:conferenceapp/profile/auth_repository.dart';
import 'package:conferenceapp/profile/profile_page.dart';
import 'package:conferenceapp/search/search_results_page.dart';
import 'package:conferenceapp/talk/talk_page.dart';
import 'package:conferenceapp/ticket_check/ticket_check_page.dart';
import 'package:conferenceapp/utils/analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  static const int agenda = 0;
  static const int mySchedule = 1;
  static const int notifications = 2;
  static const int profile = 3;
  static const int ticketer = 4;
  static const int admin = 5;

  final _tabs = {
    agenda: 'agenda',
    mySchedule: 'mySchedule',
    notifications: 'notifications',
    profile: 'profile',
    ticketer: 'ticketer',
    admin: 'admin',
  };

  @override
  void initState() {
    super.initState();

    ForceUpdate.onForceUpdate(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showForceUpdateDialog(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: RepositoryProvider.of<AuthRepository>(context).isAdmin(),
        builder: (context, snapshot) {
          // final isAdmin = true;
          final isAdmin = snapshot.data == true;
          return StreamBuilder<bool>(
              stream: RepositoryProvider.of<AuthRepository>(context).isTicketer,
              builder: (context, ticketerSnapshot) {
                final isTicketer = ticketerSnapshot.data == true;
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: FlutterEuropeAppBar(
                    onSearch: () {
                      _showSearch(context);
                    },
                    layoutSelector:
                        _currentIndex == agenda || _currentIndex == mySchedule,
                  ),
                  floatingActionButton: const AddTicketButton(),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  bottomNavigationBar:
                      createBottomNavigation(isAdmin, isTicketer),
                  body: Stack(
                    children: <Widget>[
                      IndexedStack(
                        index: _adminAwareIndex(
                            _currentIndex, isAdmin, isTicketer),
                        children: <Widget>[
                          const AgendaPage(),
                          const MySchedulePage(),
                          const NotificationsPage(),
                          const ProfilePage(),
                          if (isTicketer) const TicketCheckPage(),
                          if (isAdmin) const AdminPage() else Container(),
                        ],
                      ),
                      Visibility(
                        visible: _currentIndex == agenda ||
                            _currentIndex == mySchedule,
                        child: const Positioned(
                          bottom: 0,
                          right: 12,
                          child: LearnFeaturesButton(),
                        ),
                      )
                    ],
                  ),
                );
              });
        });
  }

  BottomNavigationBar createBottomNavigation(
      [bool isAdmin = false, bool isTicketer = false]) {
    const itemHeight = 22.0;
    const textSize = 12.0;

    return BottomNavigationBar(
      // if admin logs out we can't remain on admin page
      currentIndex: _adminAwareIndex(_currentIndex, isAdmin, isTicketer),
      onTap: (index) {
        analytics?.setCurrentScreen(
          screenName: '/home/${_tabs[index]}',
          screenClassOverride: '${_tabs[index]}',
        );
        if (index == notifications) {
          final notif =
              RepositoryProvider.of<AppNotificationsUnreadStatusRepository>(
                  context);
          notif.setLatestNotificationReadTime();
        }
        setState(() {
          _currentIndex = index;
        });
      },
      unselectedItemColor: Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).bottomAppBarTheme.color
          : Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: textSize,
      unselectedFontSize: textSize,
      items: [
        BottomNavigationBarItem(
          icon: const SizedBox(
            height: itemHeight,
            child: Icon(LineIcons.calendar),
          ),
          label: S.current.agenda,
        ),
        BottomNavigationBarItem(
          icon: const Icon(LineIcons.calendarCheck),
          label: S.current.mySchedule,
        ),
        BottomNavigationBarItem(
          icon: const NotificationIndicator(
            child: Icon(LineIcons.bell),
          ),
          label: S.current.notifications,
        ),
        BottomNavigationBarItem(
          icon: const Icon(LineIcons.cog),
          label: S.current.settings,
        ),
        if (isTicketer == true)
          BottomNavigationBarItem(
            icon: const Icon(LineIcons.alternateTicket),
            label: _currentIndex != ticketer ? 'Bilety' : '',
          ),
        if (isAdmin == true)
          BottomNavigationBarItem(
            icon: const Icon(LineIcons.userShield),
            label: _currentIndex != admin ? S.current.admin : null,
          ),
      ],
    );
  }

  _showSearch(BuildContext context) async {
    try {
      final res =
          await Navigator.push<Talk>(context, _buildSearchPage(context));
      if (res != null) {
        analytics?.logEvent(
          name: 'search_completed',
          parameters: {
            'selected_talk_id': res.id,
            'selected_talk': '$res',
          },
        );
        if (res.type == TalkType.other) {
          return;
        } else {
          if (!mounted) return;
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TalkPage(res),
              settings: RouteSettings(name: 'agenda/${res.id}'),
            ),
          );
        }
      }
    } catch (e) {
      logger.errorException(e);
    }
  }

  _buildSearchPage(BuildContext context) {
    return MaterialPageRoute<Talk>(
      settings: const RouteSettings(name: 'search'),
      builder: (BuildContext context) => const SearchResultsPage(),
    );
  }

  _adminAwareIndex(int index, bool isAdmin, bool isTicketer) {
    if (isAdmin) {
      if (isTicketer) {
        return index;
      } else {
        if (index == ticketer || index == admin) {
          return admin - 1;
        } else {
          return index;
        }
      }
    } else {
      if (isTicketer) {
        if (index == ticketer || index == admin) {
          return ticketer;
        } else {
          return index;
        }
      } else {
        if (index == ticketer || index == admin) {
          return profile;
        } else {
          return index;
        }
      }
    }
  }
}

class NotificationIndicator extends StatelessWidget {
  final Widget child;

  const NotificationIndicator({Key? key, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notif =
        RepositoryProvider.of<AppNotificationsUnreadStatusRepository>(context);
    return StreamBuilder<bool>(
      stream: notif.hasUnreadNotifications(),
      builder: (context, snapshot) {
        return Stack(
          children: <Widget>[
            child,
            if (snapshot.hasData && snapshot.data == true)
              Positioned(
                top: 10,
                right: 5,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}

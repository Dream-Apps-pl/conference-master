import 'package:conferenceapp/generated/l10n.dart';
import 'package:conferenceapp/model/notification.dart';
import 'package:conferenceapp/notifications/repository/notifications_repository.dart';
import 'package:conferenceapp/notifications/repository/notifications_unread_repository.dart';
import 'package:conferenceapp/utils/analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationsRepository =
        RepositoryProvider.of<FirestoreNotificationsRepository>(context);
    final notificationUnreadRepository =
        RepositoryProvider.of<AppNotificationsUnreadStatusRepository>(context);
    final lastRead = notificationUnreadRepository.latestNotificationReadTime();

    return StreamBuilder<List<AppNotification>>(
        stream: notificationsRepository.notifications(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final list = snapshot.data;
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              itemCount: list!.length,
              itemBuilder: (context, index) {
                final notif = list[index];
                return ListTile(
                  title: Text(
                    notif.title,
                    style: TextStyle(
                      fontWeight:
                          notif.important ? FontWeight.bold : FontWeight.w400,
                    ),
                  ),
                  subtitle: Text(notif.content),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (notif.url.isNotEmpty)
                        const Icon(
                          LineIcons.link,
                          size: 14,
                        ),
                      Text(timeago.format(notif.dateTime)),
                      if (lastRead!.isBefore(notif.dateTime))
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor),
                            height: 8,
                            width: 8,
                          ),
                        ),
                    ],
                  ),
                  onTap: notif.url.isNotEmpty
                      ? () => openNotification(notif)
                      : null,
                );
              },
            );
          } else {
            return const Center(
              child: NotificationsEmptyState(),
            );
          }
        });
  }

  void openNotification(AppNotification notification) async {
    if (await canLaunchUrl(Uri.parse(notification.url))) {
      analytics?.logEvent(name: 'notif_open', parameters: {
        'title': notification.title,
      });
      await launchUrl(Uri.parse(notification.url));
    }
  }
}

class NotificationsEmptyState extends StatelessWidget {
  const NotificationsEmptyState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/notifications.png',
            height: 200,
            width: 200,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              S.current.noNotification,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

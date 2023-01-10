import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferenceapp/admin/admin_agenda.dart';
import 'package:conferenceapp/admin/admin_organizer.dart';
import 'package:conferenceapp/admin/admin_sponsor.dart';
import 'package:conferenceapp/common/europe_text_field.dart';
import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/generated/l10n.dart';
import 'package:conferenceapp/model/notification.dart';
import 'package:conferenceapp/notifications/repository/notifications_repository.dart';
import 'package:conferenceapp/profile/auth_repository.dart';
import 'package:conferenceapp/profile/settings_toggle.dart';
import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(S.current.agenda),
              subtitle: Text(S.current.addAgendaDes),
              trailing: Icon(LineIcons.database),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminAgenda(),
                    settings: RouteSettings(name: 'admin/agenda'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(S.current.sponsors),
              subtitle: Text(S.current.sponsorsDes),
              trailing: Icon(LineIcons.ad),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminSponsor(),
                    settings: RouteSettings(name: 'admin/sponsor'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(S.current.organizers),
              subtitle: Text(S.current.organizersDes),
              trailing: Icon(LineIcons.objectGroup),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminOrganizer(),
                    settings: RouteSettings(name: 'admin/organizer'),
                  ),
                );
              },
            ),
            // ListTile(
            //   title: Text('Load tickets from csv'),
            //   subtitle: Text(
            //       'Select attendees.csv from Eventil to upload into Firestore. Will overwrite the existing database.'),
            //   trailing: Icon(LineIcons.file),
            //   onTap: () async {
            //     final res = await handleCsvTickets();
            //     if (res == false) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text('Error during loading of the tickets.'),
            //           behavior: SnackBarBehavior.floating,
            //         ),
            //       );
            //     }
            //   },
            // ),
            // ListTile(
            //   title: Text('Add notification'),
            //   subtitle: Text(
            //       'Notification will be visible on notifications page for all attendees.'),
            //   trailing: Icon(LineIcons.exclamation),
            //   onTap: () async => await handleAddingNotification(context),
            // ),
            // ListTile(
            //   title: Text('Create new ticketer'),
            //   subtitle: Text('This allows to create new ticketer'),
            //   trailing: Icon(LineIcons.smilingFace),
            //   onTap: () async => await handleCreateNewUser(context),
            // ),
            ListTile(
              title: Text('Logout'),
              trailing: Icon(LineIcons.sign),
              onTap: () async => await handleLogout(context),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Future handleAddingNotification(BuildContext context) async {
    final notification = await showDialog<AppNotification>(
      builder: (context) => NotificationDialog(),
      context: context,
    );
    if (notification != null) {
      final notifRepository =
          RepositoryProvider.of<FirestoreNotificationsRepository>(context);
      notifRepository.addNotification(notification);
      await Future.delayed(Duration(milliseconds: 500));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(S.current.notifAdmin),
      ));
    }
  }

  Future handleCreateNewUser(BuildContext context) async {
    await showDialog(
      builder: (context) => SignupDialog(),
      context: context,
    );
  }

  Future handleLogout(BuildContext context) async {
    final auth = RepositoryProvider.of<AuthRepository>(context);
    await auth.signout();
  }

  Future<bool> handleCsvTickets() async {
    try {
      var file = await FilePicker.platform
          .pickFiles(type: FileType.any, allowedExtensions: ['csv']);

      if (file == null) return false;
      File fileData = File(file.files.first.path!);
      final yourString = await fileData.readAsString();
      var d = new FirstOccurrenceSettingsDetector(
        eols: ['\r\n', '\n'],
        textDelimiters: ['"', "'"],
      );

      final rowsAsListOfValues = const CsvToListConverter().convert(
        yourString,
        csvSettingsDetector: d,
      );

      final tickets = <Map>[];
      for (var att in rowsAsListOfValues.skip(1)) {
        final name = att[1];
        final name64 = base64.encode(utf8.encode(name));
        final email = att[2];
        final email64 = base64.encode(utf8.encode(email));
        final ticketId = att[5].toString().toLowerCase();
        final orderId = att[15].toString().toUpperCase();
        final type = att[4];
        final ticket = {
          'name': name64,
          'email': email64,
          'ticketId': ticketId,
          'orderId': orderId,
          'type': type,
          'used': false
        };
        tickets.add(ticket);
      }

      final ticketDoc = FirebaseFirestore.instance.doc('/tickets/tickets');

      FirebaseFirestore.instance.runTransaction((Transaction tx) async {
        DocumentSnapshot ticketsSnapshot = await tx.get(ticketDoc);
        if (!ticketsSnapshot.exists) {
          tx.set(ticketDoc, {});
        }
        if (ticketsSnapshot.exists) {
          tx.set(ticketDoc, <String, dynamic>{
            'tickets': tickets,
          });
        }
      });
      return true;
    } catch (e) {
      logger.errorException(e);
      return false;
    }
  }
}

class SignupDialog extends StatefulWidget {
  const SignupDialog({
    Key? key,
  }) : super(key: key);

  @override
  _SignupDialogDialogState createState() => _SignupDialogDialogState();
}

class _SignupDialogDialogState extends State<SignupDialog> {
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(S.current.addNewTicker),
      contentPadding: EdgeInsets.all(12.0),
      children: <Widget>[
        EuropeTextFormField(
          hint: S.current.email,
          value: email,
          onChanged: (value) {
            setState(() {
              email = value;
            });
          },
          onFieldSubmitted: (_) {
            FocusScope.of(context).nextFocus();
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () async {
                try {
                  final doc =
                      FirebaseFirestore.instance.collection('ticketers').doc();
                  await doc.set({'email': email});
                } catch (e) {
                  logger.errorException(e);
                }
                Navigator.pop(context);
              },
              child: Text(S.current.register),
              style: TextButton.styleFrom(backgroundColor: Colors.green),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(S.current.close),
              style: TextButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}

class NotificationDialog extends StatefulWidget {
  const NotificationDialog({
    Key? key,
  }) : super(key: key);

  @override
  _NotificationDialogState createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  late String title;
  late String content;
  DateTime dateTime = DateTime.now();
  bool important = false;
  late String url;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Add new notification'),
      contentPadding: EdgeInsets.all(12.0),
      children: <Widget>[
        EuropeTextFormField(
          hint: 'Title',
          value: title,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          onChanged: (value) {
            setState(() {
              title = value;
            });
          },
          onFieldSubmitted: (_) {
            FocusScope.of(context).nextFocus();
          },
        ),
        EuropeTextFormField(
          hint: 'Content',
          value: content,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          onChanged: (value) {
            setState(() {
              content = value;
            });
          },
          onFieldSubmitted: (_) {
            FocusScope.of(context).nextFocus();
          },
        ),
        EuropeTextFormField(
          hint: 'Url (not required)',
          value: url,
          keyboardType: TextInputType.url,
          textCapitalization: TextCapitalization.none,
          onChanged: (value) {
            setState(() {
              url = value;
            });
          },
          onFieldSubmitted: (_) {
            FocusScope.of(context).nextFocus();
          },
        ),
        SettingsToggle(
          title: 'Important',
          onChanged: (value) {
            setState(() {
              important = value;
            });
          },
          value: important,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop<AppNotification>(
                context,
                AppNotification(title, dateTime, content, important, url),
              ),
              child: Text('Save'),
              style: TextButton.styleFrom(backgroundColor: Colors.green),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
              style: TextButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}

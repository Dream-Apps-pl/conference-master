import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferenceapp/generated/l10n.dart';
import 'package:conferenceapp/profile/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import 'tickets_list.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  UsersListPageState createState() => UsersListPageState();
}

class UsersListPageState extends State<UsersListPage> {
  String filter = '';

  @override
  Widget build(BuildContext context) {
    final tickets =
        FirebaseFirestore.instance.collection('tickets_checked').snapshots();
    final authRepo = RepositoryProvider.of<AuthRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              filter = value;
            });
          },
          decoration: InputDecoration(
            hintText: S.current.searchByOrder,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              LineIcons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {});
            },
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: StreamBuilder<bool>(
            stream: authRepo.isAdmin(),
            builder: (context, isAdmin) {
              return StreamBuilder<QuerySnapshot>(
                stream: tickets,
                builder: (context, list) {
                  if (list.hasData) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '${S.current.allChecked}: ${list.data?.docs.length}'),
                        ),
                        Flexible(
                          child: TicketsList(list, isAdmin, filter),
                        ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              );
            }),
      ),
    );
  }

  String formatTimestamp(int timestamp) {
    var format = DateFormat('d MMM, hh:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return format.format(date);
  }
}

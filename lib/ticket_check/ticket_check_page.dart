import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/ticket_check/bloc/bloc.dart';
import 'package:conferenceapp/ticket_check/users_list.dart';
import 'package:flutter/material.dart';

import 'manual_ticket_check_page.dart';
import 'scan_party_page.dart';
import 'scan_ticket_page.dart';

class TicketCheckPage extends StatefulWidget {
  @override
  _TicketCheckPageState createState() => _TicketCheckPageState();
}

class _TicketCheckPageState extends State<TicketCheckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Aby zeskanować bilet naciśnij "Skanuj bilety", a następnie skieruj aparat na kod QR na ekranie telefonu uczestnika.'),
            ),
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Skanuj bilety',
                  style: TextStyle(fontSize: 36),
                ),
              ),
              onPressed: () async {
                try {
                  final bloc = TicketCheckBloc();
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScanTicketPage(
                        bloc: bloc,
                      ),
                    ),
                  );
                  bloc.close();
                } catch (e) {}
              },
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sprawdź ręcznie',
                  style: TextStyle(fontSize: 36),
                ),
              ),
              onPressed: () async {
                try {
                  final bloc = TicketCheckBloc();

                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManualTicketPage(
                        bloc: bloc,
                      ),
                    ),
                  );
                  bloc.close();
                } catch (e, s) {
                  logger.errorException(e, s);
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Kontrola na imprezie',
                ),
              ),
              onPressed: () async {
                try {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScanPartyPage(),
                    ),
                  );
                } catch (e) {}
              },
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: Text('Przeglądaj sprawdzone'),
              onPressed: () async {
                try {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UsersListPage(),
                    ),
                  );
                } catch (e, s) {
                  logger.errorException(e, s);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

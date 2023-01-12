import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/generated/l10n.dart';
import 'package:conferenceapp/ticket_check/bloc/bloc.dart';
import 'package:conferenceapp/ticket_check/users_list.dart';
import 'package:flutter/material.dart';

import 'manual_ticket_check_page.dart';
import 'scan_party_page.dart';
import 'scan_ticket_page.dart';

class TicketCheckPage extends StatefulWidget {
  const TicketCheckPage({Key? key}) : super(key: key);

  @override
  TicketCheckPageState createState() => TicketCheckPageState();
}

class TicketCheckPageState extends State<TicketCheckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(S.current.infoScan),
            ),
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.current.scanTicket,
                  style: const TextStyle(fontSize: 36),
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
                } catch (e) {
                  Logger().info(e.toString());
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.current.checkManual,
                  style: const TextStyle(fontSize: 36),
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
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.current.controlParty,
                ),
              ),
              onPressed: () async {
                try {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScanPartyPage(),
                    ),
                  );
                } catch (e) {
                  Logger().info(e.toString());
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: Text(S.current.browseChecked),
              onPressed: () async {
                try {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UsersListPage(),
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

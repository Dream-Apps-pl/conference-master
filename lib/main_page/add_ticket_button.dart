import 'package:conferenceapp/generated/l10n.dart';
import 'package:conferenceapp/ticket/bloc/bloc.dart';
import 'package:conferenceapp/ticket/ticket_page.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class AddTicketButton extends StatelessWidget {
  const AddTicketButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketBloc, TicketState>(
      builder: (context, state) => Padding(
        padding: EdgeInsets.all(12.0),
        child: state is NoTicketState
            ? Padding(
                padding: const EdgeInsets.only(bottom: 36),
                child: FloatingActionButton.extended(
                  icon: DescribedFeatureOverlay(
                    featureId: 'show_ticket',
                    tapTarget: Icon(LineIcons.alternateTicket),
                    title: Text(S.current.addTicket),
                    description: Text(S.current.addTicketTooltip),
                    onComplete: () async {
                      return true;
                    },
                    targetColor: Colors.white,
                    textColor: Colors.white,
                    child: Icon(LineIcons.alternateTicket),
                  ),
                  shape: StadiumBorder(),
                  tooltip: S.current.addTicket,
                  isExtended: true,
                  label: Text(
                    S.current.addTicket,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                  onPressed: () => onPressed(context),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 36),
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  backgroundColor: Theme.of(context).primaryColor,
                  tooltip: S.current.showTicket,
                  isExtended: true,
                  child: DescribedFeatureOverlay(
                    featureId: 'show_ticket',
                    tapTarget: Icon(LineIcons.alternateTicket),
                    title: Text(S.current.addTicket),
                    description: Text(S.current.showTicketTooltip),
                    backgroundColor: Theme.of(context).primaryColor,
                    onComplete: () async {
                      return true;
                    },
                    targetColor: Colors.white,
                    textColor: Colors.white,
                    child: Icon(LineIcons.alternateTicket),
                  ),
                  onPressed: () => onPressed(context),
                ),
              ),
      ),
    );
  }

  void onPressed(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketPage(),
        settings: RouteSettings(name: '/home/ticket_page'),
      ),
    );
  }
}

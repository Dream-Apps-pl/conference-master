import 'package:conferenceapp/common/europe_text_field.dart';
import 'package:conferenceapp/generated/l10n.dart';
import 'package:conferenceapp/ticket_check/scan_ticket_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

class ManualTicketPage extends StatefulWidget {
  final TicketCheckBloc bloc;

  const ManualTicketPage({Key? key, required this.bloc}) : super(key: key);

  @override
  ManualTicketPageState createState() => ManualTicketPageState();
}

class ManualTicketPageState extends State<ManualTicketPage> {
  String value = '';
  String name = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketCheckBloc, TicketCheckState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Ręczne sprawdzanie biletów'),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(S.current.manualInput),
                  ),
                  EuropeTextFormField(
                    hint: S.current.orderNumberOrTicket,
                    maxLength: 20,
                    value: value,
                    onChanged: (val) {
                      setState(() {
                        value = val.toUpperCase();
                      });
                    },
                    textCapitalization: TextCapitalization.characters,
                    onFieldSubmitted: (val) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (value.isNotEmpty) onSearch();
                    },
                  ),
                  Text(S.current.validationOrder),
                  Text(S.current.validationNumber),
                  ElevatedButton(
                    onPressed: value.isNotEmpty ? onSearch : null,
                    child: Text(S.current.search),
                  ),
                  if (state is TicketScannedState)
                    TicketInfo(
                      bloc: widget.bloc,
                      state: state,
                    ),
                  if (state is TicketValidatedState)
                    TicketValidated(
                      bloc: widget.bloc,
                      state: state,
                      onClose: () {
                        widget.bloc.add(InitEvent());
                      },
                    ),
                  if (state is TicketErrorState) TicketError(state.reason),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void onSearch() {
    if (value.length > 9) {
      widget.bloc.add(TicketScanned('_ _ $value'));
    } else {
      widget.bloc.add(TicketScanned('_ $value _'));
    }
  }
}

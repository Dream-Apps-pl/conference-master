import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/generated/l10n.dart';
import 'package:conferenceapp/ticket/widgets/ticket_clipper.dart';
import 'package:conferenceapp/ticket_check/bloc/bloc.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanTicketPage extends StatefulWidget {
  final TicketCheckBloc bloc;

  const ScanTicketPage({Key? key, required this.bloc}) : super(key: key);
  @override
  ScanTicketPageState createState() => ScanTicketPageState();
}

class ScanTicketPageState extends State<ScanTicketPage> {
  bool scanning = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.ticketScanning),
      ),
      body: BlocBuilder<TicketCheckBloc, TicketCheckState>(
          bloc: widget.bloc,
          builder: (context, state) {
            return SafeArea(
              child: Stack(
                children: <Widget>[
                  if (state is NoTicketCheckState)
                    Center(
                      child: _cameraPreviewWidget(),
                    ),
                  ScanTopInfo(scanning: scanning),
                  if (state is LoadingState)
                    const Center(child: CircularProgressIndicator()),
                  if (state is TicketScannedState)
                    TicketInfo(
                      bloc: widget.bloc,
                      state: state,
                    ),
                  if (state is TicketErrorState) TicketError(state.reason),
                ],
              ),
            );
          }),
    );
  }

  Widget _cameraPreviewWidget() {
    return const SizedBox();
    // return MobileScanner(
    //     controller: MobileScannerController(
    //         facing: CameraFacing.front, torchEnabled: true),
    //     onDetect: (capture) {
    //       final List<Barcode> barcodes = capture.barcodes;
    //       if (barcodes.isEmpty) {
    //         widget.bloc.add(TicketScanned(barcodes.first.rawValue!));
    //         debugPrint('Failed to scan Barcode');
    //       } else {
    //         final String code = barcodes.first.rawValue!;
    //         debugPrint('Barcode found! $code');
    //       }
    //     });
  }
}

class TicketError extends StatelessWidget {
  const TicketError(
    this.reason, {
    Key? key,
  }) : super(key: key);
  final String reason;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 200,
              child: FlareActor(
                'assets/flare/fail.flr',
                animation: 'animate',
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
            Text('Błąd: $reason'),
          ],
        ),
      ),
    );
  }
}

class TicketValidated extends StatelessWidget {
  const TicketValidated({
    Key? key,
    this.bloc,
    this.state,
    this.onClose,
  }) : super(key: key);

  final TicketCheckBloc? bloc;
  final TicketValidatedState? state;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                S.current.ticketChecked,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const SizedBox(
                height: 200,
                width: 200,
                child: Center(
                  child: FlareActor(
                    'assets/flare/success.flr',
                    animation: 'Untitled',
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text('${S.current.orderNumber}: ${state?.ticket.orderId}'),
              Text('${S.current.ticketNumber}: ${state?.ticket.ticketId}'),
              ElevatedButton(
                child: Text(S.current.ok),
                onPressed: () {
                  onClose!();
                  // startScanning();
                  bloc!.add(InitEvent());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TicketInfo extends StatelessWidget {
  const TicketInfo({
    Key? key,
    required this.bloc,
    required this.state,
  }) : super(key: key);

  final TicketCheckBloc bloc;
  final TicketScannedState state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipPath(
        clipper: TicketClipper(true, true),
        child: Container(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  S.current.confirmParticipant,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                Text('${S.current.orderNumber}: ${state.ticket.orderId}'),
                Text('${S.current.ticketNumber}: ${state.ticket.ticketId}'),
                Text('${S.current.name}: ${state.name}'),
                const SizedBox(height: 12),
                Text(S.current.technicalData),
                Text(state.ticketChecked
                    ? S.current.ticketAlreadyChecked
                    : S.current.ticketNotChecked),
                Text(
                    '${S.current.ticketLeftOrder}: ${state.leftTicketsInOrderCount}/${state.ticketsInOrderCount}'),
                const SizedBox(height: 12),
                if (state.student)
                  Text(
                    S.current.studentTicket,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(color: Colors.white)),
                      onPressed: () {
                        bloc.add(InitEvent());
                      },
                      child: Text(S.current.cancel),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          textStyle: const TextStyle(color: Colors.white)),
                      onPressed: () {
                        bloc.add(TickedValidated(
                          state.userId,
                          state.ticket,
                        ));
                      },
                      child: Text(S.current.everythingFine),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScanTopInfo extends StatelessWidget {
  const ScanTopInfo({
    Key? key,
    this.scanning = false,
  }) : super(key: key);

  final bool scanning;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white70,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (scanning) Text(S.current.qrScanning),
              if (scanning)
                const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: SizedBox(
                      height: 12,
                      width: 12,
                      child: CircularProgressIndicator(strokeWidth: 1)),
                ),
            ],
          )),
        ),
      ),
    );
  }
}

void logError(String code, String message) =>
    Logger().info('Error: $code\nError Message: $message');

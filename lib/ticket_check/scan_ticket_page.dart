import 'package:conferenceapp/ticket/widgets/ticket_clipper.dart';
import 'package:conferenceapp/ticket_check/bloc/bloc.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanTicketPage extends StatefulWidget {
  final TicketCheckBloc bloc;

  const ScanTicketPage({Key? key, required this.bloc}) : super(key: key);
  @override
  _ScanTicketPageState createState() => _ScanTicketPageState();
}

class _ScanTicketPageState extends State<ScanTicketPage> {
  bool scanning = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket scanning'),
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
                    Center(child: CircularProgressIndicator()),
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
    return MobileScanner(
        controller: MobileScannerController(
            facing: CameraFacing.front, torchEnabled: true),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isEmpty) {
            widget.bloc.add(TicketScanned(barcodes.first.rawValue!));
            debugPrint('Failed to scan Barcode');
          } else {
            final String code = barcodes.first.rawValue!;
            debugPrint('Barcode found! $code');
          }
        });
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
            Container(
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
                'Bilet sprawdzony',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Container(
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
              Text('Zamówienie: ${state?.ticket.orderId}'),
              Text('Bilet: ${state?.ticket.ticketId}'),
              ElevatedButton(
                child: Text('OK'),
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
                  'Potwierdź dane z uczestnikiem',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 12),
                Text('Zamówienie: ${state.ticket.orderId}'),
                Text('Numer biletu: ${state.ticket.ticketId}'),
                Text('Nazwisko: ${state.name}'),
                SizedBox(height: 12),
                Text('Dane techniczne'),
                Text(state.ticketChecked
                    ? 'Bilet już sprawdzony'
                    : 'Bilet jeszcze nie sprawdzony'),
                Text(
                    'Pozostało biletów w zamówieniu: ${state.leftTicketsInOrderCount}/${state.ticketsInOrderCount}'),
                SizedBox(height: 12),
                if (state.student)
                  Text(
                    'Bilet studencki',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text('Anuluj'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          textStyle: TextStyle(color: Colors.white)),
                      onPressed: () {
                        bloc.add(InitEvent());
                      },
                    ),
                    SizedBox(width: 12),
                    ElevatedButton(
                      child: Text('Wszystko OK'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          textStyle: TextStyle(color: Colors.white)),
                      onPressed: () {
                        bloc.add(TickedValidated(
                          state.userId,
                          state.ticket,
                        ));
                      },
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
              if (scanning) Text('Skanowanie kodu QR'),
              if (scanning)
                Padding(
                  padding: const EdgeInsets.all(2.0),
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
    print('Error: $code\nError Message: $message');

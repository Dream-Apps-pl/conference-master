import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPartyPage extends StatelessWidget {
  const ScanPartyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket scanning at the party'),
      ),
      body: ScanPartyPageContent(),
    );
  }
}

class ScanPartyPageContent extends StatefulWidget {
  const ScanPartyPageContent({Key? key}) : super(key: key);
  @override
  _ScanPartyPageContentState createState() => _ScanPartyPageContentState();
}

class _ScanPartyPageContentState extends State<ScanPartyPageContent> {
  bool scanning = true;
  final collection = FirebaseFirestore.instance.collection('party');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Center(
            child: _cameraPreviewWidget(),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: collection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List array = snapshot.data!.docs.toList();
                final length = array.length;
                return Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black45,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        '$length',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    return MobileScanner(
        controller: MobileScannerController(
            facing: CameraFacing.front, torchEnabled: true),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes == null) {
            showInSnackBar('Nie ma takiego biletu ❗️❗️❗️❗️', Colors.red);
            debugPrint('Failed to scan Barcode');
          } else {
            final String code = barcodes.first.rawValue!;
            showInSnackBar('Uczestnik już skanował bilet na imprezę');
          }
        });
  }

  void showInSnackBar(String message, [Color color = Colors.green]) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
    ));
  }

  Future<List> getMatchingTickets(String orderId, String ticketId) async {
    final ticketCollection = await getTicketsCollection();

    final checkByOrder = isCheckedByOrder(orderId);
    final matchigTickets = ticketCollection
        .where(checkByOrder
            ? (t) => t['orderId'] == orderId.toUpperCase()
            : (t) => t['ticketId'] == ticketId.toLowerCase())
        .toList();
    return matchigTickets;
  }

  bool isCheckedByOrder(String orderId) {
    return orderId.length > 1;
  }

  Future<List> getTicketsCollection() async {
    final tickets = await FirebaseFirestore.instance
        .doc('tickets/tickets')
        .snapshots()
        .first;

    final List ticketCollection = tickets.data()!['tickets'];
    return ticketCollection;
  }
}

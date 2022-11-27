import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrImage extends StatelessWidget {
  final String data;
  final int version;
  final int errorCorrectionLevel;
  final Color color;
  final Color backgroundColor;
  final ImageProvider<dynamic> embeddedImage;
  final Size imageSize;

  const QrImage({
    Key? key,
    required this.data,
    this.version = 4,
    this.errorCorrectionLevel = QrErrorCorrectLevel.M,
    this.color = Colors.black,
    this.backgroundColor = Colors.white,
    required this.embeddedImage,
    required this.imageSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final qr.QrPainter _painter = qr.QrPainter(
    //   data: data,
    //   version: qr.QrVersions.auto,
    //   errorCorrectionLevel: errorCorrectionLevel,
    //   color: color,
    //   gapless: true,
    //   emptyColor: backgroundColor,
    // );

    // return qr.QrImage(
    //   foregroundColor: color,
    //   backgroundColor: backgroundColor,
    //   data: data,
    //   errorCorrectionLevel: errorCorrectionLevel,
    //   version: version,
    //   embeddedImage: embeddedImage,
    //   embeddedImageStyle:
    //       imageSize == null ? null : qr.QrEmbeddedImageStyle(size: imageSize),
    // );

    return AnimatedCrossFade(
      firstChild: Container(
        alignment: Alignment.center,
      ),
      secondChild: Builder(builder: (BuildContext context) {
        return SizedBox();
      }),
      crossFadeState: CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 250),
      layoutBuilder: (Widget topChild, Key topChildKey, Widget bottomChild,
          Key bottomChildKey) {
        return Stack(
          children: <Widget>[
            Positioned.fill(
              key: bottomChildKey,
              left: 0.0,
              top: 0.0,
              right: 0.0,
              child: bottomChild,
            ),
            Positioned.fill(
              key: topChildKey,
              child: topChild,
            ),
            if (embeddedImage != null)
              Center(
                child: QrImage(
                  data: data,
                  version: QrVersions.auto,
                  embeddedImage: embeddedImage,
                  imageSize: Size(200.0, 200.0),
                ),
              )
          ],
        );
      },
    );
  }
}

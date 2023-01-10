import 'package:conferenceapp/generated/l10n.dart';
import 'package:flutter/material.dart';

class ImageLicenseText extends StatelessWidget {
  const ImageLicenseText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '${S.current.imageCourtesy} https://undraw.co/',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5),
        ),
      ),
    );
  }
}

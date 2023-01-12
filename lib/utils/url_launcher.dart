import 'package:conferenceapp/common/logger.dart';
import 'package:url_launcher/url_launcher.dart' as lib;

class UrlLauncher {
  static launch(String url) async {
    if (await lib.canLaunchUrl(Uri.parse(url))) {
      try {
        await lib.launchUrl(Uri.parse(url));
      } catch (e, s) {
        logger.errorException(e, s);
      }
    } else {
      logger.info("Url $url couldn't be launched.");
    }
  }
}

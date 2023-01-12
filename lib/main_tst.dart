import 'package:conferenceapp/config.dart';
import 'package:conferenceapp/main_common.dart';

void main() {
  const space = 'CONTENTFUL_SPACE';
  const apiKey = 'CONTENTFUL_API_KEY';
  const snapfeedProjectId = 'SNAPFEED_PROJECTID';
  const snapfeedSecret = 'SNAPFEED_SECRET';
  const bugfenderKey = 'BUGFENDER_KEY';

  final config = AppConfig(
    contentfulApiKey: apiKey,
    contentfulSpace: space,
    flavor: 'tst',
    snapfeedProjectId: snapfeedProjectId,
    snapfeedSecret: snapfeedSecret,
    bugfenderKey: bugfenderKey,
  );
  mainCommon(config: config);
}

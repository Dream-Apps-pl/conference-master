import 'package:conferenceapp/config.dart';
import 'package:conferenceapp/main_common.dart';

void main() {
  const space = 'ofcsncitlvmp';
  const apiKey = 'c9djTE6A5RKoBaYMBuhHRTfQMmwpU0Mwe1BCYiCQUbo';
  const snapfeedProjectId = 'SNAPFEED_PROJECTID';
  const snapfeedSecret = 'SNAPFEED_SECRET';
  final config = AppConfig(
    contentfulApiKey: apiKey,
    contentfulSpace: space,
    flavor: 'dev',
    snapfeedProjectId: snapfeedProjectId,
    snapfeedSecret: snapfeedSecret,
  );
  mainCommon(config: config);
}

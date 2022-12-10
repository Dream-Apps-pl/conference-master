import 'package:conferenceapp/config.dart';
import 'package:conferenceapp/main_common.dart';

void main() {
  final space = 'ofcsncitlvmp';
  final apiKey = 'c9djTE6A5RKoBaYMBuhHRTfQMmwpU0Mwe1BCYiCQUbo';
  final snapfeedProjectId = 'SNAPFEED_PROJECTID';
  final snapfeedSecret = 'SNAPFEED_SECRET';
  final config = AppConfig(
    contentfulApiKey: apiKey,
    contentfulSpace: space,
    flavor: 'dev',
    snapfeedProjectId: snapfeedProjectId,
    snapfeedSecret: snapfeedSecret,
  );
  mainCommon(config: config);
}

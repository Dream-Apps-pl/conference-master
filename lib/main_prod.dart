import 'package:conferenceapp/config.dart';
import 'package:conferenceapp/main_common.dart';

//Moje dane
void main() {
  final space = 'b486ph145db9';
  final apiKey = 'bH4fGddqJ1NdWI3YPO2DjBPMHoJWCL5u3N081mxu1Is';
  final snapfeedProjectId = 'SNAPFEED_PROJECTID';
  final snapfeedSecret = 'SNAPFEED_SECRET';
  final bugfenderKey = 'BUGFENDER_KEY';

  final config = AppConfig(
    contentfulApiKey: apiKey,
    contentfulSpace: space,
    flavor: 'prod',
    snapfeedProjectId: snapfeedProjectId,
    snapfeedSecret: snapfeedSecret,
    bugfenderKey: bugfenderKey,
  );
  mainCommon(config: config);
}

import 'package:conferenceapp/config.dart';
import 'package:conferenceapp/main_common.dart';

//Moje dane
void main() {
  const space = 'b486ph145db9';
  const apiKey = 'bH4fGddqJ1NdWI3YPO2DjBPMHoJWCL5u3N081mxu1Is';
  const snapfeedProjectId = 'SNAPFEED_PROJECTID';
  const snapfeedSecret = 'SNAPFEED_SECRET';
  const bugfenderKey = 'BUGFENDER_KEY';

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

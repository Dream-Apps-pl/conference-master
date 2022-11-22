class AppConfig {
  final String contentfulSpace;
  final String contentfulApiKey;
  final String snapfeedProjectId;
  final String snapfeedSecret;
  final String flavor;
  final String? bugfenderKey;

  AppConfig({
    required this.contentfulSpace,
    required this.contentfulApiKey,
    required this.flavor,
    required this.snapfeedProjectId,
    required this.snapfeedSecret,
    this.bugfenderKey,
  });
}

AppConfig? appConfig;

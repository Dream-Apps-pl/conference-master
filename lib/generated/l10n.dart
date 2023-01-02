// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Agenda`
  String get agenda {
    return Intl.message(
      'Agenda',
      name: 'agenda',
      desc: '',
      args: [],
    );
  }

  /// `My Schedule`
  String get mySchedule {
    return Intl.message(
      'My Schedule',
      name: 'mySchedule',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Admin`
  String get admin {
    return Intl.message(
      'Admin',
      name: 'admin',
      desc: '',
      args: [],
    );
  }

  /// `Add your ticket`
  String get addTicket {
    return Intl.message(
      'Add your ticket',
      name: 'addTicket',
      desc: '',
      args: [],
    );
  }

  /// `Tap this button to add your ticket. You'll need your order or ticket number.`
  String get addTicketTooltip {
    return Intl.message(
      'Tap this button to add your ticket. You\'ll need your order or ticket number.',
      name: 'addTicketTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Show your ticket`
  String get showTicket {
    return Intl.message(
      'Show your ticket',
      name: 'showTicket',
      desc: '',
      args: [],
    );
  }

  /// `Tap this button to see your ticket. You should show it during registration or swag pickup.`
  String get showTicketTooltip {
    return Intl.message(
      'Tap this button to see your ticket. You should show it during registration or swag pickup.',
      name: 'showTicketTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Here you will see your notifications and messages from organizers`
  String get noNotification {
    return Intl.message(
      'Here you will see your notifications and messages from organizers',
      name: 'noNotification',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message(
      'Dark Theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Reminders`
  String get reminders {
    return Intl.message(
      'Reminders',
      name: 'reminders',
      desc: '',
      args: [],
    );
  }

  /// `Disabling reminders won't cancel existing reminders`
  String get remindersDes {
    return Intl.message(
      'Disabling reminders won\'t cancel existing reminders',
      name: 'remindersDes',
      desc: '',
      args: [],
    );
  }

  /// `Sponsors`
  String get sponsors {
    return Intl.message(
      'Sponsors',
      name: 'sponsors',
      desc: '',
      args: [],
    );
  }

  /// `See who supported us`
  String get sponsorsDes {
    return Intl.message(
      'See who supported us',
      name: 'sponsorsDes',
      desc: '',
      args: [],
    );
  }

  /// `Organizers`
  String get organizers {
    return Intl.message(
      'Organizers',
      name: 'organizers',
      desc: '',
      args: [],
    );
  }

  /// `See who created this event`
  String get organizersDes {
    return Intl.message(
      'See who created this event',
      name: 'organizersDes',
      desc: '',
      args: [],
    );
  }

  /// `Code of conduct`
  String get codeOfConduct {
    return Intl.message(
      'Code of conduct',
      name: 'codeOfConduct',
      desc: '',
      args: [],
    );
  }

  /// `Read our rules`
  String get codeOfConductDes {
    return Intl.message(
      'Read our rules',
      name: 'codeOfConductDes',
      desc: '',
      args: [],
    );
  }

  /// `Send feedback`
  String get sendFeedback {
    return Intl.message(
      'Send feedback',
      name: 'sendFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Let us know if you find any errors or want to share your feedback with us`
  String get sendFeedbackDes {
    return Intl.message(
      'Let us know if you find any errors or want to share your feedback with us',
      name: 'sendFeedbackDes',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Open source licenses`
  String get openSourceLicenses {
    return Intl.message(
      'Open source licenses',
      name: 'openSourceLicenses',
      desc: '',
      args: [],
    );
  }

  /// `All the awesome libraries we used to create this app`
  String get openSourceLicensesDes {
    return Intl.message(
      'All the awesome libraries we used to create this app',
      name: 'openSourceLicensesDes',
      desc: '',
      args: [],
    );
  }

  /// `Add Agenda`
  String get addAgenda {
    return Intl.message(
      'Add Agenda',
      name: 'addAgenda',
      desc: '',
      args: [],
    );
  }

  /// `Input agenda to show on agenda page`
  String get addAgendaDes {
    return Intl.message(
      'Input agenda to show on agenda page',
      name: 'addAgendaDes',
      desc: '',
      args: [],
    );
  }

  /// `Day One`
  String get dayOne {
    return Intl.message(
      'Day One',
      name: 'dayOne',
      desc: '',
      args: [],
    );
  }

  /// `Day Two`
  String get dayTwo {
    return Intl.message(
      'Day Two',
      name: 'dayTwo',
      desc: '',
      args: [],
    );
  }

  /// `Day Three`
  String get dayThree {
    return Intl.message(
      'Day Three',
      name: 'dayThree',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Please put a valid title`
  String get titleValidator {
    return Intl.message(
      'Please put a valid title',
      name: 'titleValidator',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Please put a description`
  String get descriptionValidator {
    return Intl.message(
      'Please put a description',
      name: 'descriptionValidator',
      desc: '',
      args: [],
    );
  }

  /// `Beginner`
  String get biginner {
    return Intl.message(
      'Beginner',
      name: 'biginner',
      desc: '',
      args: [],
    );
  }

  /// `Advanced`
  String get advanced {
    return Intl.message(
      'Advanced',
      name: 'advanced',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get startTime {
    return Intl.message(
      'Start Time',
      name: 'startTime',
      desc: '',
      args: [],
    );
  }

  /// `Please select a start time`
  String get startTimeValidator {
    return Intl.message(
      'Please select a start time',
      name: 'startTimeValidator',
      desc: '',
      args: [],
    );
  }

  /// `End Time`
  String get endTime {
    return Intl.message(
      'End Time',
      name: 'endTime',
      desc: '',
      args: [],
    );
  }

  /// `Please select a end time`
  String get endTimeValidator {
    return Intl.message(
      'Please select a end time',
      name: 'endTimeValidator',
      desc: '',
      args: [],
    );
  }

  /// `Teaching form:`
  String get roomAgenda {
    return Intl.message(
      'Teaching form:',
      name: 'roomAgenda',
      desc: '',
      args: [],
    );
  }

  /// `Teaching`
  String get roomA {
    return Intl.message(
      'Teaching',
      name: 'roomA',
      desc: '',
      args: [],
    );
  }

  /// `Workshop`
  String get roomB {
    return Intl.message(
      'Workshop',
      name: 'roomB',
      desc: '',
      args: [],
    );
  }

  /// `Spreaker:`
  String get speakers {
    return Intl.message(
      'Spreaker:',
      name: 'speakers',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Please put a valid name`
  String get nameValidator {
    return Intl.message(
      'Please put a valid name',
      name: 'nameValidator',
      desc: '',
      args: [],
    );
  }

  /// `Long Bio`
  String get longBio {
    return Intl.message(
      'Long Bio',
      name: 'longBio',
      desc: '',
      args: [],
    );
  }

  /// `Please put a bio`
  String get longBioValidator {
    return Intl.message(
      'Please put a bio',
      name: 'longBioValidator',
      desc: '',
      args: [],
    );
  }

  /// `Ocupation`
  String get ocupation {
    return Intl.message(
      'Ocupation',
      name: 'ocupation',
      desc: '',
      args: [],
    );
  }

  /// `Please put a ocapution`
  String get ocupationValidator {
    return Intl.message(
      'Please put a ocapution',
      name: 'ocupationValidator',
      desc: '',
      args: [],
    );
  }

  /// `Link Avatar`
  String get linkAvatar {
    return Intl.message(
      'Link Avatar',
      name: 'linkAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Save Agenda`
  String get saveAgenda {
    return Intl.message(
      'Save Agenda',
      name: 'saveAgenda',
      desc: '',
      args: [],
    );
  }

  /// `Select day no. 3`
  String get selectDayNo3 {
    return Intl.message(
      'Select day no. 3',
      name: 'selectDayNo3',
      desc: '',
      args: [],
    );
  }

  /// `Select day no. 1`
  String get selectDayNo1 {
    return Intl.message(
      'Select day no. 1',
      name: 'selectDayNo1',
      desc: '',
      args: [],
    );
  }

  /// `Day 1`
  String get day1 {
    return Intl.message(
      'Day 1',
      name: 'day1',
      desc: '',
      args: [],
    );
  }

  /// `Select day no. 2`
  String get selectDayNo2 {
    return Intl.message(
      'Select day no. 2',
      name: 'selectDayNo2',
      desc: '',
      args: [],
    );
  }

  /// `Day 2`
  String get day2 {
    return Intl.message(
      'Day 2',
      name: 'day2',
      desc: '',
      args: [],
    );
  }

  /// `Day 3`
  String get day3 {
    return Intl.message(
      'Day 3',
      name: 'day3',
      desc: '',
      args: [],
    );
  }

  /// `Sponsor Level`
  String get sponsorLevel {
    return Intl.message(
      'Sponsor Level',
      name: 'sponsorLevel',
      desc: '',
      args: [],
    );
  }

  /// `Link Sponsor`
  String get linkSponsor {
    return Intl.message(
      'Link Sponsor',
      name: 'linkSponsor',
      desc: '',
      args: [],
    );
  }

  /// `Logo Sponsor`
  String get logoSponsor {
    return Intl.message(
      'Logo Sponsor',
      name: 'logoSponsor',
      desc: '',
      args: [],
    );
  }

  /// `Save Sponsor`
  String get saveSponsor {
    return Intl.message(
      'Save Sponsor',
      name: 'saveSponsor',
      desc: '',
      args: [],
    );
  }

  /// `Can't be empty`
  String get cantEmpty {
    return Intl.message(
      'Can\'t be empty',
      name: 'cantEmpty',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

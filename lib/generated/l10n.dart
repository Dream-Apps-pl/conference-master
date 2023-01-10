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

  /// `Save Organizer`
  String get saveOrganizer {
    return Intl.message(
      'Save Organizer',
      name: 'saveOrganizer',
      desc: '',
      args: [],
    );
  }

  /// `Notification will be sent to the users and visible in Notifications panel`
  String get notifAdmin {
    return Intl.message(
      'Notification will be sent to the users and visible in Notifications panel',
      name: 'notifAdmin',
      desc: '',
      args: [],
    );
  }

  /// `Add new ticketer`
  String get addNewTicker {
    return Intl.message(
      'Add new ticketer',
      name: 'addNewTicker',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Search for a talk or speaker`
  String get search {
    return Intl.message(
      'Search for a talk or speaker',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Change the layout of the agenda`
  String get hintLayout {
    return Intl.message(
      'Change the layout of the agenda',
      name: 'hintLayout',
      desc: '',
      args: [],
    );
  }

  /// `Toggle agenda layout`
  String get toggleLayout {
    return Intl.message(
      'Toggle agenda layout',
      name: 'toggleLayout',
      desc: '',
      args: [],
    );
  }

  /// `Tap this icon to change layout to full width. Tap anywhere else to dismiss this info.`
  String get toggleDescription {
    return Intl.message(
      'Tap this icon to change layout to full width. Tap anywhere else to dismiss this info.',
      name: 'toggleDescription',
      desc: '',
      args: [],
    );
  }

  /// `Venue`
  String get venue {
    return Intl.message(
      'Venue',
      name: 'venue',
      desc: '',
      args: [],
    );
  }

  /// `Conference Centre`
  String get conferenceCenter {
    return Intl.message(
      'Conference Centre',
      name: 'conferenceCenter',
      desc: '',
      args: [],
    );
  }

  /// `Copernicus Science Centre`
  String get scienceCenter {
    return Intl.message(
      'Copernicus Science Centre',
      name: 'scienceCenter',
      desc: '',
      args: [],
    );
  }

  /// `Kosciuszko Coast 20`
  String get wybrzeze {
    return Intl.message(
      'Kosciuszko Coast 20',
      name: 'wybrzeze',
      desc: '',
      args: [],
    );
  }

  /// `00-390 Warsaw`
  String get warsaw {
    return Intl.message(
      '00-390 Warsaw',
      name: 'warsaw',
      desc: '',
      args: [],
    );
  }

  /// `Please fill this field.`
  String get pleaseFill {
    return Intl.message(
      'Please fill this field.',
      name: 'pleaseFill',
      desc: '',
      args: [],
    );
  }

  /// `This field should have {count} characters.`
  String shouldHave(Object count) {
    return Intl.message(
      'This field should have $count characters.',
      name: 'shouldHave',
      desc: '',
      args: [count],
    );
  }

  /// `Ups, the app seems a bit outdated.`
  String get outdatedTitle {
    return Intl.message(
      'Ups, the app seems a bit outdated.',
      name: 'outdatedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please update the app by downloading it from the store. It seems that we had a bug that we had to fix.`
  String get outdatedSubtitle {
    return Intl.message(
      'Please update the app by downloading it from the store. It seems that we had a bug that we had to fix.',
      name: 'outdatedSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `An error has occured!`
  String get anError {
    return Intl.message(
      'An error has occured!',
      name: 'anError',
      desc: '',
      args: [],
    );
  }

  /// `Login to continue`
  String get login {
    return Intl.message(
      'Login to continue',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Logged in`
  String get logged {
    return Intl.message(
      'Logged in',
      name: 'logged',
      desc: '',
      args: [],
    );
  }

  /// `Error during log in`
  String get errorLogin {
    return Intl.message(
      'Error during log in',
      name: 'errorLogin',
      desc: '',
      args: [],
    );
  }

  /// `Registered and logged in`
  String get registered {
    return Intl.message(
      'Registered and logged in',
      name: 'registered',
      desc: '',
      args: [],
    );
  }

  /// `Error during registration`
  String get errorRegister {
    return Intl.message(
      'Error during registration',
      name: 'errorRegister',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Logged out`
  String get loggedOut {
    return Intl.message(
      'Logged out',
      name: 'loggedOut',
      desc: '',
      args: [],
    );
  }

  /// `Poland`
  String get poland {
    return Intl.message(
      'Poland',
      name: 'poland',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Send e-mail`
  String get sendEmail {
    return Intl.message(
      'Send e-mail',
      name: 'sendEmail',
      desc: '',
      args: [],
    );
  }

  /// `About the app`
  String get aboutApp {
    return Intl.message(
      'About the app',
      name: 'aboutApp',
      desc: '',
      args: [],
    );
  }

  /// `Write a review`
  String get writeReview {
    return Intl.message(
      'Write a review',
      name: 'writeReview',
      desc: '',
      args: [],
    );
  }

  /// `How did you like the talk? (min. 10 letters).`
  String get reviewHint {
    return Intl.message(
      'How did you like the talk? (min. 10 letters).',
      name: 'reviewHint',
      desc: '',
      args: [],
    );
  }

  /// `Review will be visible only to the speaker.`
  String get reviewHintVisible {
    return Intl.message(
      'Review will be visible only to the speaker.',
      name: 'reviewHintVisible',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get searchHint {
    return Intl.message(
      'Search',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `You received your ticket to your e-mail after the purchase. In case of problems contact us at tickets@fluttereurope.dev or ask someone from the staff at the conference.`
  String get notifTicketEmail {
    return Intl.message(
      'You received your ticket to your e-mail after the purchase. In case of problems contact us at tickets@fluttereurope.dev or ask someone from the staff at the conference.',
      name: 'notifTicketEmail',
      desc: '',
      args: [],
    );
  }

  /// `Image courtesy of`
  String get imageCourtesy {
    return Intl.message(
      'Image courtesy of',
      name: 'imageCourtesy',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Add your ticket by providing either order number or ticket number`
  String get addTicketNumber {
    return Intl.message(
      'Add your ticket by providing either order number or ticket number',
      name: 'addTicketNumber',
      desc: '',
      args: [],
    );
  }

  /// `Your ticket`
  String get yourTicket {
    return Intl.message(
      'Your ticket',
      name: 'yourTicket',
      desc: '',
      args: [],
    );
  }

  /// `Show this QR code during registration at the event`
  String get showQr {
    return Intl.message(
      'Show this QR code during registration at the event',
      name: 'showQr',
      desc: '',
      args: [],
    );
  }

  /// `Ticket validated ✔️`
  String get ticetValidated {
    return Intl.message(
      'Ticket validated ✔️',
      name: 'ticetValidated',
      desc: '',
      args: [],
    );
  }

  /// `Order number`
  String get orderNumber {
    return Intl.message(
      'Order number',
      name: 'orderNumber',
      desc: '',
      args: [],
    );
  }

  /// `Ticket number`
  String get ticketNumber {
    return Intl.message(
      'Ticket number',
      name: 'ticketNumber',
      desc: '',
      args: [],
    );
  }

  /// `Order number (OTXXXXXXX)`
  String get hintOrderNumber {
    return Intl.message(
      'Order number (OTXXXXXXX)',
      name: 'hintOrderNumber',
      desc: '',
      args: [],
    );
  }

  /// `Order number should start with OT`
  String get orderNumberValidation {
    return Intl.message(
      'Order number should start with OT',
      name: 'orderNumberValidation',
      desc: '',
      args: [],
    );
  }

  /// `Ticket number (xXxXxXxXxXxXxX)`
  String get ticketNumberHint {
    return Intl.message(
      'Ticket number (xXxXxXxXxXxXxX)',
      name: 'ticketNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `We have some problems 😅`
  String get weHaveProblem {
    return Intl.message(
      'We have some problems 😅',
      name: 'weHaveProblem',
      desc: '',
      args: [],
    );
  }

  /// `Remove ticket`
  String get removeTicket {
    return Intl.message(
      'Remove ticket',
      name: 'removeTicket',
      desc: '',
      args: [],
    );
  }

  /// `Here you can manually enter the data if the scan failed`
  String get manualInput {
    return Intl.message(
      'Here you can manually enter the data if the scan failed',
      name: 'manualInput',
      desc: '',
      args: [],
    );
  }

  /// `Order number or ticket number`
  String get orderNumberOrTicket {
    return Intl.message(
      'Order number or ticket number',
      name: 'orderNumberOrTicket',
      desc: '',
      args: [],
    );
  }

  /// `The order number (order no.) is 9 characters long and starts with OT`
  String get validationOrder {
    return Intl.message(
      'The order number (order no.) is 9 characters long and starts with OT',
      name: 'validationOrder',
      desc: '',
      args: [],
    );
  }

  /// `The ticket id has 20 characters`
  String get validationNumber {
    return Intl.message(
      'The ticket id has 20 characters',
      name: 'validationNumber',
      desc: '',
      args: [],
    );
  }

  /// `Ticket scanning at the party`
  String get scanAtParty {
    return Intl.message(
      'Ticket scanning at the party',
      name: 'scanAtParty',
      desc: '',
      args: [],
    );
  }

  /// `Ticket scanning`
  String get ticketScanning {
    return Intl.message(
      'Ticket scanning',
      name: 'ticketScanning',
      desc: '',
      args: [],
    );
  }

  /// `Ticket checked`
  String get ticketChecked {
    return Intl.message(
      'Ticket checked',
      name: 'ticketChecked',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Confirm the details with the participant`
  String get confirmParticipant {
    return Intl.message(
      'Confirm the details with the participant',
      name: 'confirmParticipant',
      desc: '',
      args: [],
    );
  }

  /// `Technical data`
  String get technicalData {
    return Intl.message(
      'Technical data',
      name: 'technicalData',
      desc: '',
      args: [],
    );
  }

  /// `Ticket already checked`
  String get ticketAlreadyChecked {
    return Intl.message(
      'Ticket already checked',
      name: 'ticketAlreadyChecked',
      desc: '',
      args: [],
    );
  }

  /// `Ticket not checked yet`
  String get ticketNotChecked {
    return Intl.message(
      'Ticket not checked yet',
      name: 'ticketNotChecked',
      desc: '',
      args: [],
    );
  }

  /// `There are tickets left in the order`
  String get ticketLeftOrder {
    return Intl.message(
      'There are tickets left in the order',
      name: 'ticketLeftOrder',
      desc: '',
      args: [],
    );
  }

  /// `Student ticket`
  String get studentTicket {
    return Intl.message(
      'Student ticket',
      name: 'studentTicket',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Everything's fine`
  String get everythingFine {
    return Intl.message(
      'Everything\'s fine',
      name: 'everythingFine',
      desc: '',
      args: [],
    );
  }

  /// `QR code scanning`
  String get qrScanning {
    return Intl.message(
      'QR code scanning',
      name: 'qrScanning',
      desc: '',
      args: [],
    );
  }

  /// `To scan the ticket, press 'Scan tickets' and then point the camera at the QR code on the participant's phone screen.`
  String get infoScan {
    return Intl.message(
      'To scan the ticket, press \'Scan tickets\' and then point the camera at the QR code on the participant\'s phone screen.',
      name: 'infoScan',
      desc: '',
      args: [],
    );
  }

  /// `Scan tickets`
  String get scanTicket {
    return Intl.message(
      'Scan tickets',
      name: 'scanTicket',
      desc: '',
      args: [],
    );
  }

  /// `Check manually`
  String get checkManual {
    return Intl.message(
      'Check manually',
      name: 'checkManual',
      desc: '',
      args: [],
    );
  }

  /// `Control at the party`
  String get controlParty {
    return Intl.message(
      'Control at the party',
      name: 'controlParty',
      desc: '',
      args: [],
    );
  }

  /// `Browse checked`
  String get browseChecked {
    return Intl.message(
      'Browse checked',
      name: 'browseChecked',
      desc: '',
      args: [],
    );
  }

  /// `Search by order ID`
  String get searchByOrder {
    return Intl.message(
      'Search by order ID',
      name: 'searchByOrder',
      desc: '',
      args: [],
    );
  }

  /// `All checked`
  String get allChecked {
    return Intl.message(
      'All checked',
      name: 'allChecked',
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

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map json) => Ticket(
      json['orderId'] as String,
      json['ticketId'] as String,
    );

const _$TicketFieldMap = <String, String>{
  'orderId': 'orderId',
  'ticketId': 'ticketId',
};

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'ticketId': instance.ticketId,
    };

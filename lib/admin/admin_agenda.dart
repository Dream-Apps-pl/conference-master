import 'package:conferenceapp/agenda/repository/firestore_service_repository.dart';
import 'package:conferenceapp/model/author.dart';
import 'package:conferenceapp/model/room.dart';
import 'package:conferenceapp/model/talk.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum RoomType { roomA, roomB }

class AdminAgenda extends StatefulWidget {
  const AdminAgenda({Key? key}) : super(key: key);

  @override
  State<AdminAgenda> createState() => _AdminAgendaState();
}

class _AdminAgendaState extends State<AdminAgenda> {
  final _formKey = GlobalKey<FormState>();
  int? _value = 1;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TalkType? _talkType = TalkType.beginner;
  RoomType? _roomType = RoomType.roomA;

  String? startDate;
  String? endDate;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _longBioController = TextEditingController();
  TextEditingController _ocupationController = TextEditingController();
  TextEditingController _twitterController = TextEditingController();
  TextEditingController _avatarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              title: Text('Agenda'),
              trailing: Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ChoiceChip(
                      label: Text('Day One'),
                      selected: _value == 1,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? 1 : null;
                        });
                      },
                    ),
                    SizedBox(width: 5),
                    ChoiceChip(
                      label: Text('Day Two'),
                      selected: _value == 2,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? 2 : null;
                        });
                      },
                    ),
                    SizedBox(width: 5),
                    ChoiceChip(
                      label: Text('Day Three'),
                      selected: _value == 3,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? 3 : null;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _titleController,
                    validator: (val) {
                      return val?.isEmpty == true
                          ? 'please put a valid title'
                          : null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    validator: (val) {
                      return val?.isEmpty == true
                          ? 'please put a description'
                          : null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Beginner'),
                    leading: Radio<TalkType>(
                      value: TalkType.beginner,
                      groupValue: _talkType,
                      onChanged: (TalkType? value) {
                        setState(() {
                          _talkType = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Advanced'),
                    leading: Radio<TalkType>(
                      value: TalkType.advanced,
                      groupValue: _talkType,
                      onChanged: (TalkType? value) {
                        setState(() {
                          _talkType = value;
                        });
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DateTimePicker(
                          type: DateTimePickerType.dateTime,
                          initialValue: '',
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          dateLabelText: 'Start Time',
                          validator: (val) {
                            return val?.isEmpty == true
                                ? 'please select a start time'
                                : null;
                          },
                          onChanged: (val) => setState(() {
                            startDate = val;
                          }),
                          onSaved: (val) => setState(() {
                            startDate = val;
                          }),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: DateTimePicker(
                          type: DateTimePickerType.dateTime,
                          initialValue: '',
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          dateLabelText: 'End Time',
                          validator: (val) {
                            return val?.isEmpty == true
                                ? 'please select a end time'
                                : null;
                          },
                          onChanged: (val) => setState(() {
                            endDate = val;
                          }),
                          onSaved: (val) => setState(() {
                            endDate = val;
                          }),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Room Agenda',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Room A'),
                          leading: Radio<RoomType>(
                            value: RoomType.roomA,
                            groupValue: _roomType,
                            onChanged: (RoomType? value) {
                              setState(() {
                                _roomType = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Room B'),
                          leading: Radio<RoomType>(
                            value: RoomType.roomB,
                            groupValue: _roomType,
                            onChanged: (RoomType? value) {
                              setState(() {
                                _roomType = value;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Speakers',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _nameController,
                    validator: (val) {
                      return val?.isEmpty == true
                          ? 'please put a valid name'
                          : null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  TextFormField(
                    controller: _longBioController,
                    validator: (val) {
                      return val?.isEmpty == true ? 'please put a bio' : null;
                    },
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Long Bio',
                    ),
                  ),
                  TextFormField(
                    controller: _ocupationController,
                    validator: (val) {
                      return val?.isEmpty == true
                          ? 'please put a ocapution'
                          : null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Ocupation',
                    ),
                  ),
                  TextField(
                    controller: _twitterController,
                    decoration: InputDecoration(
                      labelText: 'Twitter',
                    ),
                  ),
                  TextField(
                    controller: _avatarController,
                    decoration: InputDecoration(
                      labelText: 'Link Avatar',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: _onSaveAgenda,
                child: Text('Save Agenda'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onSaveAgenda() {
    var uuid = Uuid();
    if (_formKey.currentState!.validate()) {
      List<Author> _author = [
        Author(
          '${uuid.v4()}',
          _nameController.text,
          _longBioController.text,
          _ocupationController.text,
          _twitterController.text,
          _avatarController.text,
        )
      ];
      Room _room;
      if (_roomType == RoomType.roomA) {
        _room = Room('A', '0');
      } else {
        _room = Room('B', '1');
      }

      // if (_value == 1) {
      //   DayType.one;
      // }
      // if (_value == 2) {
      //   DayType.two;
      // } else {
      //   DayType.three;
      // }

      Talk _talk = Talk(
        '${uuid.v1()}',
        _titleController.text,
        _author,
        _descriptionController.text,
        DateTime.parse(startDate!),
        DateTime.parse(endDate!),
        _room,
        _talkType!,
        _value == 1 ? DayType.one : DayType.two, //DayType.three ??
      );
      FirestoreService()
          .addTalk(_talk)
          .whenComplete(() => Navigator.pop(context));
    }
  }
}

import 'package:conferenceapp/agenda/repository/firestore_service_repository.dart';
import 'package:conferenceapp/generated/l10n.dart';
import 'package:conferenceapp/model/organizer.dart';
import 'package:flutter/material.dart';

class AdminOrganizer extends StatefulWidget {
  const AdminOrganizer({Key? key}) : super(key: key);

  @override
  State<AdminOrganizer> createState() => _AdminOrganizerState();
}

class _AdminOrganizerState extends State<AdminOrganizer> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _longBioController = TextEditingController();
  TextEditingController _avatarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    validator: (val) {
                      return val?.isEmpty == true
                          ? S.current.nameValidator
                          : null;
                    },
                    decoration: InputDecoration(
                      labelText: S.current.name,
                    ),
                  ),
                  TextFormField(
                    controller: _longBioController,
                    validator: (val) {
                      return val?.isEmpty == true
                          ? S.current.longBioValidator
                          : null;
                    },
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: S.current.longBio,
                    ),
                  ),
                  TextField(
                    controller: _avatarController,
                    decoration: InputDecoration(
                      labelText: S.current.linkAvatar,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: _onSaveOrganizer,
                child: Text(S.current.saveOrganizer),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onSaveOrganizer() {
    if (_formKey.currentState!.validate()) {
      Organizer _organizer = Organizer(
        _nameController.text,
        _longBioController.text,
        _avatarController.text,
      );
      FirestoreService()
          .addOrganizer(_organizer)
          .whenComplete(() => Navigator.pop(context));
    }
  }
}

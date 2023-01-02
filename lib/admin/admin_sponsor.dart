import 'package:conferenceapp/agenda/repository/firestore_service_repository.dart';
import 'package:conferenceapp/generated/l10n.dart';
import 'package:conferenceapp/model/sponsor.dart';
import 'package:flutter/material.dart';

class AdminSponsor extends StatefulWidget {
  const AdminSponsor({Key? key}) : super(key: key);

  @override
  State<AdminSponsor> createState() => _AdminSponsorState();
}

class _AdminSponsorState extends State<AdminSponsor> {
  final _formKey = GlobalKey<FormState>();
  SponsorLevel _sponsorLevel = SponsorLevel.bronze;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _urlController = TextEditingController();
  TextEditingController _logoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              title: Text(S.current.sponsorLevel),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Wrap(
                children: [
                  ChoiceChip(
                    label: Text(SponsorLevel.bronze.name),
                    selected: _sponsorLevel == SponsorLevel.bronze,
                    onSelected: (bool selected) {
                      setState(() {
                        _sponsorLevel = selected
                            ? SponsorLevel.bronze
                            : SponsorLevel.bronze;
                      });
                    },
                  ),
                  SizedBox(width: 5),
                  ChoiceChip(
                    label: Text(SponsorLevel.gold.name),
                    selected: _sponsorLevel == SponsorLevel.gold,
                    onSelected: (bool selected) {
                      setState(() {
                        _sponsorLevel =
                            selected ? SponsorLevel.gold : SponsorLevel.bronze;
                      });
                    },
                  ),
                  SizedBox(width: 5),
                  ChoiceChip(
                    label: Text(SponsorLevel.platinium.name),
                    selected: _sponsorLevel == SponsorLevel.platinium,
                    onSelected: (bool selected) {
                      setState(() {
                        _sponsorLevel = selected
                            ? SponsorLevel.platinium
                            : SponsorLevel.bronze;
                      });
                    },
                  ),
                  SizedBox(width: 5),
                  ChoiceChip(
                    label: Text(SponsorLevel.silver.name),
                    selected: _sponsorLevel == SponsorLevel.silver,
                    onSelected: (bool selected) {
                      setState(() {
                        _sponsorLevel = selected
                            ? SponsorLevel.silver
                            : SponsorLevel.bronze;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    validator: (val) {
                      return val?.isEmpty == true ? S.current.cantEmpty : null;
                    },
                    decoration: InputDecoration(
                      labelText: S.current.name,
                    ),
                  ),
                  TextFormField(
                    controller: _urlController,
                    validator: (val) {
                      return val?.isEmpty == true ? S.current.cantEmpty : null;
                    },
                    decoration: InputDecoration(
                      labelText: S.current.linkSponsor,
                    ),
                  ),
                  TextField(
                    controller: _logoController,
                    decoration: InputDecoration(
                      labelText: S.current.logoSponsor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: _onSaveSponsor,
                child: Text(S.current.saveSponsor),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onSaveSponsor() {
    if (_formKey.currentState!.validate()) {
      Sponsor _sponsor = Sponsor(
        _nameController.text,
        _logoController.text,
        _urlController.text,
        _sponsorLevel,
      );

      FirestoreService()
          .addSponsor(_sponsor)
          .whenComplete(() => Navigator.pop(context));
    }
  }
}

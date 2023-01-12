import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:conferenceapp/common/appbar.dart';
import 'package:conferenceapp/model/organizer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class OrganizersPage extends StatelessWidget {
  const OrganizersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FlutterEuropeAppBar(
        back: true,
        search: false,
      ),
      body: FirestoreBuilder<OrganizerQuerySnapshot>(
        ref: organizerRef,
        builder: (BuildContext context,
            AsyncSnapshot<OrganizerQuerySnapshot> snapshot, Widget? child) {
          if (snapshot.hasData) {
            OrganizerQuerySnapshot sponsorSnapshot = snapshot.requireData;

            return GridView.count(
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 2
                      : 4,
              children: sponsorSnapshot.docs
                  .map((f) => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: InkResponse(
                          onTap: () {},
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: ExtendedImage.network(
                                  f.data.picture,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  color: Colors.black54,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        f.data.name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: InkWell(onTap: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (context) => SimpleDialog(
                                              title: Text(f.data.name),
                                              contentPadding:
                                                  const EdgeInsets.all(24.0),
                                              children: <Widget>[
                                                Text(f.data.longBio),
                                              ],
                                            ));
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            );
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

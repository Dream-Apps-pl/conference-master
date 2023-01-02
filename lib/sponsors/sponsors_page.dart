import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:collection/collection.dart';
import 'package:conferenceapp/common/appbar.dart';
import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/generated/l10n.dart';
import 'package:conferenceapp/model/sponsor.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FlutterEuropeAppBar(
        back: true,
        search: false,
      ),
      body: Container(
        color: Colors.white,
        child: FirestoreBuilder<SponsorQuerySnapshot>(
          ref: sponsorRef,
          builder: (BuildContext context,
              AsyncSnapshot<SponsorQuerySnapshot> snapshot, Widget? child) {
            if (snapshot.hasData) {
              SponsorQuerySnapshot sponsorSnapshot = snapshot.requireData;
              final elems = <Widget>[];
              final grouped = groupBy(sponsorSnapshot.docs,
                  (SponsorQueryDocumentSnapshot f) => f.data.level);
              grouped.forEach((g, list) {
                elems.add(Center(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '${S.current.sponsorLevel}: ${g.toString().split(".")[1]}',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )));
                list.forEach(
                  (s) => elems.add(
                    Padding(
                      padding: const EdgeInsets.only(bottom: 26.0, top: 18.0),
                      child: ListTile(
                        title: Container(
                          width: 560,
                          height: 150,
                          child: ExtendedImage.network(
                            s.data.logo,
                            width: 560,
                          ),
                        ),
                        onTap: () async {
                          if (await canLaunchUrl(Uri.parse(s.data.url))) {
                            await launchUrl(Uri.parse(s.data.url));
                          } else {
                            logger.info('Could not launch ${s.data.url}');
                          }
                        },
                      ),
                    ),
                  ),
                );
                elems.add(SizedBox(height: 30));
              });

              return ListView(
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                padding: EdgeInsets.all(12.0),
                children: elems,
              );
            } else {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

// ignore_for_file: unnecessary_null_comparison

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:conferenceapp/agenda/widgets/talk_card_widgets/favorite_button.dart';
import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/model/author.dart';
import 'package:conferenceapp/model/talk.dart';
import 'package:conferenceapp/profile/favorites_repository.dart';
import 'package:conferenceapp/rate/bloc/bloc.dart';
import 'package:conferenceapp/rate/effects/show_rating_talk_too_early_error.dart';
import 'package:conferenceapp/rate/repository/ratings_repository.dart';
import 'package:conferenceapp/rate/widgets/review_button.dart';
import 'package:conferenceapp/rate/widgets/review_text.dart';
import 'package:conferenceapp/rate/widgets/star_rating.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:expandable/expandable.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class TalkPage extends StatelessWidget {
  const TalkPage(this.data, {Key? key}) : super(key: key);

  final Talk data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add to calendar',
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: data != null
            ? () {
                try {
                  final Event event = Event(
                    title: data.title,
                    description: data.description,
                    location:
                        'Centrum konferencyjne w Centrum Nauki Kopernik, Wybrzeże Kościuszkowskie 20, 00-390 Warszawa',
                    startDate: data.startTime,
                    endDate: data.endTime,
                    allDay: false,
                  );

                  Add2Calendar.addEvent2Cal(event);
                } catch (e, s) {
                  logger.errorException(e, s);
                }
              }
            : null,
        child: const Icon(LineIcons.calendarPlus),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverAppBar(
            floating: false,
            pinned: false,
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
            actions: data != null
                ? <Widget>[
                    TalkDetailsFavoriteButton(talk: data),
                  ]
                : null,
            title: data != null ? Text(data.title) : null,
            centerTitle: false,
          ),
          (data != null)
              ? SliverList(
                  delegate: SliverChildListDelegate([
                    TopHeader(talk: data),
                    TalkTitle(talk: data),
                    // TalkRating(talk: talkSnapshot.docs.first.data),
                    if (data.description != null) TalkDetails(talk: data),
                  ]),
                )
              : const SliverFillRemaining(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class TalkRating extends StatefulWidget {
  const TalkRating({
    Key? key,
    required this.talk,
  }) : super(key: key);

  final Talk talk;

  @override
  TalkRatingState createState() => TalkRatingState();
}

class TalkRatingState extends State<TalkRating> {
  late RateBloc _rateBloc;
  double rating = 0.0;

  @override
  void dispose() {
    _rateBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _rateBloc = RateBloc(Provider.of<RatingsRepository>(context))
      ..add(FetchRateTalk(widget.talk));

    return BlocListener<RateBloc, RateState>(
      bloc: _rateBloc,
      listener: (context, state) {
        if (state is RatingTalkToEarlyErrorState) {
          showRatingTalkTooEarlyError(context);
        }
      },
      child: BlocBuilder<RateBloc, RateState>(
        bloc: _rateBloc,
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const Text('Rate the talk'),
              StarRating(
                onRatingChanged: (r) {
                  _rateBloc.add(RateTalk(widget.talk, r));
                },
                rating: _rateBloc.rating,
              ),
              _rateBloc.review != null && _rateBloc.review.isNotEmpty
                  ? ReviewText(_rateBloc.review,
                      onReviewSubmitted: onReviewSubmitted)
                  : ReviewButton(
                      onReviewSubmitted: onReviewSubmitted,
                      canReviewDelegate: () =>
                          _rateBloc.canRateTalk(widget.talk),
                    ),
              if (state is TalkRatedState)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: shareToTwitter,
                    child: RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: const [
                            TextSpan(
                              text: 'Enjoyed the talk? Share it on Twitter! ',
                            ),
                            WidgetSpan(
                              child: Icon(
                                LineIcons.twitter,
                                color: Colors.blue,
                                size: 18,
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void onReviewSubmitted(String review) {
    if (review != null) {
      _rateBloc.add(ReviewTalk(widget.talk, review));
    }
  }

  void shareToTwitter() {
    try {
      final twitters = widget.talk.authors
          .map((f) => f.twitter.isNotEmpty == true
              ? '@${f.twitter.split('/').last}'
              : '')
          .join(' ');
      final body =
          'I really enjoyed talk ${widget.talk.title} by ${widget.talk.authors.join(', ')} at @FlutterEurope #fluttereurope $twitters';
      Share.share(
        body,
        subject: body,
      );
    } catch (e, s) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Ups, we have a problem here.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ));
      logger.error('Problem during share to Twitter');
      logger.errorException(e, s);
    }
  }
}

class TalkTitle extends StatelessWidget {
  const TalkTitle({
    Key? key,
    required this.talk,
  }) : super(key: key);

  final Talk talk;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        talk.title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}

class TalkDetails extends StatelessWidget {
  const TalkDetails({
    Key? key,
    required this.talk,
  }) : super(key: key);

  final Talk talk;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 6),
          const Text(
            'Description',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          // ContentfulRichText(talk.descriptionMap).documentToWidgetTree,
          const SizedBox(height: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Speakers',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              for (var author in talk.authors)
                CustomExpandablePanel(
                  header: author.name,
                  content: author.longBio,
                ),
            ],
          ),
          const SizedBox(height: 56),
        ],
      ),
    );
  }
}

class CustomExpandablePanel extends StatelessWidget {
  const CustomExpandablePanel({
    Key? key,
    this.header,
    required this.content,
  }) : super(key: key);

  final String? header;
  final String content;

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      header: header != null
          ? Row(
              children: <Widget>[
                Text(
                  header!,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          : null,
      collapsed: ExpandableButton(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Text(
                content,
                softWrap: true,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ExpandableIcon(
              theme: ExpandableThemeData.combine(
                ExpandableThemeData(
                  iconColor: Theme.of(context).textTheme.bodyLarge!.color,
                ),
                ExpandableThemeData.defaults,
              ),
            )
          ],
        ),
      ),
      expanded: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Text(
              content,
              softWrap: true,
            ),
          ),
          ExpandableIcon(
            theme: ExpandableThemeData.combine(
              ExpandableThemeData(
                iconColor: Theme.of(context).textTheme.bodyLarge!.color,
              ),
              ExpandableThemeData.defaults,
            ),
          )
        ],
      ),
    );
  }
}

class TopHeader extends StatelessWidget {
  const TopHeader({
    Key? key,
    required this.talk,
  }) : super(key: key);

  final Talk talk;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (var author in talk.authors)
          Flexible(
            child: Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        children: <Widget>[
                          DottedBorder(
                            borderType: BorderType.Circle,
                            dashPattern: const [4, 4],
                            child: Center(
                              child: CircleAvatar(
                                radius: 120,
                                backgroundImage: ExtendedNetworkImageProvider(
                                  '${author.avatar}?fit=fill&w=300&h=300',
                                  cache: true,
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: TwitterButton(author: author),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SpeakerNameAndJob(author: author),
              ],
            ),
          ),
      ],
    );
  }
}

class SpeakerNameAndJob extends StatelessWidget {
  const SpeakerNameAndJob({
    Key? key,
    required this.author,
  }) : super(key: key);

  final Author author;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            author.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            author.occupation,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class TwitterButton extends StatelessWidget {
  const TwitterButton({
    Key? key,
    required this.author,
  }) : super(key: key);

  final Author author;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(32),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      child: IconButton(
        onPressed: () {
          openTwitter(author.twitter);
        },
        iconSize: 32,
        tooltip: 'See Twitter profile',
        color: Colors.blue,
        padding: const EdgeInsets.all(0.0),
        // visualDensity: VisualDensity.compact,
        icon: const Icon(LineIcons.twitter),
      ),
    );
  }

  void openTwitter(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      logger.warn('Could not launch $url');
    }
  }
}

class TalkDetailsFavoriteButton extends StatelessWidget {
  const TalkDetailsFavoriteButton({
    Key? key,
    required this.talk,
  }) : super(key: key);

  final Talk talk;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Talk>>(
      stream: Provider.of<FavoritesRepository>(context).favoriteTalks,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final fav = snapshot.data!.firstWhere(
                (Talk n) => n.id == talk.id,
              ) !=
              null;
          return FavoriteButton(
            isFavorite: fav,
            talk: talk,
          );
        }
        return Container();
      },
    );
  }
}

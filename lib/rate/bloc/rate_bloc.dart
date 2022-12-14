import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/model/talk.dart';
import 'package:conferenceapp/rate/repository/ratings_repository.dart';
import 'package:rxdart/rxdart.dart';

import './bloc.dart';

class RateBloc extends Bloc<RateEvent, RateState> {
  RateBloc(this._ratingsRepository) : super(InitialRateState());

  late final RatingsRepository _ratingsRepository;


  late double _rating;
  double get rating => _rating;

  late String _review;
  String get review => _review;

  RateState get initialState => InitialRateState();

  Stream<RateState> transformEvents(
      Stream<RateEvent> events, Stream<RateState> Function(RateEvent) next) {
    final nonRateTalkStream = events.where((event) => event is! RateTalk);
    final rateTalkStream = events
        .where((event) => event is RateTalk)
        .throttleTime(const Duration(milliseconds: 500));

    return MergeStream([nonRateTalkStream, rateTalkStream]).switchMap(next);
  }

  Stream<RateState> mapEventToState(
    RateEvent event,
  ) async* {
    if (event is RateTalk) {
      yield* handleRateTalkEvent(event);
    } else if (event is ReviewTalk) {
      yield* handleReviewTalkEvent(event);
    } else if (event is FetchRateTalk) {
      yield* handleFetchRateTalk(event);
    }
  }

  Stream<RateState> handleRateTalkEvent(RateTalk event) async* {
    try {
      if (await canRateTalk(event.talk)) {
        _ratingsRepository.rateTalk(event.talk.id, event.rating.toInt());
        _rating = event.rating;
        yield TalkRatedState();
      } else {
        yield RatingTalkToEarlyErrorState();
      }
    } catch (e, s) {
      logger.errorException(e, s);
      yield RatingTalkErrorState();
    }
  }

  Stream<RateState> handleFetchRateTalk(FetchRateTalk event) async* {
    _rating = _ratingsRepository.myRatingOfTalk(event.talk.id).toDouble();
    _review = _ratingsRepository.myReviewOfTalk(event.talk.id);

    yield TalkRateFetched();
  }

  Stream<RateState> handleReviewTalkEvent(ReviewTalk event) async* {
    try {
      if (await canRateTalk(event.talk)) {
        _ratingsRepository.reviewTalk(event.talk.id, event.review);
        _review = event.review;
        yield TalkRatedState();
      } else {
        yield RatingTalkToEarlyErrorState();
      }
    } catch (e, s) {
      logger.errorException(e, s);
      yield RatingTalkErrorState();
    }
  }

  Future<bool> canRateTalk(Talk talk) async {

    // final minutes = _config.getInt("minutes_before_talk_can_be_rated") ?? 5;
    final canRateTime = talk.endTime.subtract(const Duration(minutes: 5));

    return DateTime.now().isAfter(canRateTime);
  }
}

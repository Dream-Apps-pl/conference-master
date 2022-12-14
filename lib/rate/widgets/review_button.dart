import 'package:conferenceapp/generated/l10n.dart';
import 'package:conferenceapp/rate/effects/show_rating_talk_too_early_error.dart';
import 'package:flutter/material.dart';

import 'write_review_modal_bottom_sheet.dart';

class ReviewButton extends StatelessWidget {
  final Function(String) onReviewSubmitted;

  // `canReviewDelegate` is a delegate, because internally it depends on `DateTime.now()`
  // and we want perform the check everytime user clicks the button.
  final Future<bool> Function() canReviewDelegate;

  const ReviewButton(
      {Key? key,
      required this.onReviewSubmitted,
      required this.canReviewDelegate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        S.current.writeReview,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Theme.of(context).primaryColor,
        ),
      ),
      onPressed: () async {
        if (await canReviewDelegate()) {
          final review =
              await showWriteReviewModalBottomSheet(context, data: '');
          if (review != null) {
            onReviewSubmitted(review);
          }
        } else {
          showRatingTalkTooEarlyError(context);
        }
      },
    );
  }
}

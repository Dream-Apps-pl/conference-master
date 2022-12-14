import 'package:conferenceapp/generated/l10n.dart';
import 'package:flutter/material.dart';

Future<String?> showWriteReviewModalBottomSheet<String>(BuildContext context,
    {String? data}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _WriteReviewModalBottomSheet(initialValue: data.toString()),
  );
}

class _WriteReviewModalBottomSheet extends StatefulWidget {
  final String? initialValue;

  _WriteReviewModalBottomSheet({Key? key, this.initialValue}) : super(key: key);

  @override
  _WriteReviewModalBottomSheetState createState() =>
      _WriteReviewModalBottomSheetState();
}

class _WriteReviewModalBottomSheetState
    extends State<_WriteReviewModalBottomSheet> {
  late TextEditingController _controller;
  bool canSubmit = false;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.initialValue);
    _controller.addListener(canSubmitListener);
  }

  @override
  void dispose() {
    _controller.removeListener(canSubmitListener);
    _controller.dispose();

    super.dispose();
  }

  void canSubmitListener() {
    setState(() {
      canSubmit = _controller.text.length >= 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              maxLines: null,
              autofocus: true,
              maxLength: 200,
              decoration: InputDecoration(
                hintText: S.current.reviewHint,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    S.current.reviewHintVisible,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                ElevatedButton(
                  onPressed: canSubmit
                      ? () {
                          Navigator.of(context).pop(_controller.text.trim());
                        }
                      : null,
                  child: Text(S.current.submit),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

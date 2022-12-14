// Forked from material_search package
// https://pub.dev/packages/material_search
// Licensed on MIT License by ian.naph@gmail.com
// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:conferenceapp/common/logger.dart';
import 'package:flutter/material.dart';

typedef FormFieldFormatter<T> = String Function(T v);
typedef MaterialSearchFilter<T> = bool Function(T v, String c);
typedef MaterialSearchSort<T> = int Function(T a, T b, String c);
typedef MaterialResultsFinder = Future<List<MaterialSearchResult>> Function(
    String c);
typedef OnSubmit = void Function(dynamic value);

class MaterialSearchResult<T> extends StatelessWidget {
  const MaterialSearchResult({
    Key? key,
    required this.value,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.criteria,
  }) : super(key: key);

  final T value;
  final String title;
  final String subtitle;
  final IconData icon;
  final String criteria;

  @override
  Widget build(BuildContext context) {
    final titleWidget = getResultWithEmphasis(
      context: context,
      word: title,
      criteria: criteria,
      style: Theme.of(context).textTheme.displayLarge!,
    );
    final subtitleWidget = getResultWithEmphasis(
      context: context,
      word: subtitle,
      criteria: criteria,
      style: Theme.of(context).textTheme.displayLarge!,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Row(
        children: <Widget>[
          SizedBox(width: 70.0, child: Icon(icon)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                titleWidget!,
                if (subtitle != null) subtitleWidget!,
              ],
            ),
          ),
        ],
      ),
    );
  }

//
  RichText? getResultWithEmphasis({
    required BuildContext context,
    required String word,
    required String criteria,
    required TextStyle style,
  }) {
    final wordClean = word.toLowerCase().trim();
    final criteriaClean = criteria.toLowerCase().trim();

    if (word == null) return null;
    if (criteria.isNotEmpty && wordClean.contains(criteriaClean)) {
      final position = wordClean.indexOf(criteriaClean);
      late String text0, text1, text2;
      if (position == 0) {
        text1 = word.substring(position, criteriaClean.length);
        text2 = word.substring(criteriaClean.length, word.length);
      }
      if (position > 0 && position < word.length) {
        text0 = word.substring(0, position);
        text1 = word.substring(position, position + criteriaClean.length);
        text2 = word.substring(position + criteriaClean.length, word.length);
      }
      if (position == word.length) {
        text0 = word.substring(0, position);
        text1 = word.substring(position, position + criteriaClean.length);
      }
      return RichText(
        text: TextSpan(
          style: style,
          children: <TextSpan>[
            if (text0.isNotEmpty != null) TextSpan(text: text0),
            if (text1 != null)
              TextSpan(
                  text: text1,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            if (text2 != null) TextSpan(text: text2),
          ],
        ),
      );
    } else {
      return RichText(
        text: TextSpan(
          style: style,
          children: <TextSpan>[
            TextSpan(
              text: word,
            ),
          ],
        ),
      );
    }
  }
}

class MaterialSearch<T> extends StatefulWidget {
  MaterialSearch({
    Key? key,
    required this.placeholder,
    this.results,
    required this.getResults,
    required this.filter,
    this.sort,
    this.limit = 10,
    required this.onSelect,
    required this.onSubmit,
    this.barBackgroundColor = Colors.white,
    this.iconColor = Colors.white,
    this.leading,
  })  : assert(() {
          if (results == null && getResults == null ||
              results != null && getResults != null) {
            throw AssertionError(
                'Either provide a function to get the results, or the results.');
          }

          return true;
        }()),
        super(key: key);

  final String placeholder;

  final List<MaterialSearchResult<T>>? results;
  final MaterialResultsFinder getResults;
  final MaterialSearchFilter<T> filter;
  final MaterialSearchSort<T>? sort;
  final int limit;
  final ValueChanged<T> onSelect;
  final OnSubmit onSubmit;
  final Color barBackgroundColor;
  final Color iconColor;
  final Widget? leading;

  @override
  MaterialSearchState<T> createState() => MaterialSearchState<T>();
}

class MaterialSearchState<T> extends State<MaterialSearch> {
  bool _loading = false;
  List<MaterialSearchResult<T>> _results = [];

  String _criteria = '';
  final TextEditingController _controller = TextEditingController();

  _filter(dynamic v, String c) {
    return v
        .toString()
        .toLowerCase()
        .trim()
        .contains(RegExp(r'' + c.toLowerCase().trim() + ''));
  }

  @override
  void initState() {
    super.initState();

    if (widget.getResults != null) {
      _getResultsDebounced();
    }

    _controller.addListener(() {
      if (_controller.value.text != null) {
        setState(() {
          _criteria = _controller.value.text;
          if (widget.getResults != null) {
            _getResultsDebounced();
          }
        });
      }
    });
  }

  late Timer _resultsTimer;
  Future _getResultsDebounced() async {
    if (_results.isEmpty) {
      setState(() {
        logger.info('Setting loading to true');
        _loading = true;
      });
    }

    if (_resultsTimer != null && _resultsTimer.isActive) {
      _resultsTimer.cancel();
    }

    _resultsTimer = Timer(const Duration(milliseconds: 100), () async {
      if (!mounted) {
        return;
      }

      setState(() {
        _loading = true;
      });

      var results = await widget.getResults(_criteria);

      if (!mounted) {
        return;
      }

      setState(() {
        _loading = false;
        _results = List<MaterialSearchResult<T>>.from(results);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _resultsTimer.cancel();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var results = (widget.results)?.where((MaterialSearchResult result) {
      if (widget.filter != null) {
        return widget.filter(result.value, _criteria);
      }
      //only apply default filter if used the `results` option
      //because getResults may already have applied some filter if `filter` option was omited.
      else if (widget.results != null) {
        return _filter(result.value, _criteria);
      }

      return true;
    }).toList();

    if (widget.sort != null) {
      logger.info('Sorting');
      results?.sort((a, b) => widget.sort!(a.value, b.value, _criteria));
    }

    results = results?.take(widget.limit).toList();

    IconThemeData iconTheme =
        Theme.of(context).iconTheme.copyWith(color: widget.iconColor);

    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: widget.leading,
          iconTheme: iconTheme,
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Theme.of(context).primaryColor
              : Theme.of(context).scaffoldBackgroundColor,
          title: TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration.collapsed(
              hintText: widget.placeholder,
              hintStyle: const TextStyle(
                color: Colors.white54,
              ),
            ),
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            onSubmitted: (String value) {
              if (widget.onSubmit != null) {
                widget.onSubmit(value);
              }
            },
            keyboardAppearance: Theme.of(context).brightness,
          ),
          actions: _criteria.isEmpty
              ? []
              : [
                  IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        logger.info('Clear pressed');
                        setState(() {
                          _controller.text = _criteria = '';
                        });
                      }),
                ],
        ),
        body: _loading
            ? const Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: CircularProgressIndicator()),
              )
            : ListView.builder(
                itemCount: results?.length ?? 0,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => widget.onSelect(results?[index].value),
                    child: results?[index],
                  );
                },
              ),
      ),
    );
  }
}

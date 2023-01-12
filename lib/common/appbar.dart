import 'package:conferenceapp/agenda/helpers/agenda_layout_helper.dart';
import 'package:conferenceapp/generated/l10n.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class FlutterEuropeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  // ignore: prefer_const_constructors_in_immutables
  FlutterEuropeAppBar({
    Key? key,
    this.back = false,
    this.search = true,
    this.layoutSelector = false,
    this.onSearch,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  final bool back;
  final bool search;
  final bool layoutSelector;
  final VoidCallback? onSearch;

  @override
  Widget build(BuildContext context) {
    const imageHeight = 48.0;
    return AppBar(
      centerTitle: true,
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: Theme.of(context).brightness == Brightness.light
            ? Image.asset(
                'assets/flutter_europe.png',
                height: imageHeight,
                key: const ValueKey('logo_image_1'),
              )
            : Image.asset(
                'assets/flutter_europe_dark.png',
                height: imageHeight,
                key: const ValueKey('logo_image_2'),
              ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      // brightness: Theme.of(context).brightness,
      iconTheme: Theme.of(context)
          .iconTheme
          .copyWith(color: Theme.of(context).colorScheme.secondary),
      leading: back
          ? null
          : Semantics(
              button: true,
              enabled: true,
              focusable: true,
              child: Tooltip(
                message: S.current.search,
                child: IconButton(
                  color: Theme.of(context).colorScheme.secondary,
                  icon: const Icon(Icons.search),
                  onPressed: onSearch,
                ),
              ),
            ),
      actions: <Widget>[
        layoutSelector ? const ToggleLayoutButton() : Container(),
      ],
    );
  }

  @override
  final Size preferredSize;
}

class ToggleLayoutButton extends StatelessWidget {
  const ToggleLayoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = Semantics(
      button: true,
      enabled: true,
      focusable: true,
      hint: S.current.hintLayout,
      child: Tooltip(
        message: S.current.hintLayout,
        child: IconButton(
          color: Theme.of(context).colorScheme.secondary,
          icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Provider.of<AgendaLayoutHelper>(context, listen: false)
                      .isCompact()
                  ? const Icon(
                      LineIcons.database,
                      size: 24,
                      key: ValueKey('icon0'),
                    )
                  : const Icon(
                      LineIcons.columns,
                      size: 22,
                      key: ValueKey('icon1'),
                    )),
          onPressed: () async {
            await Provider.of<AgendaLayoutHelper>(context, listen: false)
                .toggleCompact();
          },
        ),
      ),
    );

    return DescribedFeatureOverlay(
      featureId: 'show_how_to_toggle_layout',
      tapTarget: icon,
      title: Text(S.current.toggleLayout),
      description: Text(S.current.toggleDescription),
      backgroundColor: Theme.of(context).primaryColor,
      onComplete: () async {
        return true;
      },
      targetColor: Colors.white,
      textColor: Colors.white,
      child: icon,
    );
  }
}

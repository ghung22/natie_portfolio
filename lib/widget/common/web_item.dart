import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:natie_portfolio/data/model/bio.dart';
import 'package:natie_portfolio/data/model/project.dart';
import 'package:natie_portfolio/global/dimens.dart';
import 'package:natie_portfolio/global/mixin.dart';
import 'package:natie_portfolio/global/router.dart';
import 'package:natie_portfolio/global/styles.dart';
import 'package:natie_portfolio/global/vars.dart';
import 'package:natie_portfolio/store/data/bio_store.dart';
import 'package:natie_portfolio/store/data/project_store.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../l10n/app_localizations.dart';
import 'buttons.dart';
import 'content_item.dart';
import 'image_view.dart';
import 'list_view.dart';
import 'text_view.dart';

class WebAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final bool primary;
  final double toolbarOpacity;
  final double bottomOpacity;
  final double? leadingWidth;

  const WebAppBar({
    super.key,
    this.leading,
    this.automaticallyImplyLeading = false,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.primary = true,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.leadingWidth,
  });

  @override
  PreferredSizeWidget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, kToolbarHeight),
      child: Observer(
        builder: (context) {
          return Stack(
            children: [
              AppBar(
                leading: Dimens.isMedium(context) ? leading : null,
                automaticallyImplyLeading: automaticallyImplyLeading,
                title: title,
                actions: actions,
                flexibleSpace: flexibleSpace,
                bottom: bottom,
                primary: primary,
                toolbarOpacity: toolbarOpacity,
                bottomOpacity: bottomOpacity,
                leadingWidth: leadingWidth,
              ),
              if (!Dimens.isMedium(context) && leading != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: kToolbarHeight),
                    child: leading!,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

class WebFooter extends StatefulWidget {
  final Color? color;

  const WebFooter({super.key, this.color});

  @override
  State<WebFooter> createState() => _WebFooterState();
}

class _WebFooterState extends State<WebFooter> with PostFrameMixin {
  Color _color = Colors.transparent;
  Widget _body = const Nothing();
  Widget _navigation = const Nothing();
  Widget _projects = const Nothing();
  Widget _contact = const Nothing();

  BioStore? _bioStore;
  ProjectStore? _projectStore;

  @override
  void initState() {
    super.initState();
    postFrame(() {
      _color = widget.color ?? Theme.of(context).primaryColor;
      _bioStore = context.read<BioStore>();
      _projectStore = context.read<ProjectStore>();
      setState(() {});
    });
  }

  void _initBody() {
    _initNavigation();
    _initProjects();
    _initContact();
    _body = Column(
      children: [
        Observer(
          builder: (context) {
            if (Dimens.isSmall(context)) {
              return Wrap(children: [_navigation, _projects, _contact]);
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.pageFooterPaddingHorizontal),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _navigation),
                  Expanded(child: _projects),
                  Expanded(child: _contact),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: Dimens.pageContentPaddingVertical),
        TextView.footer(text: AppLocalizations.of(context)!.copyright, softWrap: true),
      ],
    );
  }

  void _initNavigation() {
    _navigation = PaddedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      padding: const EdgeInsets.symmetric(
        vertical: Dimens.pageContentPaddingVertical,
        horizontal: Dimens.pageContentPaddingHorizontal,
      ),
      children: [
        TextView.header(text: AppLocalizations.of(context)!.navigate_to, color: _color),
        TextBtn(
          hoverFeedback: false,
          padding: const EdgeInsets.symmetric(vertical: Dimens.btnPaddingVertical),
          onPressed: () => context.go(Routes.home),
          textStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          alignment: AlignmentGeometry.centerLeft,
          child: TextView(text: AppLocalizations.of(context)!.home),
        ),
        TextBtn(
          hoverFeedback: false,
          padding: const EdgeInsets.symmetric(vertical: Dimens.btnPaddingVertical),
          onPressed: () => context.go(Routes.about),
          textStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          alignment: AlignmentGeometry.centerLeft,
          child: TextView(text: AppLocalizations.of(context)!.about_me),
        ),
        TextBtn(
          hoverFeedback: false,
          padding: const EdgeInsets.symmetric(vertical: Dimens.btnPaddingVertical),
          onPressed: () => context.go(Routes.projects),
          textStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          alignment: AlignmentGeometry.centerLeft,
          child: TextView(text: AppLocalizations.of(context)!.projects),
        ),
      ],
    );
  }

  void _initProjects() {
    _projects = Observer(
      builder: (context) {
        final p = _projectStore?.projects ?? Projects();
        if (p.isEmpty) return const Nothing();
        return PaddedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          padding: const EdgeInsets.symmetric(
            vertical: Dimens.pageContentPaddingVertical,
            horizontal: Dimens.pageContentPaddingHorizontal,
          ),
          children: [
            TextView.header(text: AppLocalizations.of(context)!.projects, color: _color),
            ...p.values.map((p) {
              return TextBtn(
                hoverFeedback: false,
                padding: const EdgeInsets.symmetric(vertical: Dimens.btnPaddingVertical),
                onPressed: () => context.go(Routes.project, extra: p),
                textStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                alignment: AlignmentGeometry.centerLeft,
                child: TextView(text: p.title, textAlign: TextAlign.start),
              );
            }),
          ],
        );
      },
    );
  }

  void _initContact() {
    _contact = Observer(
      builder: (context) {
        final b = _bioStore?.bio ?? const Bio();
        return PaddedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          padding: const EdgeInsets.symmetric(
            vertical: Dimens.pageContentPaddingVertical,
            horizontal: Dimens.pageContentPaddingHorizontal,
          ),
          children: [
            TextView.header(text: AppLocalizations.of(context)!.contact, color: _color),
            Wrap(
              spacing: Dimens.bioDetailsContactPadding,
              runSpacing: Dimens.bioDetailsContactPadding,
              children: b.contact
                  .map((k, v) {
                    return MapEntry(
                      k,
                      SizedBox(
                        width: Dimens.bioDetailsContactSize,
                        height: Dimens.bioDetailsContactSize,
                        child: Tooltip(
                          message: k,
                          child: ElevatedBtn(
                            color: Theme.of(context).colorScheme.surface,
                            padding: const EdgeInsets.all(Dimens.cardPadding),
                            onPressed: () => launchUrlString(v, mode: LaunchMode.externalApplication),
                            child: SvgImageView(
                              Vars.assets[k.toLowerCase()] ?? '',
                              width: Dimens.bioDetailsContactSize,
                              height: Dimens.bioDetailsContactSize,
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                  .values
                  .toList(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_bioStore == null || _projectStore == null) return const Nothing();
    _initBody();
    return Observer(
      builder: (context) {
        return Container(
          width: double.infinity,
          color: Themes.isDarkMode(context)
              ? MoreColors.darker(_color, magnitude: 1)
              : MoreColors.lighter(_color, magnitude: 2),
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.pageContentPaddingHorizontal,
            vertical: Dimens.pageFooterPaddingVertical,
          ),
          child: _body,
        );
      },
    );
  }
}

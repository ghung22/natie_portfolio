import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:natie_portfolio/store/data/project_store.dart';
import 'package:provider/provider.dart';

import 'dimens.dart';
import '../l10n/app_localizations.dart';
import '../widget/common/content_item.dart';
import '../widget/common/list_view.dart';
import '../widget/common/text_view.dart';

class Widgets {
  Widgets._(this._context);

  final BuildContext _context;

  static Widgets of(BuildContext context) => Widgets._(context);

  Drawer get drawer => Drawer(
    child: Padding(
      padding: Dimens.drawerPadding,
      child: CardItem(
        child: Observer(
          builder: (context) {
            final p = _context.read<ProjectStore>().projects;
            return ListView(
              children: [
                Stack(
                  children: [
                    DrawerHeader(
                      child: PaddedColumn(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        padding: Dimens.drawerItemPadding,
                        children: [
                          // App icon
                          TextView.header(
                            text: AppLocalizations.of(context)!.projects,
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: Dimens.drawerItemPadding, child: BioMiniItem()),
                  ],
                ),
                ...p.values.map((p) {
                  return Padding(padding: Dimens.drawerItemPadding, child: ProjectMiniItem(p));
                }),
              ],
            );
          },
        ),
      ),
    ),
  );
}

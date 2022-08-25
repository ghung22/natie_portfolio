import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:natie_portfolio/global/mixin.dart';
import 'package:natie_portfolio/global/router.dart';
import 'package:natie_portfolio/global/styles.dart';
import 'package:natie_portfolio/global/vars.dart';
import 'package:natie_portfolio/store/common/animation_store.dart';
import 'package:natie_portfolio/widget/common/banner_item.dart';
import 'package:natie_portfolio/widget/common/buttons.dart';
import 'package:natie_portfolio/global/dimens.dart';
import 'package:natie_portfolio/data/model/project.dart';
import 'package:natie_portfolio/widget/common/content_item.dart';
import 'package:natie_portfolio/widget/common/image_view.dart';
import 'package:natie_portfolio/widget/common/list_view.dart';
import 'package:natie_portfolio/widget/common/text_view.dart';
import 'package:natie_portfolio/widget/common/web_item.dart';

class ProjectPage extends StatefulWidget {
  final Project project;

  const ProjectPage({Key? key, required this.project}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> with PostFrameMixin {
  late Project _p;

  PreferredSizeWidget _appBar = WebAppBar();
  Widget _body = const Nothing();

  final AnimationStore _introAni = AnimationStore();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _p = widget.project;
    postFrame(() {
      _introAni.start();
      setState(() {});
    });
  }

  void _initAppBar() {
    _appBar = WebAppBar(
      leading: const BackBtn(),
      title: Observer(builder: (context) {
        return AnimatedOpacity(
          opacity: _introAni.willStart ? 1 : 0,
          duration: Vars.animationFast,
          child: TextBtn(
            textStyle: Theme.of(context).appBarTheme.titleTextStyle,
            hoverFeedback: false,
            onPressed: () => _scrollController.animateTo(
              0,
              duration: Vars.animationSlow,
              curve: Curves.easeOut,
            ),
            child: TextView(text: _p.title),
          ),
        );
      }),
      actions: const [LanguageBtn(), ThemeBtn()],
    );
  }

  void _initBody() {
    _body = SingleChildScrollView(
      controller: _scrollController,
      child: PaddedColumn(
        paddingStartAndEnd: false,
        padding: const EdgeInsets.symmetric(
            vertical: Dimens.projectDetailsPaddingVertical),
        children: [
          // Banner
          ProjectBanner(project: _p),

          // Functionalities
          TextView.header(
            text: AppLocalizations.of(context)!.what_you_can_do(_p.title),
            color: _p.color,
          ),
          PaddedColumn(
            paddingStartAndEnd: false,
            padding: const EdgeInsets.symmetric(
                vertical: Dimens.projectDetailsFuncPadding),
            children: List.generate(
                max(_p.functionalities.length, _p.functionalitiesVi.length),
                (i) => FunctionalityItem(_p, i)),
          ),

          // Technology used
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                vertical: Dimens.projectDetailsPaddingVertical),
            color: Themes.isDarkMode
                ? MoreColors.darker(_p.color, magnitude: 2)
                : MoreColors.lighter(_p.color, magnitude: 2),
            child: PaddedColumn(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimens.projectDetailsPaddingVertical),
              children: [
                TextView.header(
                  text: AppLocalizations.of(context)!.tech_used,
                  color: _p.color,
                ),
                const SizedBox(
                    height: Dimens.projectDetailsTechPaddingVertical),
                Wrap(
                  spacing: Dimens.projectDetailsTechPaddingHorizontal,
                  runSpacing: Dimens.projectDetailsTechPaddingVertical,
                  alignment: WrapAlignment.center,
                  children: _p.tech.split(',').map((tech) {
                    final src = Vars.assets[tech] ?? '';
                    return SvgImageView(src,
                        width: Dimens.projectDetailsTechSize,
                        height: Dimens.projectDetailsTechSize,
                        fit: BoxFit.fitHeight);
                  }).toList(),
                ),
                const SizedBox(
                    height: Dimens.projectDetailsTechPaddingVertical),
              ],
            ),
          ),
          const SizedBox(height: Dimens.projectDetailsPaddingVertical),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _initAppBar();
    _initBody();

    return Stack(
      children: [
        Hero(
          tag: '${Routes.project}/${_p.id}/banner',
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              toolbarOpacity: 0,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: const Nothing(),
            ),
            body: Observer(builder: (context) {
              return AnimatedOpacity(
                opacity: _introAni.willStart ? 0 : 1,
                duration: Vars.animationFast,
                child: Container(
                  height: Dimens.bannerHeight,
                  color: _p.color,
                ),
              );
            }),
          ),
        ),
        Hero(
          tag: '${Routes.project}/${_p.id}',
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(side: BorderSide.none),
            child: Scaffold(
              appBar: _appBar,
              body: _body,
            ),
          ),
        ),
      ],
    );
  }
}
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:natie_portfolio/global/mixin.dart';
import 'package:natie_portfolio/global/router.dart';
import 'package:natie_portfolio/global/styles.dart';
import 'package:natie_portfolio/global/vars.dart';
import 'package:natie_portfolio/store/common/animation_store.dart';
import 'package:natie_portfolio/store/global/dimen_store.dart';
import 'package:natie_portfolio/widget/common/banner_item.dart';
import 'package:natie_portfolio/widget/common/buttons.dart';
import 'package:natie_portfolio/global/dimens.dart';
import 'package:natie_portfolio/data/model/project.dart';
import 'package:natie_portfolio/widget/common/content_item.dart';
import 'package:natie_portfolio/widget/common/image_view.dart';
import 'package:natie_portfolio/widget/common/list_view.dart';
import 'package:natie_portfolio/widget/common/text_view.dart';
import 'package:natie_portfolio/widget/common/web_item.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjectPage extends StatefulWidget {
  final Project project;

  const ProjectPage({Key? key, required this.project}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> with PostFrameMixin {
  late Project _p;

  PreferredSizeWidget _appBar = const WebAppBar();
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

          // Time, author & images
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.projectDetailsPaddingHorizontal,
                vertical: Dimens.projectDetailsPaddingVertical),
            color: Themes.isDarkMode
                ? MoreColors.darker(_p.color, magnitude: 1)
                : MoreColors.lighter(_p.color, magnitude: 2),
            child: PaddedColumn(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimens.projectDetailsPaddingVertical),
              paddingStartAndEnd: false,
              children: [
                Wrap(
                  spacing: Dimens.projectDetailsFuncPadding,
                  runSpacing: Dimens.projectDetailsFuncPadding,
                  children: [
                    ProjectTimestampItem(_p),
                    ProjectAuthorItem(_p),
                  ],
                ),
                Center(child: HostUrlItem(_p)),
                Observer(builder: (context) {
                  final dimenStore = context.read<DimenStore>();
                  final w = dimenStore.width;
                  return CarouselSlider(
                      items: _p.imageUrls.map((url) {
                        return InkWell(
                          onTap: () => launchUrlString(url,
                              mode: LaunchMode.externalApplication),
                          child: RoundedImageView(url),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: Dimens.projectDetailsImgHeight,
                        pageSnapping: false,
                        viewportFraction: (Dimens.projectDetailsImgWidth +
                                Dimens.projectDetailsImgPadding) /
                            w,
                        enableInfiniteScroll: false,
                        padEnds: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration: Vars.animationFast,
                        pauseAutoPlayOnManualNavigate: true,
                        pauseAutoPlayOnTouch: true,
                      ));
                }),
              ],
            ),
          ),

          // Functionalities
          TextView.header(
            text: AppLocalizations.of(context)!.what_you_can_do(_p.title),
            color: _p.color,
          ),
          Wrap(
            spacing: Dimens.projectDetailsFuncPadding,
            runSpacing: Dimens.projectDetailsFuncPadding,
            children: List.generate(
                min(_p.functionalities.length, _p.functionalitiesVi.length),
                (i) => FunctionalityItem(_p, i)),
          ),

          // Technology used
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.projectDetailsPaddingHorizontal,
                vertical: Dimens.projectDetailsPaddingVertical),
            color: Themes.isDarkMode
                ? MoreColors.darker(_p.color, magnitude: 1)
                : MoreColors.lighter(_p.color, magnitude: 2),
            child: PaddedColumn(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimens.projectDetailsPaddingVertical),
              paddingStartAndEnd: false,
              children: [
                TextView.header(
                  text: AppLocalizations.of(context)!.tech_used,
                  color: _p.color,
                ),
                Wrap(
                  spacing: Dimens.projectDetailsTechPaddingHorizontal,
                  runSpacing: Dimens.projectDetailsTechPaddingVertical,
                  alignment: WrapAlignment.center,
                  children: _p.tech.split(',').map((tech) {
                    return TechItem(tech);
                  }).toList(),
                ),
              ],
            ),
          ),

          // Learned
          TextView.header(
            text: AppLocalizations.of(context)!.what_i_learned(_p.title),
            color: _p.color,
          ),
          Wrap(
            spacing: Dimens.projectDetailsFuncPadding,
            runSpacing: Dimens.projectDetailsFuncPadding,
            children: List.generate(min(_p.learned.length, _p.learnedVi.length),
                (i) => LearnedItem(_p, i)),
          ),
          WebFooter(color: _p.color),
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
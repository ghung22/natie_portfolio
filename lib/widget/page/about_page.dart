import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:natie_portfolio/global/mixin.dart';
import 'package:natie_portfolio/global/strings.dart';
import 'package:natie_portfolio/global/vars.dart';
import 'package:natie_portfolio/store/common/animation_store.dart';
import 'package:natie_portfolio/store/data/bio_store.dart';
import 'package:natie_portfolio/widget/common/banner_item.dart';
import 'package:natie_portfolio/widget/common/buttons.dart';
import 'package:natie_portfolio/global/dimens.dart';
import 'package:natie_portfolio/widget/common/content_item.dart';
import 'package:natie_portfolio/widget/common/list_view.dart';
import 'package:natie_portfolio/widget/common/text_view.dart';
import 'package:natie_portfolio/widget/common/web_item.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with PostFrameMixin {
  PreferredSizeWidget _appBar = const WebAppBar();
  Widget _body = const Nothing();

  final AnimationStore _introAni = AnimationStore();
  final _scrollController = ScrollController();
  BioStore? _bioStore;

  @override
  void initState() {
    super.initState();
    postFrame(() {
      _bioStore = context.read<BioStore>();
      _introAni.start();
      setState(() {});
    });
  }

  void _initAppBar() {
    _appBar = WebAppBar(
      leading: const BackBtn(),
      title: Observer(builder: (context) {
        Strings.isEn;
        return TextBtn(
          textStyle: Theme.of(context).appBarTheme.titleTextStyle,
          hoverFeedback: false,
          onPressed: () => _scrollController.animateTo(
            0,
            duration: Vars.animationSlow,
            curve: Curves.easeOut,
          ),
          child: TextView(textCallback: () => Strings.title),
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
          IgnorePadding(child: BioBanner(bio: _bioStore!.bio, skipIntro: true)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _initAppBar();
    _initBody();

    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }
}
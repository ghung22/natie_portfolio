import 'package:flutter/material.dart';
import 'package:natie_portfolio/store/global/dimen_store.dart';
import 'package:provider/provider.dart';

enum ScreenSize { small, medium, large }

class Dimens {
  const Dimens._();

  static const smallScreenWidth = 600.0;
  static const mediumScreenWidth = 900.0;

  static ScreenSize screenSize(BuildContext context) {
    final size = context.read<DimenStore>().size;
    if (size.width < smallScreenWidth) return ScreenSize.small;
    if (size.width < mediumScreenWidth) return ScreenSize.medium;
    return ScreenSize.large;
  }

  static bool isSmall(BuildContext context) => screenSize(context) == ScreenSize.small;

  static bool isMedium(BuildContext context) => screenSize(context) == ScreenSize.medium;

  static bool isLarge(BuildContext context) => screenSize(context) == ScreenSize.large;

  static const bannerActionOffset = EdgeInsets.all(16.0);
  static const bannerActionOffsetSmall = EdgeInsets.all(12.0);
  static const bannerActionPadding = EdgeInsets.symmetric(vertical: 24.0, horizontal: 36.0);
  static const bannerActionPaddingSmall = EdgeInsets.symmetric(vertical: 18.0, horizontal: 27.0);
  static const _bannerContentPaddingValue = 8.0;
  static const bannerContentPadding = EdgeInsets.symmetric(vertical: _bannerContentPaddingValue);
  static const bannerContentPaddingBox = SizedBox(height: _bannerContentPaddingValue);
  static const bannerHeight = 520.0;
  static const _bannerLeftSideHeight = bannerHeight * 4 / 5;
  static const _bannerRightSideHeight = bannerHeight;
  static const bannerHeightDouble =
      (_bannerLeftSideHeight + _bannerRightSideHeight + 28.0 + _bannerContentPaddingValue) * 4 / 5;
  static const bannerPadding = EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0);
  static const bannerSlideOffset = .1;
  static const bannerConstraint = BoxConstraints(
    minHeight: bannerHeight,
    maxHeight: bannerHeight,
    maxWidth: _pageContentMaxWidth,
  );
  static const bannerConstraintDouble = BoxConstraints(
    minHeight: bannerHeightDouble,
    maxHeight: bannerHeightDouble,
    maxWidth: _pageContentMaxWidth,
  );
  static const bannerLeftSideConstraint = BoxConstraints(
    minHeight: _bannerLeftSideHeight,
    maxHeight: _bannerLeftSideHeight,
    maxWidth: 390.0,
  );
  static const bannerRightSideConstraint = BoxConstraints(
    minHeight: _bannerRightSideHeight,
    maxHeight: _bannerRightSideHeight,
    maxWidth: _pageContentMaxWidth,
  );

  static const bioAvatarBorderSize = 4.0;
  static const bioAvatarPadding = EdgeInsets.all(bioAvatarBorderSize + 4);
  static const bioHeight = BoxConstraints(maxHeight: bannerHeight / 2);
  static const bioPadding = EdgeInsets.only(right: bioAvatarBorderSize * 2, bottom: bioAvatarBorderSize * 8);
  static const bioScoreSize = 132.0;
  static const bioScorePadding = EdgeInsets.symmetric(horizontal: 24.0);
  static const bioScorePaddingBox = SizedBox(height: 24.0);
  static const bioConstraint = BoxConstraints(
    minHeight: bannerHeight * 1.5,
    maxHeight: bannerHeight * 1.5,
    maxWidth: _pageContentMaxWidth,
  );
  static const bioConstraintDouble = BoxConstraints(
    minHeight: bannerHeightDouble * 1.5,
    maxHeight: bannerHeightDouble * 1.5,
    maxWidth: _pageContentMaxWidth,
  );
  static const bioLeftSideConstraint = BoxConstraints(
    minHeight: _bannerLeftSideHeight * 1.5,
    maxHeight: _bannerLeftSideHeight * 1.5,
    maxWidth: 600.0,
  );
  static const bioRightSideConstraint = BoxConstraints(
    minHeight: _bannerRightSideHeight * 1.5,
    maxHeight: _bannerRightSideHeight * 1.5,
    maxWidth: _pageContentMaxWidth,
  );

  static const bioDetailsContactPadding = bioDetailsContactSize / 4;
  static const bioDetailsContactSize = 48.0;
  static const bioDetailsExpPaddingHorizontal = EdgeInsets.symmetric(horizontal: 32.0);
  static const bioDetailsExpPaddingVertical = EdgeInsets.symmetric(vertical: bioDetailsScorePaddingVertical);
  static const bioDetailsExpSize = 160.0;
  static const _bioDetailsPaddingVertical = _projectDetailsPaddingVertical / 2;
  static const _bioDetailsPaddingHorizontal = _projectDetailsPaddingHorizontal / 2;
  static const bioDetailsPadding = EdgeInsets.symmetric(
    horizontal: _bioDetailsPaddingHorizontal,
    vertical: _bioDetailsPaddingVertical,
  );
  static const bioDetailsPaddingVertical = EdgeInsets.symmetric(vertical: _bioDetailsPaddingVertical);
  static const bioDetailsPaddingLeft = EdgeInsets.only(left: _bioDetailsPaddingHorizontal);
  static const bioDetailsScorePaddingHorizontal = 64.0;
  static const bioDetailsScorePaddingVertical = 12.0;
  static const bioDetailsScoreSize = bioScoreSize * 2;

  static const btnElevation = 5.0;
  static const btnIconPaddingHorizontal = EdgeInsets.symmetric(horizontal: _btnPaddingHorizontal / 2);
  static const _btnPaddingHorizontal = 24.0;
  static const _btnPaddingVertical = 16.0;
  static const btnPadding = EdgeInsets.symmetric(horizontal: _btnPaddingHorizontal, vertical: _btnPaddingVertical);
  static const btnPaddingVertical = EdgeInsets.symmetric(vertical: _btnPaddingVertical);
  static const btnRadius = 30.0;

  static const cardElevation = 8.0;
  static const _cardRadius = 12.0;
  static const cardBorder = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(_cardRadius)));
  static const cardPadding = EdgeInsets.all(8.0);

  static const drawerPadding = EdgeInsets.all(16.0);
  static const drawerPaddingHorizontal = EdgeInsets.symmetric(horizontal: 16.0);
  static const drawerWidth = 400.0;
  static const drawerItemPadding = EdgeInsets.symmetric(vertical: 4.0);
  static const drawerAvatarSize = 64.0;

  static const iconBtnSize = 20.0;

  static const _pageContentMaxWidth = 840.0;
  static const pageContentMaxWidth = BoxConstraints(maxWidth: _pageContentMaxWidth);
  static const pageContentPadding = EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0);
  static const pageContentPaddingHorizontal = EdgeInsets.symmetric(horizontal: 12.0);
  static const pageContentPaddingVerticalBox = SizedBox(height: 12.0);

  static const pageFooterPaddingHorizontal = EdgeInsets.symmetric(horizontal: 16.0);

  static const projectDetailsFuncOffset = .1;
  static const projectDetailsFuncPaddingValue = 8.0;
  static const projectDetailsFuncPadding = EdgeInsets.symmetric(
    horizontal: projectDetailsFuncPaddingValue,
    vertical: projectDetailsFuncPaddingValue,
  );
  static const projectDetailsFuncPaddingBox = SizedBox(height: projectDetailsFuncPaddingValue);
  static const projectDetailsFuncWidth = 360.0;
  static const projectDetailsImgHeight = bannerHeight;
  static const projectDetailsImgWidth = 250;
  static const projectDetailsImgPadding = 32.0;
  static const _projectDetailsPaddingHorizontal = 36.0;
  static const _projectDetailsPaddingVertical = 24.0;
  static const projectDetailsPadding = EdgeInsets.symmetric(
    horizontal: _projectDetailsPaddingHorizontal,
    vertical: _projectDetailsPaddingVertical,
  );
  static const projectDetailsPaddingVertical = EdgeInsets.symmetric(vertical: _projectDetailsPaddingVertical);
  static const projectDetailsTechPaddingHorizontal = 64.0;
  static const projectDetailsTechPaddingInternal = EdgeInsets.all(12.0);
  static const projectDetailsTechPaddingVertical = 12.0;
  static const projectDetailsTechSize = 64.0;

  static const projectItemContentPadding = EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0);
  static const projectItemContentPaddingHorizontal = EdgeInsets.symmetric(horizontal: 4.0);
  static const projectItemIconSize = 48.0;
  static const projectItemPadding = 16.0;
  static const projectItemPaddingVertical = EdgeInsets.symmetric(vertical: 16.0);
  static const projectItemPaddingBox = SizedBox(height: projectItemPadding);

  static const roundedImageRadius = BorderRadius.all(Radius.circular(_cardRadius));
}

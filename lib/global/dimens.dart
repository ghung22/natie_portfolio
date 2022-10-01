import 'package:flutter/material.dart';
import 'package:natie_portfolio/store/global/dimen_store.dart';
import 'package:provider/provider.dart';

enum ScreenSize {
  small,
  medium,
  large,
}

class Dimens {
  static BuildContext? _context;

  static void init(BuildContext context) => _context = context;

  static ScreenSize get _screenSize {
    if (_context == null) return ScreenSize.large;
    final dimenStore = _context!.read<DimenStore>();
    final size = dimenStore.size;
    if (size.width < smallScreenWidth) return ScreenSize.small;
    if (size.width < mediumScreenWidth) return ScreenSize.medium;
    return ScreenSize.large;
  }

  static const smallScreenWidth = 600.0;
  static const mediumScreenWidth = 900.0;

  static bool get isSmall => _screenSize == ScreenSize.small;

  static bool get isMedium => _screenSize == ScreenSize.medium;

  static bool get isLarge => _screenSize == ScreenSize.large;

  static const bannerActionOffset = 16.0;
  static const bannerActionPaddingHorizontal = 36.0;
  static const bannerActionPaddingVertical = 24.0;
  static const bannerContentLeftMaxWidth = 560.0;
  static const bannerContentPadding = 8.0;
  static const bannerHeight = 500.0;
  static const bannerPaddingHorizontal = 24.0;
  static const bannerPaddingVertical = 28.0;
  static const bannerSlideOffset = .1;

  static const bioAvatarBorderSize = 4.0;
  static const bioAvatarPadding = bioAvatarBorderSize + 4;
  static const bioHeight = bannerHeight / 2;
  static const bioRightSidePadding = bioAvatarBorderSize * 2;
  static const bioScoreSize = 116.0;
  static const bioScorePadding = 24.0;

  static const bioDetailsContactPadding = bioDetailsContactSize / 4;
  static const bioDetailsContactSize = 48.0;
  static const bioDetailsExpPaddingHorizontal = 32.0;
  static const bioDetailsExpPaddingVertical = bioDetailsScorePaddingVertical;
  static const bioDetailsExpSize = 160.0;
  static const bioDetailsPaddingVertical = projectDetailsPaddingVertical / 2;
  static const bioDetailsPaddingHorizontal =
      projectDetailsPaddingHorizontal / 2;
  static const bioDetailsScorePaddingHorizontal = 64.0;
  static const bioDetailsScorePaddingVertical = 12.0;
  static const bioDetailsScoreSize = bioScoreSize * 2;

  static const btnElevation = 5.0;
  static const btnIconPaddingHorizontal = btnPaddingHorizontal / 2;
  static const btnPaddingHorizontal = btnPaddingVertical * 3;
  static const btnPaddingVertical = 8.0;
  static const btnRadius = 30.0;

  static const cardElevation = 8.0;
  static const cardRadius = 12.0;
  static const cardPadding = 8.0;

  static const drawerPadding = 16.0;
  static const drawerWidth = 400.0;
  static const drawerItemPadding = 4.0;
  static const drawerAvatarSize = 64.0;

  static const iconBtnSize = 20.0;

  static const pageContentMaxWidth = 840.0;
  static const pageContentPaddingHorizontal = pageContentPaddingVertical;
  static const pageContentPaddingVertical = 12.0;

  static const pageFooterPaddingHorizontal = 16.0;
  static const pageFooterPaddingVertical = pageFooterPaddingHorizontal * 2;

  static const projectDetailsFuncHeight = 64.0;
  static const projectDetailsFuncOffset = .1;
  static const projectDetailsFuncPadding = 8.0;
  static const projectDetailsFuncWidth = 360.0;
  static const projectDetailsImgHeight = bannerHeight;
  static const projectDetailsImgWidth = 250;
  static const projectDetailsImgPadding = 32.0;
  static const projectDetailsPaddingHorizontal = 36.0;
  static const projectDetailsPaddingVertical = 24.0;
  static const projectDetailsTechPaddingHorizontal = 64.0;
  static const projectDetailsTechPaddingInternal = 12.0;
  static const projectDetailsTechPaddingVertical = 12.0;
  static const projectDetailsTechSize = 64.0;

  static const projectItemContentPadding = 4.0;
  static const projectItemIconSize = 48.0;
  static const projectItemImageWidth = 160.0;
  static const projectItemPadding = 16.0;

  static const roundedImageRadius = cardRadius;
}
class Vars {
  static const animationBlink = Duration(milliseconds: 25);
  static const animationFlash = Duration(milliseconds: 75);
  static const animationSwift = Duration(milliseconds: 150);
  static const animationFast = Duration(milliseconds: 300);
  static const animationSlow = Duration(milliseconds: 600);
  static const animationSluggish = Duration(milliseconds: 1200);

  static const _assetRoot = '.'; // ''assets';
  static const _assetBio = '$_assetRoot/bio';
  static const _assetBrand = '$_assetRoot/brand';
  static const _assetContact = '$_assetRoot/contact';
  static const _assetTech = '$_assetRoot/tech';
  static const assets = {
    'avatar': '$_assetBio/avatar.jpg',

    'fit': '$_assetBrand/fit.png',
    'hcmus': '$_assetBrand/hcmus.png',

    'github': '$_assetContact/github.png',
    'gmail': '$_assetContact/gmail.png',

    'android': '$_assetTech/android.png',
    'firebase': '$_assetTech/firebase.png',
    'flutter': '$_assetTech/flutter.png',
    'java': '$_assetTech/java.png',
    'jitsi': '$_assetTech/jitsi.png',
    'markdown': '$_assetTech/markdown.png',
    'ml_kit': '$_assetTech/ml_kit.png',
    'mongodb': '$_assetTech/mongodb.png',
    'moodle': '$_assetTech/moodle.png',
    'sqlite': '$_assetTech/sqlite.png',
  };
}

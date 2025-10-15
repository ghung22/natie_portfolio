// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get about_me => 'Về tôi';

  @override
  String get author => 'Thực hiện bởi';

  @override
  String get back => 'Quay lại';

  @override
  String get completion_date => 'Ngày hoàn thành';

  @override
  String get contact => 'Liên hệ';

  @override
  String get copyright => '© 2026 Natie Portfolio - Lập trình sử dụng Flutter';

  @override
  String get details => 'Chi tiết';

  @override
  String get explore => 'Khám phá thêm';

  @override
  String get experience => 'Kinh nghiệm làm việc & Học tập';

  @override
  String get featured_projects => 'Các đề tài Nổi bật';

  @override
  String get home => 'Trang chủ';

  @override
  String get host => 'Tham khảo';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get more_projects => 'Các đề tài khác';

  @override
  String get navigate_to => 'Đi đến trang';

  @override
  String get navigation => 'Điều hướng';

  @override
  String get now => 'Hiện tại';

  @override
  String get projects => 'Các đề tài của tôi';

  @override
  String route_unknown(String route) {
    return 'Không tìm thấy đường dẫn $route';
  }

  @override
  String get scoreboard => 'Xem bảng điểm';

  @override
  String get scores => 'Điểm số học tập';

  @override
  String get search => 'Tìm kiếm';

  @override
  String get see_more => 'Nhấn vào tôi để biết thêm';

  @override
  String get tech_used => 'Công nghệ sử dụng:';

  @override
  String get theme => 'Chủ đề';

  @override
  String welcome(String name) {
    return 'Chào! Tôi là\n$name';
  }

  @override
  String what_i_learned(String name) {
    return 'Nhờ có $name, tôi đã học được…';
  }

  @override
  String what_you_can_do(String name) {
    return 'Với $name, bạn có thể…';
  }

  @override
  String get z => 'Z';
}

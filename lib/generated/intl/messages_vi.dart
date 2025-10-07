// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';

  static String m0(String route) => "Không tìm thấy đường dẫn ${route}";

  static String m1(String name) => "Chào! Tôi là\n${name}";

  static String m2(String name) => "Nhờ có ${name}, tôi đã học được…";

  static String m3(String name) => "Với ${name}, bạn có thể…";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about_me": MessageLookupByLibrary.simpleMessage("Về tôi"),
    "author": MessageLookupByLibrary.simpleMessage("Thực hiện bởi"),
    "back": MessageLookupByLibrary.simpleMessage("Quay lại"),
    "completion_date": MessageLookupByLibrary.simpleMessage("Ngày hoàn thành"),
    "contact": MessageLookupByLibrary.simpleMessage("Liên hệ"),
    "copyright": MessageLookupByLibrary.simpleMessage("© 2021 Natie Portfolio - Lập trình sử dụng Flutter"),
    "details": MessageLookupByLibrary.simpleMessage("Chi tiết"),
    "experience": MessageLookupByLibrary.simpleMessage("Kinh nghiệm làm việc & Học tập"),
    "explore": MessageLookupByLibrary.simpleMessage("Khám phá thêm"),
    "featured_projects": MessageLookupByLibrary.simpleMessage("Các đề tài Nổi bật"),
    "home": MessageLookupByLibrary.simpleMessage("Trang chủ"),
    "host": MessageLookupByLibrary.simpleMessage("Tham khảo"),
    "language": MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
    "more_projects": MessageLookupByLibrary.simpleMessage("Các đề tài khác"),
    "navigate_to": MessageLookupByLibrary.simpleMessage("Đi đến trang"),
    "navigation": MessageLookupByLibrary.simpleMessage("Điều hướng"),
    "projects": MessageLookupByLibrary.simpleMessage("Các đề tài của tôi"),
    "route_unknown": m0,
    "scoreboard": MessageLookupByLibrary.simpleMessage("Xem bảng điểm"),
    "scores": MessageLookupByLibrary.simpleMessage("Điểm số học tập"),
    "search": MessageLookupByLibrary.simpleMessage("Tìm kiếm"),
    "see_more": MessageLookupByLibrary.simpleMessage("Nhấn vào tôi để biết thêm"),
    "tech_used": MessageLookupByLibrary.simpleMessage("Công nghệ sử dụng:"),
    "theme": MessageLookupByLibrary.simpleMessage("Chủ đề"),
    "welcome": m1,
    "what_i_learned": m2,
    "what_you_can_do": m3,
    "z": MessageLookupByLibrary.simpleMessage("Z"),
  };
}

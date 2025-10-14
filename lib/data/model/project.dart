import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

/// --------------------------------------------------------------------------
/// **A model to represent projects that I've made**
///
/// **Parameters:**
/// * [id]                  : Identifier for this project
/// * [title]               : Name of this project
/// * [author]              : Who made this / What this is made for
/// * [tech]                : Programming language / Framework used
/// * [description]         : More info on this project
/// * [functionalities]     : Functional requirements of this project
/// * [learned]             : What was learned from this project
/// * [iconUrl]             : Application icon of this project
/// * [imageUrls]           : Screenshots of this project
/// * [colorHex]            : The main color representing this application
/// * [completionTimestamp] : The date that this project was completed
/// * [featured]            : Will this be shown on the home page or not
///
/// **Getters:**
/// * [color]               : Convert [colorHex]'s value to [Color]
/// * [completionDate]      : Convert [completionTimestamp] to [DateTime]
/// --------------------------------------------------------------------------
@JsonSerializable()
class Project {
  String id;
  String title;
  String author;
  String authorVi;
  List<ProjectTag> tags;
  String tech;
  String description;
  String descriptionVi;
  List<String> functionalities;
  List<String> functionalitiesVi;
  List<String> learned;
  List<String> learnedVi;
  String hostUrl;
  String iconUrl;
  List<String> imageUrls;
  int colorHex;
  int? completionTimestamp;
  bool featured;

  Project({
    this.id = '',
    this.title = '',
    this.author = '',
    this.authorVi = '',
    this.tags = const <ProjectTag>[],
    this.tech = '',
    this.description = '',
    this.descriptionVi = '',
    this.functionalities = const <String>[],
    this.functionalitiesVi = const <String>[],
    this.learned = const <String>[],
    this.learnedVi = const <String>[],
    this.hostUrl = '',
    this.iconUrl = '',
    this.imageUrls = const <String>[
      'https://static.vecteezy.com/system/resources/previews/008/520/175/original/hand-holding-smartphone-with-screen-mockup-png.png',
    ],
    this.colorHex = 0x000000,
    this.completionTimestamp,
    this.featured = false,
  }) : assert(
         functionalities.length == functionalitiesVi.length ||
             functionalities.isEmpty && functionalitiesVi.isNotEmpty ||
             functionalities.isNotEmpty && functionalitiesVi.isEmpty,
       );

  Color get color => Color(colorHex);

  DateTime? get completionDate {
    if (completionTimestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(completionTimestamp!);
  }

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @override
  String toString() => toJson().toString();
}

enum ProjectTag { mobile, server, game, hcmus, indie, fpt, teamobi }

class Projects {
  final List<Project> _v;

  Projects([this._v = const []]);

  List<Project> get values {
    const maxTimestamp = 0x1FFFFFFFFFFFFF;
    final v = [..._v];
    v.sort((a, b) {
      final aTimestamp = a.completionTimestamp ?? -1;
      final bTimestamp = b.completionTimestamp ?? maxTimestamp;
      return bTimestamp.compareTo(aTimestamp);
    });
    return v;
  }

  Project operator [](int index) => _v[index];

  Project? get first => _v.isNotEmpty ? _v.first : null;

  Project? get last => _v.isNotEmpty ? _v.last : null;

  int get length => _v.length;

  bool get isEmpty => _v.isEmpty;

  bool get isNotEmpty => _v.isNotEmpty;

  List<Project> get featured => values.where((p) => p.featured).toList();

  List<Project> get others => values.where((p) => !p.featured).toList();

  List<Project> getFeatured(List<ProjectTag>? filter) =>
      values.where((p) => p.featured && (filter == null || p.tags.toSet().containsAll(filter))).toList();

  List<Project> getOthers(List<ProjectTag>? filter) =>
      values.where((p) => !p.featured && (filter == null || p.tags.toSet().containsAll(filter))).toList();

  void replaceWith({List<Project>? values, Projects? projects}) {
    if (projects != null) values = projects._v;
    if (values == null) return;
    _v.clear();
    _v.addAll(values);
  }

  Projects copyWith({List<Project>? values}) => Projects(values ?? _v);

  @override
  String toString() => jsonEncode(_v).toString();
}

class ProjectData {
  static Projects data = Projects([
    aPum,
    lms,
    nieNote,
    nieFlat,
    letTutor,
    moodleMobile,
    teaMobiAvatarLand,
    teaMobiNro,
    teaMobiAvatarBum,
    teaMobiStpt,
    teaMobiNhanGia,
  ]);

  static Project aPum = Project(
    id: 'a_pum',
    title: 'aPum',
    author: 'Nguyễn Gia Hưng',
    tags: [ProjectTag.mobile, ProjectTag.hcmus],
    tech: 'android,java,sqlite,ml_kit',
    description:
        'An image gallery management application compact with features like: view photos, see photo information, '
        'favorite photos, facial detection, and more…',
    descriptionVi:
        'Một ứng dụng quản lý ảnh nhỏ gọn với các tính năng như: xem ảnh, thông tin ảnh, yêu thích ảnh, '
        'nhận dạng khuôn mặt, và nhiều hơn nữa…',
    functionalities: [
      'Splash screen & about screen',
      'Flexible appbar',
      'System-based dark mode',
      'View images & albums on the device',
      'See photo information (with map viewing support)',
      'Share image & make image a wallpaper',
      'Copy/move/delete images',
      'Favorite photos',
      'Sort & search images, albums, faces, favorite images by name & time',
      'Auto-update image & album list on the device',
      'Open images with aPum from other apps',
      'Add images with Camera',
      'Realtime facial detection',
      'View images from detected faces',
    ],
    functionalitiesVi: [
      'Màn hình splash & màn hình giới thiệu',
      'Thanh công cụ kích cỡ thông minh',
      'Chế độ tối theo cài đặt thiết bị',
      'Xem ảnh & album trên thiết bị',
      'Xem thông tin ảnh (hỗ trợ xem vị trí trên bản đồ)',
      'Chia sẻ ảnh & làm ảnh nền',
      'Sao chép/di chuyển/xóa ảnh',
      'Yêu thích ảnh',
      'Sắp xếp & tìm kiếm ảnh, album, mặt, ảnh yêu thích theo tên & thời gian',
      'Tự động cập nhật danh sách ảnh & album trên thiết bị',
      'Mở ảnh bằng aPum từ các ứng dụng khác',
      'Thêm ảnh từ chụp Camera',
      'Nhận dạng khuôn mặt thời gian thực',
      'Xem ảnh từ khuôn mặt đã nhận dạng',
    ],
    learned: [
      'Create a complete Android app',
      'Import & use external libraries with gradle',
      'Integrate image dectection using ML Kit',
      'Using Intents to launch external apps',
    ],
    learnedVi: [
      'Tạo một app Android hoàn chỉnh',
      'Thêm & sử dụng thư viện bằng gradle',
      'Tích hợp nhận biết khuôn mặt sử dụng ML Kit',
      'Sử dụng Intent để mở ứng dụng khác',
    ],
    imageUrls: [
      'https://i.imgur.com/lYE6Pju.png',
      'https://i.imgur.com/ATQZIJW.png',
      'https://i.imgur.com/LUxJ6sU.png',
      'https://i.imgur.com/kQ0c7DO.png',
      'https://i.imgur.com/ZegO4iX.png',
      'https://i.imgur.com/GRTgGOl.png',
      'https://i.imgur.com/ajkIyuK.png',
      'https://i.imgur.com/TFuE7aN.png',
    ],
    hostUrl: 'https://github.com/nateclint/aPum',
    iconUrl: 'https://i.imgur.com/v4eJxPF.png',
    colorHex: Colors.teal.toARGB32(),
    completionTimestamp: DateTime(2021, 5).millisecondsSinceEpoch,
    featured: false,
  );

  static Project lms = Project(
    id: 'lms',
    title: 'LMS',
    author: 'Intern project team at FPT Software',
    authorVi: 'Nhóm dự án thực tập tại FPT Software',
    tags: [ProjectTag.mobile, ProjectTag.fpt],
    tech: 'android,java,mongodb',
    description:
        'A mobile application for a learning management system. Inspired by Quizziz, this app lets its users '
        'to see and play quizzes, and let lecturers create their own quiz with multiple types of questions. '
        'Data are taken from MongoDB through team-made RESTful APIs.',
    descriptionVi:
        'Ứng dụng cho một hệ thống quản lý học tập. Lấy cảm hứng từ Quizziz, ứng dụng này cho phép người dùng '
        'xem và chơi các bài quiz, và cho giảng viên tạo bài của riêng họ với nhiều loại câu hỏi. Dữ liệu được lấy từ '
        'MongoDB qua các REST API được tạo bởi đội ngũ back-end của nhóm dự án.',
    functionalities: [
      'Login/signup with email, Google, or Facebook',
      'See recommended quizzes',
      'Search quizzes',
      'View quiz details',
      'Change user profile & password',
      'A dashboard UI for lecturers',
      'Create quizzes with 5 different types of questions',
      'Play quizzes and view scores afterwards',
    ],
    functionalitiesVi: [
      'Đăng nhập/đăng ký bằng email, Google, hoặc Facebook',
      'Xem các bài quiz được đề xuất',
      'Tìm kiếm các bài quiz',
      'Xem chi tiết bài quiz',
      'Thay đổi thông tin cá nhân & mật khẩu',
      'Màn hình dashboard cho giảng viên',
      'Tạo bài quiz với 5 loại câu hỏi khác nhau',
      'Chơi bài quiz và xem điểm sau khi chơi',
    ],
    learned: [
      'Send web requests & use RESTful APIs in an Android app',
      'Use Firebase Auth for authentication functions',
      'Working efficiently with different groups in a project team',
    ],
    learnedVi: [
      'Gửi request & dùng RESTful API trong một ứng dụng Android',
      'Dùng Firebase Auth cho các tính năng xác thực người dùng',
      'Làm việc hiệu quả với các nhóm nhỏ trong một team đề tài',
    ],
    imageUrls: [
      'https://i.imgur.com/iRNbHb6.png',
      'https://i.imgur.com/83lB1fw.png',
      'https://i.imgur.com/YhtE9KI.png',
      'https://i.imgur.com/tYFWRDl.png',
      'https://i.imgur.com/khCK0a1.png',
      'https://i.imgur.com/FKtoAxu.png',
      'https://i.imgur.com/2z8ld0B.png',
      'https://i.imgur.com/VDFlqHn.png',
      'https://i.imgur.com/87YpRQq.png',
    ],
    iconUrl: 'https://i.imgur.com/WjYjKgA.png',
    colorHex: Colors.pink.toARGB32(),
    completionTimestamp: DateTime(2021, 9).millisecondsSinceEpoch,
    featured: false,
  );

  static Project nieNote = Project(
    id: 'nie_note',
    title: 'Nie Note',
    author: 'Nguyễn Gia Hưng',
    tags: [ProjectTag.mobile, ProjectTag.indie],
    tech: 'android,java,sqlite,markdown',
    description:
        'A simple note taking application. Using markdown syntax, you can create the most eye-catching notes '
        'to record everything, from your tasks, shopping list, to your snippets of code.',
    descriptionVi:
        'Một ứng dụng ghi chú đơn giản. Vận dụng cú pháp markdown, bạn có thể tạo những bài ghi chú bắt mắt nhất '
        'để ghi nhận mọi thứ, từ công việc, danh sách mua hàng, đến các đoạn code của bạn.',
    functionalities: [
      'Open text files with Nie Note',
      'Add, delete, edit, restore notes',
      'Sort and search notes by id, name, color, and date',
      'Add special data into notes: images, code, quote, link, table & more…',
      'Format text: Change font, size, alignment, text style, text decoration',
      'Change note background color',
      'Undo/redo changes made to note content',
      'Preview note as markdown code or its formatted output',
      'Settings menu: theming, default format values, and more…',
    ],
    functionalitiesVi: [
      'Mở tệp văn bản bằng Nie Note',
      'Thêm, xóa, sửa, khôi phục ghi chú',
      'Sắp xếp và tìm kiếm ghi chú theo id, tên, màu, và ngày',
      'Thêm nội dung đặc biệt vào ghi chú: ảnh, code, trích dẫn, liên kết,  bảng và nhiều hơn nữa…',
      'Định dạng văn bản: Thay đổi phông chữ, kích thước, căn lề, kiểu chữ, gạch chân…',
      'Thay đổi màu nền của ghi chú',
      'Undo/redo thay đổi đã thực hiện với ghi chú',
      'Xem ghi chú dưới dạng code markdown hoặc nội dung đã định dạng',
      'Menu cài đặt: màu săc app/ghi chú, các giá trị định dạng mặc định, và nhiều hơn nữa…',
    ],
    learned: [
      'Integrate complex Markdown features into an Android app',
      'Local storage using SharedPreferences & SQLite',
      'Optimize UX/UI',
      'Add app into Android\'s Open with dialog',
      'Change app theme using SharedPreferences & theme.xml',
    ],
    learnedVi: [
      'Tích hợp các đặc điểm phức tạp của Markdown vào một ứng dụng Android',
      'Lưu trữ dữ liệu trong máy sử dụng SharedPreferences & SQLite',
      'Tối ưu hoá UX/UI',
      'Thêm ứng dụng vào hộp thoại Mở bằng của Android',
      'Thay đổi màu app bằng SharedPreferences & theme.xml',
    ],
    imageUrls: [
      'https://i.imgur.com/RItoU4u.png',
      'https://i.imgur.com/4lB7OUb.png',
      'https://i.imgur.com/lflJOzz.png',
      'https://i.imgur.com/RK7qM18.png',
      'https://i.imgur.com/UCSX1mz.png',
      'https://i.imgur.com/ZhAAN3t.png',
      'https://i.imgur.com/b5mTpAk.png',
      'https://i.imgur.com/TeNo5wX.png',
    ],
    hostUrl: 'https://github.com/nateclint/nienote',
    iconUrl: 'https://i.imgur.com/cvcLPqp.png',
    colorHex: Colors.grey.toARGB32(),
    completionTimestamp: DateTime(2021, 10).millisecondsSinceEpoch,
    featured: true,
  );

  static Project nieFlat = Project(
    id: 'nie_flat',
    title: 'Nie Flat',
    author: 'Nguyễn Gia Hưng',
    tags: [ProjectTag.mobile, ProjectTag.indie],
    tech: 'android,java,firebase',
    description:
        'A social media app for those living in an apartment complex. Communicate easily with your roommates, '
        'and keep an eye on official news. Admins also have a separate app to manage the rooms, residents, '
        'and posts made in the apartment complex. Data are synchronised with Firebase.',
    descriptionVi:
        'Ứng dụng mạng xã hội cho các cư dân của một khu chung cư. Giao tiếp dễ dàng với bạn cùng phòng của bạn, '
        'và theo dõi tin tức từ chung cư. Các quản trị viên cũng có một ứng dụng riêng để quản lý các phòng, '
        'cư dân và bài đăng trong khu chung cư. Dữ liệu được đồng bộ với Firebase.',
    functionalities: [
      'Login & register',
      'View current user\'s Room information: name & residents',
      'View recent likes and replies',
      'View resident profile: posts & contact information',
      'Pin a post to room board with text & media content',
      'Interact with posts: like, reply, set reminder & copy content',
      'Search for local help & technical help',
      'Manage user profile: posts & information',
      '[Admin] Manage Rooms: View Room information, Add/remove residents in a Room',
      '[Admin] Manage Posts: Delete Posts',
      '[Admin] Manage residents: Search & add new residents, deactivate resident accounts',
      '[Admin] Edit Help information',
    ],
    functionalitiesVi: [
      'Đăng nhập & đăng ký',
      'Xem thông tin Phòng của người dùng: tên và danh sách cư dân',
      'Xem các bài bản thân được yêu thích và bình luận gần đây',
      'Xem tường nhà cư dân: bài đăng và thông tin liên hệ',
      'Đăng bài đăng vào bảng tin phòng của người dùng chứa nội dung chữ và/hoặc hình ảnh',
      'Tương tác với bài đăng: thích, bình luận, đặt hẹn nhắc, copy nội dung',
      'Tìm kiếm cứu trợ lân cận & hỗ trợ kỹ thuật',
      'Quản lý hồ sơ người dùng: bài đăng & thông tin cá nhân',
      '[Admin] Quản lý Phòng: Xem thông tin phòng, Thêm/xóa cư dân trong một phòng',
      '[Admin] Quản lý Bài Đăng: Xóa Bài Đăng',
      '[Admin] Quản lý cư dân: Tìm kiếm & thêm cư dân, vô hiệu hoá tài khoản',
      '[Admin] Sửa thông tin trợ giúp/cứu trợ',
    ],
    learned: [
      'Using Firebase Firestore',
      'Using Firebase Storage for image uploading',
      'Open communication apps with given data using Intents',
      'Change app language using SharedPreferences & strings.xml',
    ],
    learnedVi: [
      'Dùng Firebabse Firestore',
      'Dùng Firebase Storage cho chức năng upload ảnh',
      'Mở các app liên lạc với thông tin điền sẵn sử dụng Intent',
      'Thay đổi ngôn ngữ app sử dụng SharedPreferences & strings.xml',
    ],
    imageUrls: [
      'https://i.imgur.com/QaOALik.png',
      'https://i.imgur.com/oEHQL4h.png',
      'https://i.imgur.com/vjXaAil.png',
      'https://i.imgur.com/BFCMMGm.png',
      'https://i.imgur.com/R0eRhQf.png',
      'https://i.imgur.com/qoOknjE.png',
      'https://i.imgur.com/wqWe2u7.png',
      'https://i.imgur.com/nh8f1FE.png',
      'https://i.imgur.com/C50wdiK.png',
      'https://i.imgur.com/vmWZzZM.png',
    ],
    iconUrl: 'https://i.imgur.com/TbjFuDN.png',
    colorHex: Colors.amber.toARGB32(),
    completionTimestamp: DateTime(2021, 12).millisecondsSinceEpoch,
    featured: true,
  );

  static Project letTutor = Project(
    id: 'let_tutor',
    title: 'LetTutor Clone',
    author: 'Nguyễn Gia Hưng',
    tags: [ProjectTag.mobile, ProjectTag.hcmus],
    tech: 'flutter,jitsi',
    description:
        'A one-on-one learning app to improve your English skills. Search and see your favorite tutors, '
        'join interesting courses, and register as a tutor yourself. This Flutter app uses effective '
        'state management with BlOC.',
    descriptionVi:
        'Ứng dụng gia sư giúp cải thiện kỹ năng tiếng Anh của bạn. Hỗ trợ tìm gia sư, tham gia khóa học hữu ích, '
        'và đăng ký bản thân làm gia sư. Ứng dụng Flutter này sử dụng mô hình quản lý trạng thái BlOC.',
    functionalities: [
      'Login & Register',
      'Tutors: View recommended tutors, search by name & filter by specialties and other attributes',
      'Register as a tutor',
      'See tutor profile, favorite tutor, see reviews & book a class',
      'Schedule: See past & upcoming schedule, view recorded class video, see a summary of your learning progress',
      'Video call with tutor in class (using Jitsi)',
      'Update user profile',
      'Settings: app theme & app language',
    ],
    functionalitiesVi: [
      'Đăng nhập & đăng ký',
      'Gia sư: Xem gia sư được đề xuất, tìm theo tên & lọc theo chuyên môn và một số thông tin khác',
      'Đăng ký làm gia sư',
      'Xem thông tin gia sư, yêu thích gia sư, xem đánh giá và đặt lớp học',
      'Lịch: Xem lịch hẹn trong quá khứ & sắp tới, xem video của buổi học cũ, xem tổng hợp quá trình học tập của bản thân',
      'Gọi video với gia sư trong lớp (sử dụng Jitsi)',
      'Cập nhật thông tin cá nhân',
      'Cài đặt: chủ đề app và ngôn ngữ',
    ],
    learned: [
      'Create a complete Flutter app',
      'Use Material & Cupertino libraries to create a visual UI',
      'Import & use external libraries from pub.dev',
      'Send web requests in Flutter',
      'Using local storage in Flutter for settings & authentication',
      'State management using BLoC',
      'Internationalization using intl',
    ],
    learnedVi: [
      'Tạo một ứng dụng Flutter hoàn chỉnh',
      'Sử dụng thư viện Material & Cupertino để tạo nên một giao diện trực quan',
      'Thêm và dùng các thư viện trên pub.dev',
      'Gửi request trên Flutter',
      'Vận dụng lưu trữ trên thiết bị trong Flutter cho tính năng cài đặt và xác thực người dùng',
      'Quản lý trạng thái sử dụng BLoC',
      'Hỗ trợ đa ngôn ngữ sử dụng thư viện intl',
    ],
    imageUrls: [
      'https://i.imgur.com/dwFRTDQ.png',
      'https://i.imgur.com/HUmPsDB.png',
      'https://i.imgur.com/u9H0Kya.png',
      'https://i.imgur.com/UtZbtzS.png',
      'https://i.imgur.com/0QujLxa.png',
      'https://i.imgur.com/PBfXGY7.png',
      'https://i.imgur.com/5z7k98R.png',
      'https://i.imgur.com/ANoFDsD.png',
      'https://i.imgur.com/hvtwdND.png',
      'https://i.imgur.com/96DTLdZ.png',
      'https://i.imgur.com/L3nyEPr.png',
    ],
    hostUrl: 'https://youtu.be/F7efdFMDYQ4',
    iconUrl: 'https://i.imgur.com/C3nRM4I.png',
    colorHex: Colors.indigo.toARGB32(),
    completionTimestamp: DateTime(2022, 5).millisecondsSinceEpoch,
    featured: true,
  );

  static Project moodleMobile = Project(
    id: 'moodle_mobile',
    title: 'Moodle Mobile',
    author: 'University graduation project',
    authorVi: 'Đồ án tốt nghiệp đại học',
    tags: [ProjectTag.mobile, ProjectTag.hcmus],
    tech: 'flutter,moodle,firebase',
    description:
        'An improved version of the mobile app created by Moodle developers, tailored for the needs of '
        'students and teachers in Ho Chi Minh City University of Science. This app aims for ease of usage, '
        'fast response, a modern UI, and new advance features.',
    descriptionVi:
        'Phiên bản cải tiến của ứng dụng di động được tạo bởi những người phát triển Moodle, đã điều chỉnh '
        'theo nhu cầu của các sinh viên và giảng viên trong trường Đại học Khoa học tự nhiên. Ứng dụng nhắm đến '
        'sự tiện lợi, phản hồi nhanh, giao diện hiện đại, và hỗ trợ các tính năng nâng cao mới.',
    functionalities: [
      'Faster response time',
      'User-friendly UI',
      'Login multiple accounts in different programs',
      'Record course activities',
      'Take notes in courses',
      'Create & vote course polls',
      'Push notifications for events, messages, and notifications from Moodle',
    ],
    functionalitiesVi: [
      'Tốc độ phản hồi được cải thiện',
      'Giao diện thân thiện với người dùng',
      'Đăng nhập nhiều tài khoản với các chương trình giảng dạy khác nhau',
      'Ghi nhận hoạt động của khóa học',
      'Tạo ghi chú trong khóa học',
      'Tạo và bình chọn các bài khảo sát trong khóa học',
      'Thông báo thiết bị các sự kiện, tin nhắn, và thông báo từ Moodle',
    ],
    learned: [
      'Create branches & pull requests, merging pull requests on GitHub',
      'State management using MobX',
      'Preform background tasks when the app is not running',
      'Push notification when the app is not running',
      'Design Moodle plugins using php',
      'Using ImgurAPI for image uploading',
      'Using Firebase Firestore in Flutter',
    ],
    learnedVi: [
      'Tạo nhánh & pull request, xử lý pull request trên GitHub',
      'Quản lý trạng thái sử dụng MobX',
      'Cho phép app chạy nền',
      'Cho phép app gửi thông báo lên thiết bị khi chạy nền',
      'Tạo plugin Moodle sử dụng php',
      'Sử dụng ImgurAPI cho chức năng đăng tải ảnh',
      'Sử dụng Firebase Firestore trong Flutter',
    ],
    imageUrls: [
      'https://i.imgur.com/eNZuBjK.png',
      'https://i.imgur.com/j5sGSgW.png',
      'https://i.imgur.com/o3DBpr1.png',
      'https://i.imgur.com/BJhotaO.png',
      'https://i.imgur.com/II3BZ4V.png',
      'https://i.imgur.com/mUE8rF4.png',
      'https://i.imgur.com/Du4vy4i.png',
      'https://i.imgur.com/LFrqq5l.png',
      'https://i.imgur.com/oIePQJi.png',
      'https://i.imgur.com/yEOeaPK.png',
      'https://i.imgur.com/Td2jCKb.png',
    ],
    hostUrl: 'https://github.com/daoleviethoang/moodle-mobile-fe.git',
    iconUrl: 'https://i.imgur.com/QmADd1a.png',
    colorHex: Colors.green.toARGB32(),
    completionTimestamp: DateTime(2022, 8).millisecondsSinceEpoch,
    featured: true,
  );

  static Project teaMobiAvatarLand = Project(
    id: 'tea_al',
    title: 'Avatar Land',
    author: 'TeaMobi',
    authorVi: 'TeaMobi',
    tags: [ProjectTag.game, ProjectTag.server, ProjectTag.teamobi],
    tech: 'java,mysql,php,unity,firebase',
    description:
        'My first project at TeaMobi. This is a life-sim in continuation of Avatar DK and Avatar Musik, with many '
        'familiar features such as: dress-up, house decorating, fishing, farming, pets, and so much more. This is '
        'my first time working with a professional game development team, and I have learned so much about working '
        'procedures, and gained required knowledge on developing and maintaining an online game.',
    descriptionVi:
        'Dự án đầu tiên của mình tại TeaMobi. Đây là tựa game mô phỏng tiếp nối Avatar DK và Avatar Musik, gồm các '
        'tính năng quen thuộc như thời trang, trang trí nhà, câu cá, nông trại, thú cưng, và nhều hơn nữa. Vì đây '
        'là lần đầu làm việc với một đội ngũ game chuyên nghiệp, mình đã học được về quy trình làm việc của mọi người, '
        'cùng với các kiến thức cần có khi phát triển và duy trì một game online.',
    learned: [
      'Communicate between the server and clients using protocols',
      'Multithreading',
      'Import data templates from Excel/JSON and understand the logic flow of the game\'s data server',
      'Work with MySQL, solve problems related to Connection Pools',
      'Implement OOP design principals to many functionalities of the game',
      'Work with the Game Designer, release new features and fix existing ones based on design documentations',
      'Develop in-game events',
      'Receive user\'s error reports and perform checks, compensations according to normal procedures',
      'Use VPS, and their administrative tools',
      'Create php tools for Admins: player activity reports, player monitoring, manage in-game event banners',
      'Work with Unity clients, develop features, e.g., device notifications, voice messages, UI/UX',
    ],
    learnedVi: [
      'Giao tiếp protocol giữa server và client',
      'Xử lý logic đa luồng',
      'Đọc các dữ liệu template từ Excel/JSON và nghiên cứu luồng logic của server tải dữ liệu',
      'Làm việc với MySQL, xử lý các vấn đề liên quan đến Connection Pool',
      'Vận dụng kiến thức về OOP vào các tính năng lớn của game',
      'Làm việc với Game Design, ra mắt và chỉnh sửa các tính năng dựa trên tài liệu thiết kế',
      'Phát triển các sự kiện game',
      'Tiếp nhận báo cáo lỗi của người dùng và thực hiện kiểm tra, đền bù theo quy trình',
      'Sử dụng VPS, và các công cụ quản trị server',
      'Tạo tool php dành cho Admin: thống kê số liệu người chơi, xem dữ liệu người chơi, quản lý các banner sự kiện trong game',
      'Làm việc với client Unity, lập trình các tính năng như: thông báo hệ thống, tin nhắn thoại, thiết kế các UI/UX',
    ],
    hostUrl: 'http://gomobi.vn/home/game/Avatar-Land-14.html',
    iconUrl: 'http://teamobi.com/home/images/icons/avatarland.png',
    colorHex: Colors.blue.toARGB32(),
    completionTimestamp: DateTime(2023, 1, 6).millisecondsSinceEpoch,
    featured: true,
  );

  static Project teaMobiNro = Project(
    id: 'tea_nro',
    title: 'Ngoc Rong Online',
    author: 'TeaMobi',
    authorVi: 'TeaMobi',
    tags: [ProjectTag.game, ProjectTag.server, ProjectTag.teamobi],
    tech: 'java,mysql,php,testflight',
    description:
        'My second project at TeaMobi. Ngoc Rong Online is a well-known MMORPG made by TeaMobi, inspired from the manga '
        'Dragon Ball. From working with the NRO team, I have learned a lot of coding technique & logical thinking from '
        'seasoned developers, and be able to apply that to future projects at this company.',
    descriptionVi:
        'Dự án thứ hai mình tham gia tại TeaMobi, Ngọc Rồng Online là tựa game MMORPG nổi tiếng của TeaMobi, lấy '
        'cảm hứng từ cốt truyện của Dragon Ball. Nhờ làm việc trong đội ngũ NRO, mình đã học hỏi được nhiều kinh nghiệm '
        'code & logic từ các anh lão làng, thông qua đó có thể áp dụng cho các dự án sau tại công ty.',
    learned: [
      'Program bots based on existing logic of the Player class',
      'Extend php tools based on existing codebase',
      'Understand the procedure of uploading an app to App Store and Testflight',
      'Understand Apple\'s App Review Guidelines, and resolve any issue faced',
    ],
    learnedVi: [
      'Lập trình bot dựa trên logic có sẵn của class Player',
      'Mở rộng tool php dựa trên codebase đã có sẵn',
      'Nghiên cứu về quy trình upload ứng dụng lên App Store và Testflight',
      'Nghiên cứu về các điều khoản để được App Store kiểm duyệt, và giải quyết những vấn đề gặp phải',
    ],
    hostUrl: 'https://ngocrongonline.com/trang-chu',
    iconUrl: 'https://ngocrongonline.com/images/logo.png',
    colorHex: Colors.orange.toARGB32(),
    completionTimestamp: DateTime(2023, 6, 1).millisecondsSinceEpoch,
    featured: false,
  );

  static Project teaMobiAvatarBum = Project(
    id: 'tea_ab',
    title: 'Avatar Bum',
    author: 'TeaMobi',
    authorVi: 'TeaMobi',
    tags: [ProjectTag.game, ProjectTag.server, ProjectTag.teamobi],
    tech: 'java,mysql',
    description:
        'Avatar Bum is the next Avatar game by TeaMobi, taking inspiration from the childhood game "Boom Online". '
        'This game contains many familiar features such as: PvP, PvE, each player can buy fashion accessories, '
        'and also items that can assist them in each battle.',
    descriptionVi:
        'Avatar Bùm là tựa game Avatar kế tiếp của TeaMobi, lấy cảm hứng từ game Boom Online tuổi thơ. Game bao gồm '
        'các cơ chế quen thuộc như chiến đấu với máy/người, và người chơi có thể mua phụ kiện thời trang, cũng như '
        'các vật phẩm hỗ trợ trong các ván chơi.',
    learned: [
      'Realtime programming for the game\'s bombing mechanism',
      'Apply data encryption algorithm into images to protect company\'s resources',
      'Learn about the top-up procedure, create a php page to link to the company\'s top-up server',
      'Apply realtime pathfinding algorithms into enemies and bosses',
    ],
    learnedVi: [
      'Lập trình realtime cho cơ chế đặt bom của game ',
      'Áp dụng thuật toán mã hoá hình ảnh để bảo mật tài nguyên của công ty',
      'Học được quy trình nạp tiền, tạo trang php để liên kết với server nạp tiền của công ty',
      'Áp dụng các thuật toán tìm đường realtime vào các con quái, boss',
    ],
    hostUrl: 'http://avatarbum.teamobi.com/',
    iconUrl: 'http://avatarbum.teamobi.com/img/Bum/logo/eafa4db8d5.png',
    colorHex: Colors.lightBlue.toARGB32(),
    completionTimestamp: DateTime(2024, 4, 17).millisecondsSinceEpoch,
    featured: false,
  );

  static Project teaMobiStpt = Project(
    id: 'tea_stpt',
    title: 'Son Thuy Phan Tranh',
    author: 'TeaMobi',
    authorVi: 'TeaMobi',
    tags: [ProjectTag.game, ProjectTag.server, ProjectTag.teamobi],
    tech: 'java,mysql',
    description:
        'Son Thuy Phan Tranh is a MMORPG inspired from the myth of Son Tinh and Thuy Tinh. The game has gained a number '
        'of loyal players from its detailed combat mechanics, interesting storytelling, and eye-catching graphics. '
        'During my time with the development team, I have maintained and developed game events, new features, using '
        'everything I learned at this company.',
    descriptionVi:
        'Sơn Thuỷ Phân Tranh là tựa game MMORPG lấy cảm hứng từ truyền thuyết Sơn Tinh Thuỷ Tinh. Với cơ chế combat '
        'chi tiết và đồ hoạ bắt mắt, cùng với cốt truyện thú vị, Sơn Thuỷ Phân Tranh đã thu hút được một lượng '
        'người chơi trung thành. Khi mình tham gia vào đội ngũ phát triển game, với những kiến thức có sẵn, mình đã '
        'hỗ trợ mọi người duy trì và ra mắt một số sự kiện, cũng như tính năng mới cho game.',
    hostUrl: 'https://sonthuyphantranh.com/',
    iconUrl: 'http://teamobi.com/home/images/icons/stpt.png',
    colorHex: Colors.deepPurple.toARGB32(),
    completionTimestamp: DateTime(2025, 6, 15).millisecondsSinceEpoch,
    featured: false,
  );

  static Project teaMobiNhanGia = Project(
    id: 'tea_ccng',
    title: 'Ninja War',
    author: 'TeaMobi',
    authorVi: 'TeaMobi',
    tags: [ProjectTag.game, ProjectTag.server, ProjectTag.teamobi],
    tech: 'java,mysql,php',
    description:
        'Ninja War is TeaMobi\'s newest MMORPG. This is my most passionate project, and the server\'s entire codebase '
        'has been built solely by me. During my time with this team, I have applied all learned techniques from previous '
        'projects into game features and optimizing system performance. I have also designed an easy-to-read and '
        'easy-to-maintain codebase. This project solidify my software developing skills, from the ability to fix bugs '
        'and code swiftly and efficiently.',
    descriptionVi:
        'Cuộc Chiến Nhẫn Giả là tựa game MMORPG mới nhất của TeaMobi. Đây là dự án tâm huyết nhất của mình, toàn bộ '
        'codebase của server do chính mình phát triển lên. Trong thời gian làm việc với đội ngũ CCNG, mình đã áp dụng '
        'tất cả kỹ thuật học được từ những dự án trước để phát triển các tính năng và thực hiện các thao tác tối ưu '
        'hiệu suất, cùng với thiết kế một hệ thống code dễ đọc và bảo trì. Dự án này đã khẳng định được khả năng '
        'lập trình của mình, do mình đã có thể sửa lỗi và code một cách rất nhanh chóng và hiệu quả.',
    learned: [
      'Independently develop the server\'s codebase from the company\'s common source code',
      'Optimize performance and resources from gained knowledge of collections and how java core classes/methods operate',
      'Extends java core classes to create new classes & utility methods, making the codebase easier to read and more compact',
      'Efficiently utilize Intellij\'s debugging tools to quickly handle bug reports',
      'Efficiently utilize GitHub Copilot to double the coding speed',
      'Minimize hardcode data and design data sheets for the Game Designer that are easy to read and edit',
      'Develop a flexible codebase that can easily adapt to new design changes',
      'Create php tools optimized in UI/UX to monitor game status and manage players',
    ],
    learnedVi: [
      'Phát triển độc lập toàn bộ hệ thống code server từ một mã nguồn chung của công ty',
      'Tối ưu hiệu suất & tài nguyên từ kiến thức đã biết về collection, cách hoạt động của các hàm/class core java',
      'Kế thừa các class core java, tạo ra class và hàm tiện ích để codebase đọc dễ hiểu và gọn hơn',
      'Vận dụng tốt công cụ debugging của Intellij để nhanh chóng sửa các lỗi được báo cáo',
      'Vận dụng tốt khả năng tiên đoán của GitHub Copilot trong lúc code để tăng gấp đôi tốc độ làm việc',
      'Giảm thiểu tối đa dữ liệu cứng và thiết kế các file excel dễ dùng và đọc với Game Design',
      'Lập trình một cách linh hoạt để khi đổi thiết kế tính năng có thể dễ dàng chỉnh sửa code',
      'Tạo ra các trang công cụ php được tối ưu UI/UX dùng để theo dõi chỉ số game và quản lý người chơi',
    ],
    hostUrl: 'http://ccng.gomobi.vn',
    iconUrl: 'https://ccngdemo.teamobi.com/static/img/LOGO_NEW.png',
    colorHex: Colors.amber.toARGB32(),
    completionTimestamp: DateTime(2026).millisecondsSinceEpoch,
    featured: true,
  );
}

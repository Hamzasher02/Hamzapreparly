class ApiEndPoints {
  static const String baseUrl =
      "https://preparlybackend.steamminds.co/preparely/";
  static _AuthEndPoints authEndPoints =
      _AuthEndPoints(); //to use the private class items outside the class then we have to initialize and declare the 'object' of private class inside the Public Class.
// 'authEndPoints' is the object of Private Class  "_AuthEndPoints" which is declared and initialized in the Public Class to that the Private Class can be accessed through Public Class.
}

class _AuthEndPoints {
  final String registerEmail = 'user/signup';
  final String loginEmail = 'user/signin';
  final String logoutUser = 'user/logout';
  final String forgotPassword = 'user/forgotpassword';
  final String resetPassword = 'user/password/reset';
  final String gridViewCatagories = 'category';
  final String dropdownCategories = 'subcategory';
  final String subject = 'subject';
  final String chapter = 'chapter';
  final String video = 'video';
  final String pdf = 'pdf';
  final String mcq = 'mcq';
  final String banner = 'banner';
  final String userProfile = 'user/me';
  final String verifyOTP = 'user/verify';
  final String mockList = 'mock';
  final String mockQuestion = 'mockquestion';
  final String pastPapersList = 'pastpaper';
  final String pastPapersMcqs = 'pastquestion';
}

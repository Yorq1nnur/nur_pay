class AppConstants {
  static String placeHolder = "";

  static RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static RegExp passwordRegExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  static RegExp textRegExp = RegExp(r'^[a-zA-Z\s]+$');
}

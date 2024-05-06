class AppConstants {
  static String placeHolder = "";
  static String users = "users";
  static String cards = "cards";
  static String cardsDb = "cards_db";

  static RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static RegExp phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  static RegExp passwordRegExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  static RegExp textRegExp = RegExp(r'^[a-zA-Z\s]+$');
}

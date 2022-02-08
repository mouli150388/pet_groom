

class ApiConstants {
  ApiConstants._();

  static const String baseUrl ='https://demo.technosquare.co.in/';
  static const String subUrl ='grooming/api/';
  static const String apiKey = 'MGAeNWo2jEnpjGMZwe';
  static const String baseImageUrl = baseUrl+'grooming/images/services/';
  static const String baseIconUrl =baseUrl+ 'grooming/event/icon/';
  static const String baseUserProfile =baseUrl+ 'grooming/images/users/';
  static const String videoKey = '';

  static const String login = subUrl+'login.php?token=$apiKey';
  static const String signup = subUrl+'signup.php?token=$apiKey';
  static const String resend = subUrl+'resend-otp.php?token=$apiKey';
  static const String updateUserstatus = subUrl+'update-user-status.php?token=$apiKey';
  static const String passwordchange = subUrl+'change-password.php?token=$apiKey';
  static const String service = subUrl+'service-list.php?token=$apiKey';
  static const String updateProfile = subUrl+'profile-update.php?token=$apiKey';
  static const String getUserDetails = subUrl+'user-details.php?token=$apiKey';
  static const String forgotpassword = subUrl+'forgot-password.php?token=$apiKey';
  static const String uploadImage = subUrl+'profile-picture-update.php?token=$apiKey';
  static const String add_pet_info = subUrl+'add-pet-info.php?token=$apiKey';
  static const String update_pet_info = subUrl+'update-pet-info.php?token=$apiKey';
  static const String get_my_pets = subUrl+'mypets.php?token=$apiKey';
  static const String time_slots = subUrl+'service_time_availability.php?token=$apiKey';
  static const String book_appointment = subUrl+'booking.php?token=$apiKey';
  static const String my_bookings = subUrl+'my-bookings.php?token=$apiKey';
  static const String booking_cancel = subUrl+'booking-cancel.php?token=$apiKey';

  static const String validateForgotOtp = 'validateForgotOtp';
  static const String changeForgotPassword = 'changeForgotPassword';
  static const String logout = 'logout';
  static  String USER_ID = "";
  static  String user_country_code = "";
  static  String USER_Name = "";
  static  String IMAGE = "";
  static  int LANG_CODE = 0;



}

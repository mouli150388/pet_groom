class ApiResponse{
  String code;
  bool status;
  String msg;
  dynamic data;

  ApiResponse({required this.code,required this.status,this.data,required this.msg});

  factory ApiResponse.fromMap(Map<String, dynamic> json) {
    return ApiResponse(

      code:  json['code'] as String,
      status:  json['status']=="true",
      data:  json['data'] ,
      msg:  getMessage(json['code']) ,

    );
  }
  
  static String getMessage(String code)
  {
    switch(code)
    {
      case "1": return "Please provide API token";
      break;
      case "2": return "Please provide valid API token ";
      break;
      case "3": return "API token deactivated ";
      break;
      case "4": return "Data not found ";
      break;
      case "5": return "Data found ";
      break;
      case "6": return "User already exists ";
    break;
    case "7": return "Account created successfully ";
    break;
      case "8": return " Something went wrong please try again after sometime";
      break;
      case "9": return "Login sucess";
      break;
      case "10": return "Wrong credentials";
      break;
      case "11": return "Account block by admin ";
      break;
      case "12": return "";
      break;
      case "13": return "";
      break;
      case "14": return "Email id already registered with us ";
      break;
      case "15":  return "Mobile Number already registered with us";
      break;
      case "16": return "Account not activated";
      break;
      case "17": return "Password changed successfully";
      break;

      case "18": return "Password not matched";
      break;
      case "19": return "OTP not send";
      break;
      case "20": return "OTP send";
      break;
      case "21": return "Status Changed";
      break;
      case "22": return "Profile Updated";
      break;
      case "23": return "Profile picture updated successfully";
      break;
      case "24": return "Record Save Successfully";
      break;
      case "25": return "Pet info Updated Successfully";
      break;

      case "26": return "Account not exist";
      break;
      case "27": return "Booking Cancel Successfully";
      break;

      
    }
    return "";
  }
}

/*
1=> Please provide API token
2=> Please provide valid API token
3=> API token deactivated
4=> Data not found
5=> Data found
6=> User already exists
7=> Account created successfully
8=> Something went wrong please try again after sometime
9=> Login sucess
10=> Wrong credentials
11=> Account block by admin
14=> Email id already registered with us
15=> Mobile Number already registered with us
16=> Account not activated
17=> Password changed successfully 18=> Password not matched 19=> OTP not send 20=> OTP send */

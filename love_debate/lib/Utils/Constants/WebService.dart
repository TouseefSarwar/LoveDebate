class WebService{

//  static var baseURL = "https://lovedebate.co/api/";
  static var baseURL = "https://lovedebate.co/public/api/";
  static var registerUser = "register";
  ///Login without Token
  static var login = "login";
  static var onboardingApi = "questions/1";
  static var data = "data";
  static var answers = "answers";
  static var test = "test";
  static var prematches = "prematches";
  static var userAnswers = "userDetail";

  static var socialLogin = "social_login";
  static var updateProfile = "update_profile";
  static var updatePassword = "update_password";
  static var logout = "logout";
  static var roundCategories = "categories/1";

  ///Rounds Module Api's
  static var updateStatusDecline = "update_status"; ///parameters Should be { status : 1 , round_id : r_id.....}
  static var answerRound = "question_answer";  ///{cate_id' => 'required','id','question_id','answer','q1' 'q2','q3'};
//  static var rounds = "questions/2";
  static var makeConnection = "make_connection";
  static var rounds = "rounds";

  static var chatUsersList = 'conv_list';
  static var conversationList = 'user_chat';

  static var uploadProfileImage = "image_upload";

}

class HttpMethod{
  static String post = "post";
  static String get = 'get';
}

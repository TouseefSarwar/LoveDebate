class UserDetail {
  int id;
  String socialLoginId;
  String socialLoginType;
  String firstName;
  String lastName;
  String email;
  String password;
  String dob;
  String height;
  String profilePic;
  String gender;
  String address;
  String state;
  String city;
  String lat;
  String lng;
  String faith;
  String ethnicity;
  String status;
  String emailVerifiedAt;
  String rememberToken;
  String createdAt;
  String updatedAt;
  String prId;
  String prUserId;
  String prHeight;
  String prSerious;
  String prMatchArea;
  String prAvgIncomeStart;
  String prAverageIncome;
  String prAvgIncomeEnd;
  String prProfession;
  String prGoals;
  String prExpectations;
  String prCharacteristic;
  String prIe;
  String prSingle;
  String prSingleDislikes;
  String prKids;
  String prLocation;
  String prFaithDislikes;
  String prReligious;
  String prEthnicityDislikes;
  String prOtherDislikes;
  String prTownLikes;
  String prTownDislikes;
  String prVacations;
  String prCurse;
  String prHobbiesOutdoor;
  String prHobbiesOutdoorDislikes;
  String prHobbiesIndoor;
  String prHobbiesIndoorDislikes;

  String kidsStr;
  String faithStr;
  String ethnicityStr;
  String professionsStr;
  String faithDislikeStr;
  String ethnicityDislikeStr;
  String roundNo;
  int cateId;

  UserDetail(
      {this.id,
        this.socialLoginId,
        this.socialLoginType,
        this.firstName,
        this.lastName,
        this.email,
        this.password,
        this.dob,
        this.height,
        this.profilePic,
        this.gender,
        this.address,
        this.state,
        this.city,
        this.lat,
        this.lng,
        this.faith,
        this.ethnicity,
        this.status,
        this.emailVerifiedAt,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
        this.prId,
        this.prUserId,
        this.prHeight,
        this.prSerious,
        this.prMatchArea,
        this.prAvgIncomeStart,
        this.prAverageIncome,
        this.prAvgIncomeEnd,
        this.prProfession,
        this.prGoals,
        this.prExpectations,
        this.prCharacteristic,
        this.prIe,
        this.prSingle,
        this.prSingleDislikes,
        this.prKids,
        this.prLocation,
        this.prFaithDislikes,
        this.prReligious,
        this.prEthnicityDislikes,
        this.prOtherDislikes,
        this.prTownLikes,
        this.prTownDislikes,
        this.prVacations,
        this.prCurse,
        this.prHobbiesOutdoor,
        this.prHobbiesOutdoorDislikes,
        this.prHobbiesIndoor,
        this.prHobbiesIndoorDislikes,
        this.kidsStr,
        this.faithStr,
        this.ethnicityStr,
        this.professionsStr,
        this.faithDislikeStr,
        this.ethnicityDislikeStr,
        this.roundNo,
        this.cateId,
      });

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    socialLoginId = json['social_login_id'].toString();
    socialLoginType = json['social_login_type'].toString();
    firstName = json['first_name'].toString();
    lastName = json['last_name'].toString();
    email = json['email'].toString();
    password = json['password'].toString();
    dob = json['dob'].toString();
    profilePic = json["profile_pic"].toString();
    height = json['height'].toString();
    gender = json['gender'].toString();
    address = json['address'].toString();
    state = json['state'].toString();
    city = json['city'].toString();
    lat = json['lat'].toString();
    lng = json['lng'].toString();
    faith = json['faith'].toString();
    ethnicity = json['ethnicity'].toString();
    status = json['status'].toString();
    emailVerifiedAt = json['email_verified_at'].toString();
    rememberToken = json['remember_token'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    prId = json['pr_id'].toString();
    prUserId = json['pr_user_id'].toString();
    prHeight = json['pr_height'].toString();
    prSerious = json['pr_serious'].toString();
    prMatchArea = json['pr_match_area'].toString();
    prAvgIncomeStart = json['pr_avg_income_start'].toString();
    prAverageIncome = json['pr_average_income'].toString();
    prAvgIncomeEnd = json['pr_avg_income_end'].toString();
    prProfession = json['pr_profession'].toString();
    prGoals = json['pr_goals'].toString();
    prExpectations = json['pr_expectations'].toString();
    prCharacteristic = json['pr_characteristic'].toString();
    prIe = json['pr_ie'].toString();
    prSingle = json['pr_single'].toString();
    prSingleDislikes = json['pr_single_dislikes'].toString();
    prKids = json['pr_kids'].toString();
    prLocation = json['pr_location'].toString();
    prFaithDislikes = json['pr_faith_dislikes'].toString();
    prReligious = json['pr_religious'].toString();
    prEthnicityDislikes = json['pr_ethnicity_dislikes'].toString();
    prOtherDislikes = json['pr_other_dislikes'].toString();
    prTownLikes = json['pr_town_likes'].toString();
    prTownDislikes = json['pr_town_dislikes'].toString();
    prVacations = json['pr_vacations'].toString();
    prCurse = json['pr_curse'].toString();
    prHobbiesOutdoor = json['pr_hobbies_outdoor'].toString();
    prHobbiesOutdoorDislikes = json['pr_hobbies_outdoor_dislikes'].toString();
    prHobbiesIndoor = json['pr_hobbies_indoor'].toString();
    prHobbiesIndoorDislikes = json['pr_hobbies_indoor_dislikes'].toString();
    kidsStr = json['kids_str'];
    faithStr = json['faith_str'];
    ethnicityStr = json['ethnicity_str'];
    professionsStr = json['professions_str'];
    faithDislikeStr = json['faith_dislike_str'];
    ethnicityDislikeStr = json['ethnicity_dislike_str'];
    roundNo = json['roundNo'];
    cateId = json['cate_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['social_login_id'] = this.socialLoginId;
    data['social_login_type'] = this.socialLoginType;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['dob'] = this.dob;
    data['height'] = this.height;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['state'] = this.state;
    data['city'] = this.city;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['faith'] = this.faith;
    data['ethnicity'] = this.ethnicity;
    data['status'] = this.status;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['pr_id'] = this.prId;
    data['pr_user_id'] = this.prUserId;
    data['pr_height'] = this.prHeight;
    data['pr_serious'] = this.prSerious;
    data['pr_match_area'] = this.prMatchArea;
    data['pr_avg_income_start'] = this.prAvgIncomeStart;
    data['pr_average_income'] = this.prAverageIncome;
    data['pr_avg_income_end'] = this.prAvgIncomeEnd;
    data['pr_profession'] = this.prProfession;
    data['pr_goals'] = this.prGoals;
    data['pr_expectations'] = this.prExpectations;
    data['pr_characteristic'] = this.prCharacteristic;
    data['pr_ie'] = this.prIe;
    data['pr_single'] = this.prSingle;
    data['pr_single_dislikes'] = this.prSingleDislikes;
    data['pr_kids'] = this.prKids;
    data['pr_location'] = this.prLocation;
    data['pr_faith_dislikes'] = this.prFaithDislikes;
    data['pr_religious'] = this.prReligious;
    data['pr_ethnicity_dislikes'] = this.prEthnicityDislikes;
    data['pr_other_dislikes'] = this.prOtherDislikes;
    data['pr_town_likes'] = this.prTownLikes;
    data['pr_town_dislikes'] = this.prTownDislikes;
    data['pr_vacations'] = this.prVacations;
    data['pr_curse'] = this.prCurse;
    data['pr_hobbies_outdoor'] = this.prHobbiesOutdoor;
    data['pr_hobbies_outdoor_dislikes'] = this.prHobbiesOutdoorDislikes;
    data['pr_hobbies_indoor'] = this.prHobbiesIndoor;
    data['pr_hobbies_indoor_dislikes'] = this.prHobbiesIndoorDislikes;
    data['kids_str'] = this.kidsStr;
    data['faith_str'] = this.faithStr;
    data['ethnicity_str'] = this.ethnicityStr;
    data['professions_str'] = this.professionsStr;
    data['faith_dislike_str'] = this.faithDislikeStr;
    data['ethnicity_dislike_str'] = this.ethnicityDislikeStr;
    data['roundNo'] = this.roundNo;
    data['cate_id'] = this.cateId;
    return data;
  }
}
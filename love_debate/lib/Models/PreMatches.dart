class PreMatchesModel {
  List<Matches> success;

  PreMatchesModel({this.success});

  PreMatchesModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] != null) {
      success = new List<Matches>();
      json['success'].forEach((v) {
        success.add(new Matches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Matches {
  String firstName;
  String lastName;
  String dob;
  String email;
  String height;
  int gender;
  String state;
  String city;
  String faith;
  int ethnicity;
  String address;
  int prId;
  int prUserId;
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
  String roundNo;
  int cateId;

  Matches(
      {this.firstName,
        this.lastName,
        this.dob,
        this.email,
        this.height,
        this.gender,
        this.state,
        this.city,
        this.faith,
        this.ethnicity,
        this.address,
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
        this.roundNo,
        this.cateId,
      });

  Matches.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    dob = json['dob'];
    email = json['email'];
    height = json['height'].toString();
    gender = json['gender'];
    state = json['state'];
    city = json['city'];
    faith = json['faith'];
    ethnicity = json['ethnicity'];
    address = json['address'];
    prId = json['pr_id'];
    prUserId = json['pr_user_id'];
    prHeight = json['pr_height'];
    prSerious = json['pr_serious'];
    prMatchArea = json['pr_match_area'];
    prAvgIncomeStart = json['pr_avg_income_start'];
    prAverageIncome = json['pr_average_income'];
    prAvgIncomeEnd = json['pr_avg_income_end'];
    prProfession = json['pr_profession'];
    prGoals = json['pr_goals'];
    prExpectations = json['pr_expectations'];
    prCharacteristic = json['pr_characteristic'];
    prIe = json['pr_ie'];
    prSingle = json['pr_single'];
    prSingleDislikes = json['pr_single_dislikes'];
    prKids = json['pr_kids'];
    prLocation = json['pr_location'];
    prFaithDislikes = json['pr_faith_dislikes'];
    prReligious = json['pr_religious'];
    prEthnicityDislikes = json['pr_ethnicity_dislikes'];
    prOtherDislikes = json['pr_other_dislikes'];
    prTownLikes = json['pr_town_likes'];
    prTownDislikes = json['pr_town_dislikes'];
    prVacations = json['pr_vacations'];
    prCurse = json['pr_curse'];
    prHobbiesOutdoor = json['pr_hobbies_outdoor'];
    prHobbiesOutdoorDislikes = json['pr_hobbies_outdoor_dislikes'];
    prHobbiesIndoor = json['pr_hobbies_indoor'];
    prHobbiesIndoorDislikes = json['pr_hobbies_indoor_dislikes'];
    roundNo = json['roundNo'];
    cateId = json['cate_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['height'] = this.height;
    data['gender'] = this.gender;
    data['state'] = this.state;
    data['city'] = this.city;
    data['faith'] = this.faith;
    data['ethnicity'] = this.ethnicity;
    data['address'] = this.address;
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
    data['roundNo'] = this.roundNo;
    data['cate_id'] = this.cateId;
    return data;
  }
}
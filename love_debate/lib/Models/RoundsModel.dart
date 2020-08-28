

class RoundsModel {
  int rId;
  int rCateId;
  int rUserId;
  int rPlayerId;
  int rQuesOneId;
  int rQuesTwoId;
  int rQuesThreeId;
  String rPlayerAnsOne;
  String rPlayerAnsTwo;
  String rPlayerAnsThree;
  String rUserAnsOne;
  String rUserAnsTwo;
  String rUserAnsThree;
  int rStatus;
  Null createdAt;
  String updatedAt;
  String questionOne;
  String questionTwo;
  String questionThree;

  RoundsModel(
      {this.rId,
        this.rCateId,
        this.rUserId,
        this.rPlayerId,
        this.rQuesOneId,
        this.rQuesTwoId,
        this.rQuesThreeId,
        this.rPlayerAnsOne,
        this.rPlayerAnsTwo,
        this.rPlayerAnsThree,
        this.rUserAnsOne,
        this.rUserAnsTwo,
        this.rUserAnsThree,
        this.rStatus,
        this.createdAt,
        this.updatedAt,
        this.questionOne,
        this.questionTwo,
        this.questionThree});

  RoundsModel.fromJson(Map<String, dynamic> json) {
    rId = json['r_id'];
    rCateId = json['r_cate_id'];
    rUserId = json['r_user_id'];
    rPlayerId = json['r_player_id'];
    rQuesOneId = json['r_ques_one_id'];
    rQuesTwoId = json['r_ques_two_id'];
    rQuesThreeId = json['r_ques_three_id'];
    rPlayerAnsOne = json['r_player_ans_one'];
    rPlayerAnsTwo = json['r_player_ans_two'];
    rPlayerAnsThree = json['r_player_ans_three'];
    rUserAnsOne = json['r_user_ans_one'];
    rUserAnsTwo = json['r_user_ans_two'];
    rUserAnsThree = json['r_user_ans_three'];
    rStatus = json['r_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    questionOne = json['questionOne'];
    questionTwo = json['questionTwo'];
    questionThree = json['questionThree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r_id'] = this.rId;
    data['r_cate_id'] = this.rCateId;
    data['r_user_id'] = this.rUserId;
    data['r_player_id'] = this.rPlayerId;
    data['r_ques_one_id'] = this.rQuesOneId;
    data['r_ques_two_id'] = this.rQuesTwoId;
    data['r_ques_three_id'] = this.rQuesThreeId;
    data['r_player_ans_one'] = this.rPlayerAnsOne;
    data['r_player_ans_two'] = this.rPlayerAnsTwo;
    data['r_player_ans_three'] = this.rPlayerAnsThree;
    data['r_user_ans_one'] = this.rUserAnsOne;
    data['r_user_ans_two'] = this.rUserAnsTwo;
    data['r_user_ans_three'] = this.rUserAnsThree;
    data['r_status'] = this.rStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['questionOne'] = this.questionOne;
    data['questionTwo'] = this.questionTwo;
    data['questionThree'] = this.questionThree;
    return data;
  }
}
class OnBoardingDataModel {
  List<Success> success;

  OnBoardingDataModel({this.success});

  OnBoardingDataModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] != null) {
      success = new List<Success>();
      json['success'].forEach((v) {
        success.add(new Success.fromJson(v));
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

class Success {
  int qaId;
  String qaQuestion;
  String qaSlug;
  int qaQuestionType;
  String qaFieldType;
  String qaOptions;
  String qaPlaceholder;
  int qaSkipable;
  int qaStatus;
  Null createdAt;
  Null updatedAt;

  Success(
      {this.qaId,
        this.qaQuestion,
        this.qaSlug,
        this.qaQuestionType,
        this.qaFieldType,
        this.qaOptions,
        this.qaPlaceholder,
        this.qaSkipable,
        this.qaStatus,
        this.createdAt,
        this.updatedAt});

  Success.fromJson(Map<String, dynamic> json) {
    qaId = json['qa_id'];
    qaQuestion = json['qa_question'];
    qaSlug = json['qa_slug'];
    qaQuestionType = json['qa_question_type'];
    qaFieldType = json['qa_field_type'];
    qaOptions = json['qa_options'];
    qaPlaceholder = json['qa_placeholder'];
    qaSkipable = json['qa_skipable'];
    qaStatus = json['qa_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qa_id'] = this.qaId;
    data['qa_question'] = this.qaQuestion;
    data['qa_slug'] = this.qaSlug;
    data['qa_question_type'] = this.qaQuestionType;
    data['qa_field_type'] = this.qaFieldType;
    data['qa_options'] = this.qaOptions;
    data['qa_placeholder'] = this.qaPlaceholder;
    data['qa_skipable'] = this.qaSkipable;
    data['qa_status'] = this.qaStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AnswersModel{

  int qId;
  String qSlug;
  dynamic answers;


  AnswersModel({this.qId,this.qSlug, this.answers});


  AnswersModel.fromJson(Map<String, dynamic> json) {
    qId = json['q_id'];
    qSlug = json['q_slug'];
    answers = json['answer'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qa_id'] = this.qId;
    data['qa_slug'] = this.qSlug;
    data['answer'] = this.answers;
    return data;
  }

}
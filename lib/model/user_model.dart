class UserModel {
  String? id;
  String? title;
  String? notes;
  String? images;

  UserModel({this.id, this.title, this.notes, this.images});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    notes = json['notes'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['notes'] = this.notes;
    data['images'] = this.images;
    return data;
  }
}

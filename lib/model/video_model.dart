class VideoModel {
  String? id;
  String? videoLink;
  String? name;
  int? order;
  String? createdAt;
  String? updatedAt;

  VideoModel(
      {this.id,
      this.videoLink,
      this.name,
      this.order,
      this.createdAt,
      this.updatedAt});

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoLink = json['videoLink'];
    name = json['name'];
    order = json['order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['videoLink'] = this.videoLink;
    data['name'] = this.name;
    data['order'] = this.order;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ProfileDataModel {
  ProfileDataModel({
      this.status, 
      this.profile,});

  ProfileDataModel.fromJson(dynamic json) {
    status = json['status'];
    profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }
  String? status;
  Profile? profile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (profile != null) {
      map['profile'] = profile?.toJson();
    }
    return map;
  }

}

class Profile {
  Profile({
      this.id, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.status, 
      this.featuredImageId, 
      this.role, 
      this.deletedAt, 
      this.createdAt, 
      this.updatedAt,});

  Profile.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    status = json['status'];
    featuredImageId = json['featured_image_id'];
    role = json['role'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? firstName;
  String? lastName;
  String? email;
  String? status;
  dynamic featuredImageId;
  String? role;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['status'] = status;
    map['featured_image_id'] = featuredImageId;
    map['role'] = role;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}
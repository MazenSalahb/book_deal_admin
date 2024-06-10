class SubscriptionModel {
  int? id;
  int? userId;
  int? bookId;
  int? price;
  String? startDate;
  String? endDate;
  String? status;
  String? createdAt;
  String? updatedAt;
  Book? book;
  User? user;

  SubscriptionModel(
      {this.id,
      this.userId,
      this.bookId,
      this.price,
      this.startDate,
      this.endDate,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.book,
      this.user});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bookId = json['book_id'];
    price = json['price'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    book = json['book'] != null ? Book.fromJson(json['book']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class Book {
  int? id;
  String? title;
  String? author;
  String? description;
  int? categoryId;
  String? status;
  String? availability;
  String? approvalStatus;
  int? price;
  String? image;
  int? userId;
  String? featured;
  String? createdAt;
  String? updatedAt;

  Book(
      {this.id,
      this.title,
      this.author,
      this.description,
      this.categoryId,
      this.status,
      this.availability,
      this.approvalStatus,
      this.price,
      this.image,
      this.userId,
      this.featured,
      this.createdAt,
      this.updatedAt});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    description = json['description'];
    categoryId = json['category_id'];
    status = json['status'];
    availability = json['availability'];
    approvalStatus = json['approval_status'];
    price = json['price'];
    image = json['image'];
    userId = json['user_id'];
    featured = json['featured'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? location;
  String? profilePicture;
  String? role;
  Null emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.location,
      this.profilePicture,
      this.role,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    location = json['location'];
    profilePicture = json['profile_picture'];
    role = json['role'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

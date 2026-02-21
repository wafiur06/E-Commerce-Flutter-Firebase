
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ReviewModel reviewModelFromJson(String str) => ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  final String? userId;
  final String? userName;
  final String? userProfilePic;
  final String? productId;
  final String? review;
  final double? rating;
  final List<Image>? image;
  final Timestamp createdAt;


  ReviewModel({
    this.userId,
    this.userName,
    this.userProfilePic,
    this.productId,
    this.review,
    this.rating,
    this.image,
    required this.createdAt,
    // required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    userId: json["userId"],
    userName: json["userName"],
    userProfilePic: json["userProfilePic"],
    productId: json["productId"],
    review: json["review"],
    rating: json["rating"].toDouble(),
    createdAt: json["createdAt"],
    image: json["image"] == null ? [] : List<Image>.from(json["image"]!.map((x) => Image.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "userName": userName,
    "userProfilePic": userProfilePic,
    "productId": productId,
    "review": review,
    "rating": rating,
    "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x.toJson())),
    "createdAt": createdAt,
  };
}

class Image {
  final String? title;
  final String? url;

  Image({
    this.title,
    this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    title: json["title"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "url": url,
  };
}

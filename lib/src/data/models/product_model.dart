// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  final String? productName;
  final double? productPrice;
  final List<ImageGallery>? imageGallery;
  final List<Varient>? varient;
  final String? productDetails;
  final String? brand;

  ProductModel({
    this.productName,
    this.productPrice,
    this.imageGallery,
    this.varient,
    this.productDetails,
    this.brand,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    productName: json["product_name"],
    productPrice: json["product_price"],
    imageGallery: json["image_gallery"] == null ? [] : List<ImageGallery>.from(json["image_gallery"]!.map((x) => ImageGallery.fromJson(x))),
    varient: json["varient"] == null ? [] : List<Varient>.from(json["varient"]!.map((x) => Varient.fromJson(x))),
    productDetails: json["product_details"],
    brand: json["brand"],
  );

  Map<String, dynamic> toJson() => {
    "product_name": productName,
    "product_price": productPrice,
    "image_gallery": imageGallery == null ? [] : List<dynamic>.from(imageGallery!.map((x) => x.toJson())),
    "varient": varient == null ? [] : List<dynamic>.from(varient!.map((x) => x.toJson())),
    "product_details": productDetails,
    "brand": brand,
  };
}

class ImageGallery {
  final String? title;
  final String? url;

  ImageGallery({
    this.title,
    this.url,
  });

  factory ImageGallery.fromJson(Map<String, dynamic> json) => ImageGallery(
    title: json["title"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "url": url,
  };
}

class Varient {
  final String? category;
  final List<Item>? items;

  Varient({
    this.category,
    this.items,
  });

  factory Varient.fromJson(Map<String, dynamic> json) => Varient(
    category: json["category"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  final String? title;
  final String? description;

  Item({
    this.title,
    this.description,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
  };
}

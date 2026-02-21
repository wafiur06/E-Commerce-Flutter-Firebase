import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/models.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> fetchProduct() async {
    final List<ProductModel> products = [];
    try {
      final data = await _firestore.collection('products').get();

      for (var product in data.docs) {
        final singleProduct = ProductModel.fromJson(product.data());
        singleProduct.productId = product.id;
        products.add(singleProduct);
      }
      return products;
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }

  Future<ProductModel?> fetchSingleProduct(String productId) async {
    try {
      final data = await _firestore.collection('products').doc(productId).get();

      if (data.data() != null) {
        final product = ProductModel.fromJson(data.data()!);
        product.productId = data.id;
        return product;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }

  Future<ReviewModel?> submitReviewRating(ReviewModel review) async {
    try {
      final data = await _firestore
          .collection('products')
          .doc(review.productId)
          .collection('reviews')
          .add(review.toJson());
      final document = await data.get();

      if (document.data() != null) {
        final review = ReviewModel.fromJson(document.data()!);
        return review;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }

  Future<List<ReviewModel>> fetchProductReview(String productId) async {
    List<ReviewModel> reviews = [];
    try {
      final data = await _firestore
          .collection('products')
          .doc(productId)
          .collection('reviews').get();

      if (data.docs.isNotEmpty) {
        for (var review in data.docs) {
          reviews.add(ReviewModel.fromJson(review.data()));
        }
      }
      return reviews;
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }
}

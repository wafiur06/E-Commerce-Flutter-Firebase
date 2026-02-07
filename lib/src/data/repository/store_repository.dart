import 'package:bloc_app/src/data/dummy/dummy_brands.dart';
import 'package:bloc_app/src/data/dummy/dummy_products.dart';
import 'package:bloc_app/src/data/models/brand_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as product;

class StoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createNewBrand() async {
    try {
      for (var brand in dummyBrand) {
        await _firestore
            .collection('brands')
            .add(brand.toJson()); //must be same in firebase
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> createProducts() async {
    try {
      for (var product in dummyProduct) {
        await _firestore
            .collection('products')
            .add(product.toJson()); //must be same in firebase
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> fetchBrands() async {
    final List<BrandModel> brandList = [];
    final brandsSnapshot = await _firestore.collection('brands').get();

    for (var brand in brandsSnapshot.docs) {
      brandList.add(BrandModel.fromJson(brand.data()));
    }
  }
}
